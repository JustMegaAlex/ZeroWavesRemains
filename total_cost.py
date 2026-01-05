import json
from pathlib import Path

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
text = re.sub(r'(?P<a>\b\w+?\b:)', '"\g<a>":', text)
text = re.sub(r',(?=\n +})', '', text)
# print(text)

with open('cost.json', 'w') as f:
    f.write(text)

balance = json.loads(text)

cost = 0
for weapon in balance.values():
    if not isinstance(weapon, dict):
        continue
    cost += weapon.pop('weapon_cost', 0)
    for k, v in weapon.items():
        if not isinstance(v, list):
            continue
        cost += sum(v)
print(f'{cost=}')