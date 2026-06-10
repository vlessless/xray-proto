#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define directories based on the script location (PROJECT_DIR/scripts/compile.sh)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
OUTPUT_DIR="${PROJECT_ROOT}/src/xray_proto"

# Read xray-core path from arguments
XRAY_SRC_DIR="$1"

# 1. Guard check: Verify that the xray-core path argument was provided
if [ -z "$XRAY_SRC_DIR" ]; then
    echo "Error: Missing required argument [path_to_xray_core]." >&2
    echo "Usage: $0 <path_to_xray_core>" >&2
    exit 1
fi

# 2. Guard check: Convert to absolute path and verify Xray source directory exists
XRAY_SRC_DIR="$(cd "$XRAY_SRC_DIR" 2>/dev/null && pwd || true)"
if [ ! -d "$XRAY_SRC_DIR" ]; then
    echo "Error: Provided Xray source directory does not exist or is invalid." >&2
    echo "Path given: $1" >&2
    exit 1
fi

# 3. Guard check: Verify required python packages are available in the current active environment
echo "Verifying environment dependencies..."
if ! python3 -c "import grpc_tools.protoc, mypy_protobuf" 2>/dev/null; then
    echo "Error: Required modules (grpcio-tools, mypy-protobuf) are not accessible." >&2
    echo "Please ensure your virtual environment is active or run via 'uv run'." >&2
    exit 1
fi

# 4. Prepare target directory
mkdir -p "$OUTPUT_DIR"

# Clean up old generated files to avoid stale configurations from older Xray versions,
# but strictly preserve our root __init__.py which contains the runtime path modifications.
echo "Cleaning up old generated files from: $OUTPUT_DIR"
find "$OUTPUT_DIR" -mindepth 1 -maxdepth 1 ! -name '__init__.py' -exec rm -rf {} +

echo "Compiling xray-core protobuf definitions..."
cd "$XRAY_SRC_DIR"

# 5. Run compilation
# Используем напрямую python3, так как контекст окружения uv run уже проброшен сверху из Workflow
python3 -m grpc_tools.protoc \
    -I . \
    --python_out="$OUTPUT_DIR" \
    --grpc_python_out="$OUTPUT_DIR" \
    --mypy_out="$OUTPUT_DIR" \
    --mypy_grpc_out="$OUTPUT_DIR" \
    $(find . -name "*.proto")

# 6. Post-processing: Recursively create __init__.py files in all generated subdirectories
echo "Generating __init__.py files for package structure..."
find "$OUTPUT_DIR" -type d | while read -r dir; do
    if [ ! -f "$dir/__init__.py" ]; then
        touch "$dir/__init__.py"
    fi
done

echo "Success! Fully native protobuf package generated in: $OUTPUT_DIR"