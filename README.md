# xray-proto

Auto-generated, native Python gRPC stubs and types for **Xray-core** (`XTLS/Xray-core`).

This library provides fully compiled Python modules and static type hints (`.pyi`) for the entire Xray-core API, allowing seamless asynchronous or synchronous gRPC communication with an Xray daemon from Python backends.

## Who is this for?

This library is designed for backend developers, infrastructure engineers, and systems administrators building tools around the Xray/V2Ray ecosystem. 
* **VPN Management Services:** Automate user management, add/remove inbound/outbound proxies, and query active sessions dynamically.
* **Monitoring & Metrics:** Fetch real-time traffic statistics and system state from the Xray core daemon.
* **Dynamic Routing:** Modify routing rules and core behavior on the fly via high-performance gRPC calls.

---

## Architecture & Versioning

To preserve historical accuracy and isolate dependencies, this repository adopts a **one-branch-per-release** strategy:
* `main`: Contains the core compilation tools, automated GitHub Actions pipelines, and metadata configs. It does **not** contain generated code.
* `release/v<Xray-Version>`: Dedicated branches containing the compiled python stubs tailored strictly to that specific Xray-core release version.

The library package versions map directly to Xray-core releases using the format:
`X.Y.Z.Patch` (e.g., library version `24.11.30.0` maps directly to Xray-core `v24.11.30`).

---

## Installation

### From PyPI
You can install the official wheels compiled for stable Xray-core versions:
```bash
# Using uv (recommended)
uv add xray-proto

# Using pip
pip install xray-proto