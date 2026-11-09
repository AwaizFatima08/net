# Prep Simulator for NET (HomiLabs) — project notes

Flutter Android app for the NUST Entry Test (NET), the undergraduate admission test of the National University of
Sciences and Technology, Pakistan: 20 full-length NET-Engineering mocks (Mathematics 100, Physics 60, English 40 = 200
MCQs, 3 hours, no negative marking), subject-wise practice for every NET subject, and a guide (papers, admission rules,
merit formula, test day, tips, formula sheets). No login, offline. Package `net_prep`, app id `com.homilabs.net_prep`
(locked after the first Play upload). Launcher name "NET Prep". Built on the CSCA/NLE/NTS engine.

## Locations
- Code: `/mnt/storage/projects/net` · GitHub `AwaizFatima08/net` (PUBLIC repo: no secrets)
- Local backup: `/mnt/storage/project_backups/net_backup` · Google Drive: https://drive.google.com/drive/folders/1jkXz7ywkNuDhy4AAcFDy3Er4HxZtxyM4 (Projects/net)
- Backups: `bash scripts/backup.sh` (all three layers)
- Site: https://net.homilabs.org (Hostinger `public_html/net`, an SSH git checkout of the `deploy` branch), source in `website/`, `bash scripts/publish-site.sh`

## Scope (Homi, 9 Nov 2026)
Mocks are NET-Engineering only. Chemistry, Biology (NET-Applied Sciences) and Quantitative Mathematics (NET-Business)
are practice-only sections. Do not add other streams' mocks unless Homi asks.

## Exam format (nust.edu.pk, checked 9 Nov 2026; details in docs/research/net-research.md)
Every NET paper: 200 four-option MCQs, 3 h, 1 mark each, no negative marking; CBT in Islamabad and Quetta, paper-based in
Karachi and Gilgit. Weights since NET-2025: Engineering Maths 50 / Physics 30 / English 20 % (Chemistry, CS and
Intelligence dropped). NUST gives only percentages: the 100/60/40 counts are ours. Merit: NET 75, HSSC 15, SSC 10.
Topic weights per mock are ours (FSc chapters) in `tool/make_blueprint.py`.

## Content
- `content/bank/<section>/<topic>.jsonl` (format in `docs/content-schema.md`, quality bar `docs/writer-brief.md`),
  guide source `content/guide_src.py` (run it to rebuild `content/guide.json`; dated facts live there: series, fees, rules).
- `python3 tool/validate.py`, `python3 tool/build_content.py` (fixed seeds: papers stay stable), `tool/blind.py` and
  `tool/blind_shift.py` (independent answer check, log in `docs/blind-check.md`). `flutter test test/content` checks the papers.
- Every item is original HomiLabs work. Never copy NUST sample tests, past or recalled NET papers, FSc textbook exercises
  or prep books/sites. Items for a human look: `docs/review-flags.md`.
- Re-check `content/guide_src.py` facts (series dates, fees) when each NET series opens.

## Ads
Ids in `config/admob.json`. Banner on Home tabs only; interstitial when leaving results or a practice set, 5 minutes
apart. Never on mock, review or practice question screens. Debug builds use Google test units;
`bash scripts/check-release-ad-ids.sh` before a release build.

## Gate before commit
```
dart format --set-exit-if-changed lib test
flutter analyze
flutter test
```
Heavy jobs follow `~/.claude/heavy-jobs.md`: use `jobq`, then `./gradlew --stop`.
