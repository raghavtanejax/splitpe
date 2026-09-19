import os
import re

files_to_edit = [
    'lib/views/pos_checkout_view.dart',
    'lib/views/group_split_view.dart',
    'lib/views/savings_calculator_view.dart'
]

def wrap_scaffold(path):
    if not os.path.exists(path):
        return
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    if "import '../widgets/mesh_background.dart';" not in content:
        content = content.replace("import '../theme/app_theme.dart';", "import '../theme/app_theme.dart';\nimport '../widgets/mesh_background.dart';")
    
    content = content.replace("return Scaffold(", "return MeshBackground(child: Scaffold(")
    
    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f'Wrapped Scaffold in {path}')

for file in files_to_edit:
    wrap_scaffold(file)
