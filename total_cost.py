import json
from pathlib import Path
from types import SimpleNamespace
from json_utils import json_to_object

pth = Path('scripts/Balance/Balance.gml')
with open(pth) as f:
    text = f.read()

text = text[text.find('costs: {'):]
text = text[text.find(' {'):]

import re
before = list(re.finditer('},\n +coins:', text))[0].start()
text = text[:before]
# print(text)

text = re.sub(r',\n +$', '', text)
text = re.sub(r'//.+?\n', '\n', text)
text = re.sub(r'(?P<a>\b\w+?\b:)', r'"\g<a>":', text)
text = re.sub(r',(?=\n +})', '', text)
# print(text)

with open('cost.json', 'w') as f:
    f.write(text)

# Convert JSON to objects with attribute access
balance = json_to_object(text)

cost = 0
for weapon in balance.__dict__.values():  # Access attributes instead of dict values
    if not isinstance(weapon, SimpleNamespace):
        continue
    cost += getattr(weapon, 'weapon_cost', 0)  # Use getattr instead of pop
    for k, v in weapon.__dict__.items():  # Access attributes
        if not isinstance(v, list):
            continue
        cost += sum(v)
print(f'{cost=}')

# Alternative: keep original dict access if preferred
# balance_dict = json.loads(text)
# cost = 0
# for weapon in balance_dict.values():
#     if not isinstance(weapon, dict):
#         continue
#     cost += weapon.pop('weapon_cost', 0)
#     for k, v in weapon.items():
#         if not isinstance(v, list):
#             continue
#         cost += sum(v)
# print(f'{cost=}')