# -*- coding: utf-8 -*-
"""Auto-generated gRPC bindings for xray-core."""

import sys
from pathlib import Path

# Получаем абсолютный путь к директории src/xray_proto на машине
GENERATED_ROOT = str(Path(__file__).parent.resolve())

# Добавляем этот путь в начало списка поиска модулей Python (sys.path).
# Это позволяет интерпретатору находить папки 'app', 'common' и др.
# напрямую, решая проблему ModuleNotFoundError в автогенерированном коде.
if GENERATED_ROOT not in sys.path:
    sys.path.insert(0, GENERATED_ROOT)