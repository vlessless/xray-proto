# -*- coding: utf-8 -*-
"""Auto-generated gRPC bindings for xray-core with absolute package prefix support."""

import sys

# Define the root namespace under which this library is installed
PACKAGE_PREFIX = "xray_proto"

# List of all top-level packages generated from the Xray-core source tree
XRAY_MODULES = [
    "app",
    "common",
    "core",
    "proxy",
    "transport",
]

# Aliasing mechanism via sys.modules to guarantee that internal relative imports
# mapped by protoc (e.g., 'from app.proxyman ...') resolve down cleanly to the
# absolute installation target namespace (e.g., 'xray_proto.app.proxyman ...')
for module_name in XRAY_MODULES:
    target_alias = f"{PACKAGE_PREFIX}.{module_name}"

    # Inject the alias into the global runtime module cache if it's missing
    if module_name not in sys.modules:
        try:
            # Dynamically import the absolute package to boot up its namespace
            __import__(target_alias)
            # Route the plain short-name requests directly to our prefixed package instance
            sys.modules[module_name] = sys.modules[target_alias]
        except ImportError:
            # Fail silently during intermediate build states or empty initializations
            pass