from dataclasses import dataclass, asdict
import json
from types import SimpleNamespace
from typing import Any, Dict

from pydantic import BaseModel


def json_to_object_simple(json_str: str) -> Any:
    """Convert JSON string to object with attribute access using SimpleNamespace."""
    return json.loads(json_str, object_hook=lambda d: SimpleNamespace(**d))


def json_to_object_custom(json_str: str) -> Any:
    """Convert JSON string to custom object with attribute access."""
    class JSONObject:
        shortcut_map = {
            'session_id': 'sid',
            'user_id': 'uid',
            'difficulty': 'diff'
        }
        def __init__(self, data):
            if isinstance(data, dict):
                for key, value in data.items():
                    if key == 'data':
                        setattr(self, key, JSONObject(json.loads(value)))
                    elif key == 'weapons':
                        setattr(self, key, self.parse_weapons(value))
                    elif isinstance(value, dict):
                        setattr(self, key, JSONObject(value))
                    elif isinstance(value, list):
                        setattr(self, key, [JSONObject(item) if isinstance(item, dict) else item for item in value])
                    else:
                        setattr(self, self.short(key), value)
            elif isinstance(data, list):
                # For lists, create an object that behaves like a list but with attribute access
                self._items = [JSONObject(item) if isinstance(item, dict) else item for item in data]
        
        def parse_weapons(self, data):
            return {
                k: JSONObject(v) for k,v in data.items()
            }

        def short(self, key):
            return self.shortcut_map.get(key, key)

        def __repr__(self):
            if hasattr(self, '_items'):
                return f"{self.__class__.__name__}({self._items})"
            return f"{self.__class__.__name__}({self.__dict__})"

        def __getitem__(self, index):
            if hasattr(self, '_items'):
                return self._items[index]
            return None

        def __len__(self):
            if hasattr(self, '_items'):
                return len(self._items)
            return 0

        def __iter__(self):
            if hasattr(self, '_items'):
                return iter(self._items)
            return iter([])

    parsed = json.loads(json_str)
    return JSONObject(parsed)


@dataclass
class Weapon:
    name: str
    time: int = 0
    upgrades: int = 0

@dataclass
class WeaponStats:
    pulse: Weapon = None
    scatter: Weapon = None
    snipe: Weapon = None

@dataclass
class Play:
    diff: int
    weapons: WeaponStats
    time: int = 0

@dataclass
class Stats:
    time_total: int
    plays: list[Play]
    is_dev: bool = False

    # def __str__(self) -> str:
    #     res = '=' * 20 + '\n'
    #     res += f'{}'

def parse_time(seconds: int):
    minutues = int(seconds // 60)
    seconds = int(seconds % 60)
    if minutues < 10:
        minutues = f'0{minutues}'
    if seconds < 10:
        seconds = f'0{seconds}'
    return f'{minutues}:{seconds}'

# Example usage
with open('analytics.json') as f:
    db = f.read()

db = json_to_object_custom(db)

db_map: dict[str, Stats] = {}
for i, entry in enumerate(db):
    data = entry.data
    stats = db_map.get(entry.sid)
    if not stats:
        stats = Stats(data.time_total, [])
        db_map[entry.sid] = stats

    stats.is_dev = stats.is_dev or getattr(data, 'is_dev', None)
    stats.time_total = parse_time(data.time_total)

    if data.plays_total >= len(stats.plays):
        play = Play(data.diff, WeaponStats())
        stats.plays.append(play)
    else:
        play = stats.plays[-1]
    play.time = data.play_time
    try:
        for name, data_weap in data.weapons.items():
            name = name.lower()
            try:
                weap: Weapon = getattr(play.weapons, name)
                if not weap:
                    weap = Weapon(name)
                    setattr(play.weapons, name, weap)
            except AttributeError:
                weap = Weapon(name)
                setattr(play.weapons, name, weap)
            weap.time = data_weap.time
            weap.upgrades = data_weap.upgrades
    except AttributeError:
        pass

# out = {sid: asdict(stats) for (sid, stats) in db_map.items()}
out = [asdict(el) for el in db_map.values()]
out.sort(key=lambda el: el['time_total'], reverse=True)

with open('stats.json', 'w') as f:
    json.dump(out, f, indent=2)
print('stats.json')
