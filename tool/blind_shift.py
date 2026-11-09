#!/usr/bin/env python3
"""Like `blind.py compare`, but tolerates a solver whose answers slipped by a few positions.
A mismatch counts as a slip when the solver's answer for a nearby id (±1..3) equals this key and
the solver's answer at this id equals a nearby key. Prints only the genuine disagreements and notes.
  python3 tool/blind_shift.py <solver.jsonl> <export.jsonl> bank files...
"""
import json, sys
from pathlib import Path

solved_path, export_path, *files = sys.argv[1:]
solved = {r["id"]: r for r in map(json.loads, Path(solved_path).read_text().split("\n")) if r} if False else {}
for line in Path(solved_path).read_text().splitlines():
    if line.strip():
        r = json.loads(line); solved[r["id"]] = r
order = [json.loads(l)["id"] for l in Path(export_path).read_text().splitlines() if l.strip()]
bank = {}
for f in files:
    for line in Path(f).read_text().splitlines():
        if line.strip():
            r = json.loads(line); bank[r["id"]] = r
keys = [bank[i]["answer"] for i in order]
got = [solved.get(i, {}).get("answer") for i in order]
real = slips = 0
for n, qid in enumerate(order):
    note = solved.get(qid, {}).get("note")
    if got[n] == keys[n] and not note:
        continue
    near = [m for m in range(max(0, n - 3), min(len(order), n + 4)) if m != n]
    if not note and any(got[m] == keys[n] for m in near) and any(keys[m] == got[n] for m in near):
        slips += 1
        continue
    real += 1
    q = bank[qid]
    print(f"CHECK {qid}: key {keys[n]}, solver {got[n]}. {note or ''}\n  {q['stem'][:200]}\n  {q['options']}")
print(f"{len(order) - real - slips} agree, {slips} probable slips, {real} to check")
