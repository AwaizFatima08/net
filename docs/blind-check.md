# Blind answer check (9 Nov 2026)

Every item is re-solved by an independent agent from an answer-free export (`tool/blind.py export`), then compared
(`tool/blind.py compare`, `tool/blind_shift.py` for answers saved one row out of place). Every disagreement is
re-solved by hand here; the outcome is listed.

| Batch | Files | Items | Result |
|---|---|---|---|
| b1 | math numbers, matrices | 300 | 299 agree; mx-p0008 solver error (|−A| = (−1)³·3 = −3, key right) |
| b2 | math quadratic, binomial | 300 | 300 agree |
| b3 | math sequences, counting | 320 | 298 agree, 19 row slips; ms-t0080, ms-t0122, ms-t0125 solver errors (keys right) |
| b4 | math trig, trig-2 | 315 | 305 agree, 9 row slips; mt-t0261 note only (solver agrees with key x = nπ) |
| b6 | math differentiation, differentiation-2 | 250 | 250 agree |
| b5 | math functions, lines | 325 | 323 agree; ml-t0071, ml-t0072 solver errors (keys right) |
| b7 | math integration, integration-2, vectors | 345 | 300 agree, 39 row slips; mi-t0165, t0175, t0176, t0187, p0004, p0013 solver errors (keys right) |
| b9 | math conics, physics magnetism | 280 | 265 agree, 13 row slips; mo-t0103, pm-p0010 solver errors (keys right) |
| b8 | physics circular, current; english synonyms | 410 | 410 agree |
| b10 | physics motion, modern | 260 | 260 agree |
| b11 | physics waves, electronics, electrostatics | 285 | 284 agree; pe-p0013 wording fixed (electron moves against the field) |
| b12 | physics energy, oscillations, measurement, fluids | 315 | 286 agree, 24 row slips; po-t0009, t0019, t0021, t0025, t0026 solver errors (keys right) |
| b13 | physics optics, thermo | 190 | 190 agree |
| b14 | english antonyms, analogies, grammar | 350 | 350 agree |
| b15 | english reading (s001-s025) | 75 | 75 agree; paragraph references reworded (passages are one block) |
| b16 | english completion | 195 | 195 agree |
| b17 | quant (all topics, practice) | 170 | 170 agree |
| b18 | biology (all topics, practice) | 210 | 210 agree |
| b19 | english grammar-2 | 120 | 119 agree; ee-t0148 stem fixed ('last week' removes the mixed-conditional reading) |
| b20 | chemistry (all topics, practice) | 214 | 214 agree |

Near-duplicate scan (stem + options, all sections): one exact duplicate across pools, mt-t0117 / mt-p0018; the practice item was rewritten (cos 20° cos 40° cos 60° cos 80° = 1/16).
| b21 | english reading-2 | 75 | 75 agree |

**Total: 5,304 items, every key independently re-solved; 0 wrong keys found; 4 wording fixes (pe-p0013, ee-t0148, er-t0018/t0069/t0070 paragraph references) and 1 duplicate rewritten.**
