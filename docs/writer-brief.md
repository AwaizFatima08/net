# Writer brief: Prep Simulator for NET

You write original single-answer multiple-choice questions for a HomiLabs Android app that prepares Pakistani
students (FSc Pre-Engineering, ICS, Pre-Medical, A-level and overseas Pakistani applicants) for the NUST Entry Test
(NET), the undergraduate admission test of the National University of Sciences and Technology, Islamabad. NET is
computer-based, 4-option single-answer MCQs, **no calculator**, about 54 seconds per question, at FSc Part I and II
(HSSC) level. Accuracy matters more than speed: one wrong key destroys trust.

## Format
Read `docs/content-schema.md` and `content/blueprint.json` (your topic's prefix, counts and scope). Write
`content/bank/<section>/<file>.jsonl` with the ids given in your task. Write in chunks of at most 25 questions per
tool call, appending with Bash heredocs (`cat >> file <<'EOF'`), and run `python3 tool/validate.py --files <your files>`
after each chunk until it reports 0 errors and no WARN.

## Check every answer
Before writing each question, solve it yourself step by step. Numbers must come out clean (integers, simple fractions,
simple surds, multiples of π) because there is no calculator. For a batch you are unsure of, verify with a quick
`python3 -c` (plain Python arithmetic; sympy is not guaranteed). Distractors must be wrong for a stated reason.
Never write a question whose correct option you are not certain of. Use g = 10 m/s² unless the stem says otherwise and
state it in the stem when it matters (Pakistani textbooks use 9.8; say which). Give constants in the stem when needed
(e.g. "Take h = 6.6 × 10⁻³⁴ J s", relative atomic masses "H = 1, C = 12, O = 16").

## Question style
- Mirror the NET: short, precise stems; a mix of direct concept questions (about a third), formula application and
  short multi-step problems. Typical lead-ins: "The value of … is", "Which of the following is correct?", "If …, then".
- Level: Punjab / Federal Board FSc textbooks (Part I and II) and their exercises, as NUST says; a good student answers
  in under a minute. Stems under 600 characters; describe any figure fully in words.
- Units: SI. Chemistry: IUPAC names with common names where usual; ions written as Fe³⁺, SO₄²⁻.
- Pakistani settings and names where a context helps (Ali, Ayesha, Hamza, Fatima, Bilal, Zainab, Usman, Sana),
  places like Islamabad, Lahore, Karachi, Peshawar, Quetta. Keep contexts neutral: no politics, no religion.
- English section: standard British spelling, as used in Pakistani schools.

## Options
- Exactly 4 options, one clearly correct. Wrong options come from real mistakes (sign error, forgot to square,
  used diameter for radius, wrong unit conversion, confused oxidising/reducing agent) and are definitely wrong.
- Homogeneous options of similar length and form. Numeric options in ascending or logical order is fine, but the key
  position must still vary: spread keys evenly across A-D with no pattern. The correct option must not stand out by
  length (the validator warns above 40 %; a file with that WARN is not finished).
- No "all/none of the above", no "both A and B".

## Explanations
Teach: the method with the key numbers (e.g. "f′(x) = 3x² − 6x = 0 gives x = 0 or 2; f(2) = −4 is the minimum"), then
why the most tempting wrong option is wrong. 2-6 sentences. Do not start with "The answer is". No citations.

## Levels and variety
About 30 % easy, 50 % medium, 20 % hard. Cover the whole topic scope evenly across both pools. Vary numbers, contexts
and lead-ins; no near-duplicates within or across files (read what already exists in your topic's files first).
Mock items and practice items are equally good; practice items may lean slightly more on core skills.

## Originality
Original work only. Never copy or closely reword questions from NUST's sample tests, past NET papers or "recalled"
papers, FSc textbooks' exercises, prep books (Dogar, Ilmi, Caravan, Kips, Star) or prep sites (e.g. nustrive,
maqsad, topgrade, ilmkidunya).

## Boundaries
Only write the files in your task, plus your scratch folder. Do not edit tools, the blueprint or other topics.
Do not run git. Final reply at most 6 lines: files, question counts, validator result, any items you are unsure about (by id).
