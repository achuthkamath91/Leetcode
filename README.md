# LeetCode Problems — Solutions Repository

This repository collects solved LeetCode problems and small daily puzzle solutions. It is organized so each problem has its own folder with a short README, source files, and optional assets (images, tests).

---

## Repository purpose

- Keep a clean, discoverable record of problem solutions and approaches.
- Share readable, well-documented solutions (multiple languages allowed).
- Make it easy to add, review, and maintain solutions over time.

---

## Top-level layout

- `DailyQuestion/` — problems grouped by problem id or day. Each problem lives in its own folder, for example:
  - `DailyQuestion/1855/`
    - `1855.Maximum Distance Between a Pair of Values.java` (solution source)
    - `Readme.md` (problem, approach, examples)
    - `img.png` (optional assets)
- `.githooks/` — local git hook scripts (optional; see CONTRIBUTING.md)
- `CONTRIBUTING.md` — contribution instructions and local hook setup
- `.gitignore` — repository-wide ignore rules

---

## How to add a new solution

1. Create a new folder for the problem under `DailyQuestion/` named with the problem id (e.g. `1234`).
2. Add the source file(s). Use clear filenames that include the id and a short descriptive title, for example: `1234.LongestAwesome.java`.
3. Add a `Readme.md` file inside the problem folder with:
   - Problem statement (short)
   - One or two example cases
   - Approach summary and complexity
   - (Optional) reference implementation notes and test instructions
4. If you add images or other assets, keep them inside the same folder and reference them relatively from `Readme.md` (e.g. `./img.png`).

Naming conventions (recommended)
- Source files: `<id>.<ShortTitle>.<ext>` (e.g. `1855.Maximum Distance Between a Pair of Values.java`)
- Problem README: `Readme.md` (capitalization as shown)
- Assets: keep in same folder and reference relatively (`./img.png`)

---

## Contribution guidelines

Please keep README files focused on the problem and solution (not addressed prompts). To help avoid accidentally committing assistant-style prompts into READMEs, this repo includes an optional local pre-commit hook:

- To enable the hooks locally, run from the repository root:

```powershell
git config core.hooksPath .githooks
```

- The hook scans staged README files for common personal/assistant-style prompt phrases and blocks the commit if any are found. See `CONTRIBUTING.md` for details.

If you prefer not to use the hook, you can skip the step above — but please still follow the README style guidelines.

---

## Code style and readability

- Keep solutions simple and well-commented.
- Aim for one clear solution per file when possible.
- Prefer small helper functions and descriptive variable names.
- Include complexity analysis (time/space) in the problem `Readme.md`.

---

## Testing your solution locally

- There is no single test runner in this repo. Run or compile files according to the language used (for Java: `javac`/`java`, for Python: run the script with `python`).
- If you add tests, place them next to the solution or include a small `run.sh`/`run.ps1` helper script in the problem folder.

---

## Pull requests and branches

- Create feature branches for significant changes (e.g. `feature/add-1855-solution`).
- Keep PRs focused: one problem or one cleanup task per PR.
- If the repository enforces hooks only locally, consider adding a CI step to scan PRs for policy violations (optional).

---

## License & contact

This repository is a personal collection of solved problems. Add a LICENSE file if you want to share it under a specific open-source license.

If you want me to add a template file for new problems (source + Readme + optional test harness), say which language you prefer and I will create it.
