import os
import re

files_to_edit = [
    'lib/views/pos_checkout_view.dart',
    'lib/views/group_split_view.dart',
    'lib/views/savings_calculator_view.dart',
    'lib/widgets/qr_tranche_card.dart',
    'lib/widgets/fallback_routing_modal.dart',
    'lib/widgets/split_checkout_modal.dart',
    'lib/widgets/splitpe_logo.dart'
]

def replace_in_file(path):
    if not os.path.exists(path):
        return
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 1. Imports
    content = content.replace("import 'package:neopop/neopop.dart';", "import '../widgets/glass_components.dart';")
    content = content.replace("import '../widgets/neopop_components.dart';", "import '../widgets/glass_components.dart';")
    
    # 2. Components mapping
    content = content.replace("NeoPopCard(", "GlassCard(")
    content = content.replace("NeoPopSurfaceCard(", "GlassCard(")
    content = content.replace("NeoPopPillBadge(", "GlassBadge(")
    content = content.replace("NeoPopActionButton(", "GlassButton(")
    
    # 3. NeoPopButton replacements
    content = re.sub(r'NeoPopButton\(', r'GlassButton(', content)
    content = re.sub(r'onTapUp:\s*', r'onTap: ', content)
    content = re.sub(r'bottomShadowColor:.*?,', r'', content)
    content = re.sub(r'rightShadowColor:.*?,', r'', content)
    content = re.sub(r'buttonPosition:.*?,', r'', content)
    content = re.sub(r'depth:.*?,', r'', content)
    content = re.sub(r'border:\s*Border\.all\([^)]+\),', r'', content, flags=re.DOTALL)
    
    # 4. NeoPopTiltedButton
    content = re.sub(r'NeoPopTiltedButton\(', r'GlassButton(', content)
    content = re.sub(r'isFloating:\s*true,', r'', content)
    content = re.sub(r'decoration:\s*const\s*NeoPopTiltedButtonDecoration\([^)]+\),', r'color: AppColors.primaryBlue,', content, flags=re.DOTALL)
    
    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f'Processed {path}')

for file in files_to_edit:
    replace_in_file(file)
