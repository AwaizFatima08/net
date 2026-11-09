#!/usr/bin/env python3
"""Moves correct options so a pool's keys spread evenly over A-D (swaps the key with the option at the target
position). Skips items whose text names an option letter. Deterministic.
  python3 tool/rebalance_keys.py <file.jsonl> <pool>"""
import json, random, re, sys
from pathlib import Path

path, pool = Path(sys.argv[1]), sys.argv[2]
rows = [json.loads(l) for l in path.read_text().splitlines() if l.strip()]
items = [r for r in rows if r.get("pool") == pool and not re.search(r"option [A-D]\b|\([A-D]\)", r["stem"] + r["explanation"])]
targets = [i % 4 for i in range(len(items))]
random.Random(path.name + pool).shuffle(targets)
moved = 0
for r, t in zip(items, targets):
    a = r["answer"]
    if a != t:
        r["options"][a], r["options"][t] = r["options"][t], r["options"][a]
        r["answer"] = t
        moved += 1
path.write_text("".join(json.dumps(r, ensure_ascii=False) + "\n" for r in rows))
print(path.name, pool, "moved", moved)
