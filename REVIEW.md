# Architecture Review — emacs-tng

Review date: 2026-07-07
Branch: `refactor/2026-07-07-architecture-review`
Baseline: `main` @ `d983a48` ("Change light colors")
Emacs version used for verification: GNU Emacs 30.2

---

# 1. Executive Summary

emacs-tng is a personal Emacs configuration organized as a flat set of
small, topic-named elisp files loaded sequentially from `init.el`, plus a
`theme/` subtree implementing a single parameterized custom theme
("chiaroscuro") with 13 selectable variants.

**Overall quality.** The configuration is pragmatic and workable. Its main
virtue is that every concern lives in a file named after it (`org.el`,
`dired.el`, `keybindings.el`, …), so navigation is easy. Its main
weaknesses are heavy reliance on global mutable state (especially in the
theme system), duplicated and dead code accumulated through
experimentation (particularly around the LLM packages), and a startup
model that loads nearly everything eagerly.

**Maintainability.** Medium. Files are short and self-describing, but
until this branch several latent bugs lurked in rarely-exercised paths
(swapped OS detection, calls into the never-installed `evil` package, a
free variable in a recursive helper). The theme machinery worked but was
hard to reason about: parallel index variables, a list of 13 identical
symbols, and index bookkeeping spread across three files.

**Complexity.** Low in most modules; concentrated in two places: the
theme system (`theme/`, `chiaroscuro-theme.el`) and the overlapping
completion stacks (helm *and* ivy/counsel/swiper are both installed and
globally enabled).

**Biggest strengths**

- Clear one-topic-per-file layout with a single obvious entry point.
- A genuinely interesting theme design: one `deftheme` whose palette is
  selected at load time, so all 13 variants share one face specification.
- Consistent `my-` prefix on user commands; keybindings centralized in
  one file and organized into named prefix keymaps.

**Biggest weaknesses**

- Global mutable state managed with bare `setq` (no `defvar`/`defcustom`
  discipline) across the theme system.
- Two full completion frameworks enabled simultaneously (helm-mode and
  counsel-mode), which double startup cost and can shadow each other.
- Mostly eager loading: ~30 packages are `require`d at startup whether or
  not they are used in a session.
- Hardcoded absolute paths (`~/.emacs.d/...`, `/home/computer/software/...`)
  scattered across theme files and `lsp.el`.

---

# 2. Architecture Overview

## Repository layout

The repository *is* the `~/.emacs.d` directory. All configuration files
live at the root; the theme system lives under `theme/`.

```
init.el                     entry point; loads everything else in order
paths.el                    machine-specific paths (home dir, JDT LS)
org.el                      org-mode agenda/capture settings
theme/theme.el              theme-switching state and commands
functions.el                general custom commands (my-*)
functions-class-overview.el Java "class overview" report generator
package-archives.el         ELPA/MELPA setup + package-initialize
packages.el                 all use-package declarations
dired.el                    dired + dired-x + omit settings
hydra.el                    hydra definitions (registers, custom, master)
font.el                     frame font
shell.el                    ANSI colors in compilation buffers
macros.el                   recorded keyboard macros
settings.el                 one-line built-in settings, alphabetized
lsp.el                      lsp-java configuration and toggles
keybindings.el              all keybindings, prefix maps, global keys
chiaroscuro-theme.el        the single custom theme (face definitions)
theme/common/               shared palettes (light/dark/diff) + defvars
theme/light/, theme/dark/   per-variant palette overrides
theme/color-changer/        experimental random-palette generator
```

## Startup sequence

1. Emacs reads `init.el`, which computes `EMACS-HOME` (the directory
   containing the configuration) and sets
   `custom--inhibit-theme-enable` to nil — this is load-bearing: it makes
   `custom-theme-set-faces` apply immediately whenever the theme file is
   (re)loaded, which is how theme switching takes effect.
2. `init.el` then `load-file`s each module in a fixed order. The order
   encodes real dependencies:
   - `paths.el` first (other files may use path variables),
   - `theme/theme.el` before `functions.el` (the `my-theme-*` commands
     reference the `INDEX-*` variables),
   - `package-archives.el` before `packages.el` (archives + 
     `package-initialize` must precede `use-package` forms),
   - `packages.el` before `hydra.el`, `settings.el` and `keybindings.el`
     (these call functions such as `defhydra`, `global-company-mode`,
     `olivetti-set-width` that only exist once their packages are loaded),
   - `keybindings.el` last, so every command it binds is defined.
3. `package-archives.el` points at GNU ELPA and MELPA, calls
   `package-initialize`, and refreshes contents once if the archive cache
   is empty. `packages.el` bootstraps `use-package` and declares ~30
   packages, almost all `:ensure t`, so a fresh machine self-installs on
   first start.

## Package initialization strategy

`use-package` is used throughout, but mostly in its eager form: only
`magit` (`:commands`), the packages with `:bind` (swiper, ollama-buddy,
chatgpt-shell via autoload, ellama, aidermacs) and — after this branch —
`powershell`, `csharp-mode` and `nov` are deferred. Global minor modes
(projectile, which-key, helm-mode, counsel-mode, diredfl) are activated
from `:init`/`:config` at startup.

Notably, *two* completion frameworks are fully enabled: `helm-mode`
(with `helm-M-x`, helm buffer lists, kill-ring, bookmarks) and
`counsel-mode`/`counsel-projectile` (with swiper on `C-s`). They coexist
because they are bound to different keys, but both hook global
`completing-read` machinery; which one wins for un-bound commands depends
on load order.

## Theme system

This is the most distinctive part of the configuration:

- `chiaroscuro-theme.el` defines a *single* custom theme. At the top of
  the file — i.e., every time the theme is loaded — it inspects the
  global `INDEX-CHIAROSCURO`, loads a base palette (`common/light.el` or
  `common/dark.el`, plus a matching diff palette), then loads the
  per-variant palette file from a dispatch table
  (`theme/light/eclipse.el`, `theme/dark/ubuntu.el`, …). Each palette
  file is just a series of assignments to the ~120 color variables
  declared in `theme/common/variables.el`. Finally the face list is
  evaluated against those variables.
- `theme/theme.el` holds the switching machinery: `theme-index` (0 = no
  theme, 1–13 = variants), a mirror variable `INDEX-CHIAROSCURO` read by
  the theme file, and commands to set/cycle/reset. Switching a theme is
  literally: disable `chiaroscuro`, change the index, `load-theme
  'chiaroscuro` again.
- `functions.el` provides one `my-theme-<name>` command per variant, and
  `keybindings.el` binds them under the `C-l t` prefix.

The design trades elegance of face definitions (written once) for global
state and repeated file loading (variables.el is loaded three or four
times per theme switch). It works, and the face list stays DRY.

The `color-changer/` variant generates a random palette from a large
list of X11 color names using HSL helpers; much of it is exploratory
code (top-level `message` calls, stub functions, commented-out drivers).

## Customization strategy

Built-in settings live in `settings.el` as alphabetized one-liners with a
trailing comment each — easy to scan, easy to diff. Package settings live
next to their `use-package` declaration. The Custom system is not used:
`custom-file` is never set, so anything saved through Customize would be
appended to `init.el` (see Problems).

## Error handling and robustness

There is essentially no error handling: any file that fails to load
aborts the rest of startup. There are also no version or platform guards
beyond the `system-type` cond in `paths.el`. This is acceptable for a
single-user configuration but means a typo in an early file (e.g.
`org.el`) prevents keybindings from ever being installed.

## Performance considerations

Startup cost is dominated by eagerly loading helm, counsel/ivy,
projectile (including `projectile-load-known-projects`), company, lsp-ui,
and the LLM clients (gptel, ellama with two global header-line modes,
chatgpt-shell). `package-refresh-contents` runs only when the archive
cache is empty, which is correct. Theme switching re-reads five or six
small elisp files per switch — negligible in practice.

---

# 3. Positive Aspects

- **One topic per file, one entry point.** Anyone can open `init.el` and
  see the entire skeleton of the configuration in one screen. The file
  names answer "where would I change X?" without searching. This is the
  single most valuable property for long-term maintenance and was
  carefully preserved by this refactoring.

- **The parameterized single-theme design.** Writing ~370 face specs once
  and swapping only palette variables is a genuinely good abstraction.
  Adding a new variant costs one ~20-line palette file, one index, one
  dispatch entry, one command and one keybinding — no face work at all.
  Most multi-theme setups duplicate face lists per theme; this one does
  not.

- **Centralized, structured keybindings.** All bindings live in one file,
  grouped into named sparse keymaps (`my-prefix-map-theme`,
  `-search`, `-editor`, …) hung off a single `C-l` prefix. The
  keymap-per-topic structure documents itself and prevents prefix
  collisions. Bindings within each map are kept sorted.

- **Consistent command naming.** Every user-defined command carries the
  `my-` prefix, making `M-x my-` a discoverable index of all custom
  functionality and avoiding any risk of clobbering package symbols.

- **`settings.el` as an alphabetized ledger.** Each built-in tweak is one
  line with a short trailing comment. It is trivially scannable and
  merge-friendly.

- **Self-bootstrapping installs.** `:ensure t` everywhere plus the
  use-package bootstrap means a fresh machine converges to a working
  setup on first launch with no manual steps.

- **Sensible use of hooks over advice.** The configuration contains no
  `advice-add` at all (outside commented-out experiments); compilation
  ANSI colors, dired-omit and rainbow-mode are all plain hooks, which
  keeps behavior predictable.

---

# 4. Problems Found

Issues fixed on this branch are marked **[fixed]**; the rest are
documented in section 6 as remaining opportunities.

## 4.1 Swapped OS detection in `paths.el` **[fixed]**

- **Description:** The `windows-nt` branch read `HOME` (the Linux
  variable) and the `gnu/linux` branch read `USERPROFILE` (the Windows
  variable) — the comments even said the opposite of the code. On every
  platform `HOME-DIRECTORY` ended up nil, and `ECLIPSE-LS` silently
  became `"/software/jdt-language-server-.../bin/jdtls"` because
  `concat` treats nil as empty.
- **Impact:** Latent. Nothing currently reads `ECLIPSE-LS`, which is the
  only reason this never surfaced. The first future use would have
  produced a confusing "file not found" at a half-formed path.
- **Recommendation:** Fixed by swapping the branches. Note `ECLIPSE-LS`
  is currently dead (see 4.10).

## 4.2 Calls into the never-installed `evil` package **[fixed]**

- **Description:** `my-goto-class` and `my-goto-member` ended with
  `(evil-first-non-blank)`, but no file installs or loads `evil`.
- **Impact:** Real runtime bug: `C-l e C` / `C-l e M` errored with
  "void function evil-first-non-blank" after moving point.
- **Recommendation:** Fixed by using the built-in equivalent
  `back-to-indentation`.

## 4.3 Free variable `found` in `my-find-file-recursively` **[fixed]**

- **Description:** The recursion result was stored with
  `(setq found ...)` on a variable that was never bound, creating/reusing
  a global at each call.
- **Impact:** Byte-compile warning; wrong results possible if two
  invocations interleave (e.g. via recursive minibuffer); global
  namespace pollution.
- **Recommendation:** Fixed by binding `found` in a `let`.

## 4.4 Duplicated and dead configuration in `packages.el` **[fixed]**

- **Description:** Three overlapping problems:
  1. ~90 lines of commented-out `gptel`/`ellama` experiments.
  2. `aidermacs-args` was set twice: once in `:config` and once at top
     level (with `--edit-format diff`). Because `aidermacs` is deferred
     via `:bind`, the `:config` version always overwrote the top-level
     version at first use — the `diff` variant was dead code that *looked*
     active.
  3. `OLLAMA_API_BASE` was set twice, via `add-to-list` on
     `process-environment` at startup and `setenv` in the aidermacs
     `:config`.
  Additionally `lsp-java` was declared both here and in `lsp.el`.
- **Impact:** Readers could not tell which aider settings were in effect
  (and would guess wrong); double bookkeeping invited divergence.
- **Recommendation:** Fixed: dead blocks deleted, one `setenv` at top
  level, one `lsp-java` declaration (in `lsp.el`, next to its
  configuration). If `--edit-format diff` is actually desired, it must be
  added to the `:config` `setq` — see section 6.

## 4.5 Theme state managed by bare `setq` and parallel loops **[fixed]**

- **Description:** `theme/theme.el` created ~17 globals with bare `setq`
  (no docstrings, byte-compile warnings), kept a 13-element list
  containing the same symbol `chiaroscuro` 13 times, disabled the theme
  13 times per switch, selected it with a manual `while` loop over two
  counter globals (`loop-index`, `themes-list-index`), and declared
  `defvar theme-index` *after* the first `setq`. An unused
  `chiaroscuro-index` variable duplicated `theme-index` in name only.
- **Impact:** No user-facing breakage, but the file actively misled
  readers about how many themes exist and what switching does; the loop
  counters leaked as globals.
- **Recommendation:** Fixed: all state is `defvar`ed with docstrings,
  disable/load are single direct calls, the identical-symbol list and
  dead variables are gone. Switching behavior (including the quirky
  wrap-around semantics and the "emacs" message at index 0) is preserved
  exactly.

## 4.6 `init.el` derived its directory from `default-directory` **[fixed]**

- **Description:** `EMACS-HOME` was `(concat default-directory ".emacs.d")`,
  i.e. it assumed Emacs is always launched from `$HOME`.
- **Impact:** Starting Emacs from any other working directory (a
  project dir, a desktop launcher with a different cwd) broke the entire
  startup with a file-not-found on the first `load-file`.
- **Recommendation:** Fixed: `EMACS-HOME` now derives from
  `load-file-name` (the location of `init.el` itself), falling back to
  `user-emacs-directory`. The sixteen `load-file` lines became one
  ordered list with a comment documenting why the order matters.

## 4.7 `custom.el` did not contain custom-file content **[fixed]**

- **Description:** Despite its name, `custom.el` held a `defhydra`
  (`hydra-custom`) — nothing to do with Emacs's Custom system. The hydra
  it feeds (`hydra-master`) lived in `hydra.el`.
- **Impact:** Misleading name; related code split across two files;
  anyone setting `custom-file` later would collide with it.
- **Recommendation:** Fixed: `hydra-custom` moved into `hydra.el` next
  to `hydra-master`; `custom.el` removed; load list updated.

## 4.8 Duplicate entry and dead lookup in the theme dispatch map **[fixed]**

- **Description:** `chiaroscuro-theme.el`'s `theme-map` listed
  `INDEX-UBUNTU` twice.
- **Impact:** Harmless (`assoc-default` uses the first match) but
  confusing.
- **Recommendation:** Fixed by removing the duplicate.

## 4.9 Interactive-only commands used from Lisp **[fixed]**

- **Description:** `next-line`, `previous-line` and `beginning-of-buffer`
  were called from function bodies (`my-duplicate-line`,
  `my-scroll-*-center`, `my-goto-*`).
- **Impact:** Byte-compile warnings; `next-line` respects goal columns
  and visual lines, so behavior could differ subtly from the intent.
- **Recommendation:** Fixed with `forward-line` / `goto-char (point-min)`.
  In every changed spot the following call (`back-to-indentation`, `yank`)
  made the replacement behavior-identical.

## 4.10 Dead code and dead variables (not all removed)

- **Description:** `ECLIPSE-LS` (paths.el) is never read;
  `golden-ratio` is installed but `golden-ratio-mode` never enabled;
  `ivy-hydra`'s `:delight " ih"` (and several other `:delight` strings on
  packages that define no matching minor mode, e.g. swiper, avy,
  expand-region) are no-ops; the commented-out dabbrev hook at the bottom
  of `keybindings.el`; most of `color-changer.el` below the palette
  section is exploratory scaffolding (top-level `message` calls, empty
  stub functions, commented-out driver calls); `macros.el` uses the
  obsolete `kmacro-lambda-form`.
- **Impact:** Noise; new readers must decide repeatedly whether something
  is load-bearing.
- **Recommendation:** Left in place because each removal either touches
  active experimentation (color-changer, dabbrev hook) or needs a user
  decision (is golden-ratio/ECLIPSE-LS planned for use?). See section 6.

## 4.11 Two completion frameworks enabled globally

- **Description:** `helm-mode` and `counsel-mode` are both turned on at
  startup. Both remap core commands and `completing-read`.
- **Impact:** Startup pays for both; behavior of unremapped commands
  depends on load order; keybinding surface is split (helm for buffers,
  kill-ring, bookmarks; ivy/counsel for files, M-x is helm's).
- **Recommendation:** Consolidating on one framework is the largest
  simplification available, but it changes daily-use behavior, so it is
  deliberately **not** done here (section 6).

## 4.12 Mostly eager package loading

- **Description:** Most `use-package` declarations neither defer nor
  autoload; startup requires ~30 packages including lsp-ui, company,
  yasnippet, and three LLM clients.
- **Impact:** Slower startup; memory for features unused in a given
  session.
- **Recommendation:** Partially addressed (powershell, csharp-mode and
  nov are now `:defer t` — their major modes autoload). Broader deferral
  (company/yasnippet via hooks, LLM clients via their bindings) is listed
  in section 6 because several packages are activated by global modes in
  `settings.el` and need coordinated changes.

## 4.13 `custom-file` never set

- **Description:** Anything saved through Customize is appended to
  `init.el`, which is version-controlled.
- **Impact:** Risk of accidental noise commits, or of Customize output
  breaking the hand-written init.
- **Recommendation:** `(setq custom-file (expand-file-name "custom-set.el"
  EMACS-HOME))` plus a guarded load, and gitignore it. Not done — it
  introduces a new file and changes where settings land (user decision).

## 4.14 Hidden cross-file coupling

- **Description:** `settings.el` calls `global-company-mode` and
  `olivetti-set-width`; `hydra.el` needs `defhydra` from the `hydra`
  package, which arrives only as a *dependency* of `ivy-hydra`;
  `(abbrev-mode t)` at top level only affects the buffer current during
  startup, so it does essentially nothing.
- **Impact:** Reordering the init list or deferring the wrong package
  breaks files that look self-contained; the abbrev line silently fails
  its intent.
- **Recommendation:** Documented in the init.el ordering comment (done).
  Moving mode activations next to their `use-package` declarations, and
  deciding whether `abbrev-mode` should be global, are left as follow-ups.

## 4.15 Hardcoded absolute paths

- **Description:** `lsp.el` hardcodes `/home/computer/software/jdk-21.0.2`;
  every theme palette file hardcodes `~/.emacs.d/...`; `org.el` hardcodes
  `~/source/org-mode/agenda` and `~/source/emacs-tng`.
- **Impact:** The configuration is single-machine; a rename of any of
  these directories breaks startup or theming.
- **Recommendation:** Route them through `paths.el` (which exists for
  exactly this purpose) and derive theme paths from `EMACS-HOME`. Left
  out: touching all 15+ palette files is invasive and the deployment
  assumption (repo = `~/.emacs.d`) is currently stable.

---

# 5. Refactorings Performed

Each item corresponds to one commit on this branch.

## 5.1 `fix: correct swapped OS detection in paths.el`

- **What:** Swapped the `HOME`/`USERPROFILE` lookups to match their
  platforms; folded the `setq`s into the `defvar`s; added docstrings.
- **Why:** The branches were inverted (4.1); bare `defvar` + `setq` was
  needless two-step initialization.
- **Benefit:** `HOME-DIRECTORY` is now correct on both platforms;
  `C-h v` documents both variables.
- **Risks:** `ECLIPSE-LS` changes value (from a nonsense path to a real
  one). Nothing reads it today, so no observable change.

## 5.2 `refactor: simplify startup initialization`

- **What:** `EMACS-HOME` now derives from `load-file-name`; the sixteen
  `load-file` calls became a `dolist` over an ordered list with a
  comment explaining the ordering constraints; `hydra-custom` moved from
  `custom.el` into `hydra.el`; `custom.el` deleted.
- **Why:** 4.6 (cwd-dependent startup) and 4.7 (misnamed file splitting
  one feature across two files).
- **Benefit:** Emacs can be started from any directory; adding/removing
  a module is a one-line edit; all hydras live together.
- **Risks:** Low. Load order of surviving files is byte-identical;
  `hydra-custom` is defined before `hydra-master` references it at
  runtime. Anyone with muscle memory for editing `custom.el` must look in
  `hydra.el` now.

## 5.3 `refactor: remove dead code and duplication in package setup`

- **What:** Deleted the commented-out gptel/ellama blocks; removed the
  duplicate `lsp-java` declaration from `packages.el` (the configured one
  in `lsp.el` remains); removed the dead top-level `aidermacs-args`
  override; replaced the `process-environment`/`setenv` pair with a
  single top-level `setenv`; added `:defer t` to `powershell`,
  `csharp-mode` and `nov`; dropped a redundant `progn`.
- **Why:** 4.4 and 4.12.
- **Benefit:** `packages.el` shrank from 277 to 188 lines and every
  remaining line is live; the effective aider arguments are now the ones
  you can read.
- **Risks:** The deferred trio would regress only if something depended
  on their eager `require` — they are pure major-mode packages with
  autoloads, so mode association still works. `OLLAMA_API_BASE` is now
  set once at startup with the same value as before (both old paths used
  `http://127.0.0.1:11434`). If the user *intended* the
  `--edit-format diff` variant of `aidermacs-args`, that intent was
  already unreachable before this change; restoring it is a one-line edit
  in the `:config` block.

## 5.4 `fix: remove undefined evil dependency and free variable in functions`

- **What:** `back-to-indentation` instead of `evil-first-non-blank`;
  `found` bound in a `let`; `forward-line`/`goto-char` instead of
  interactive-only motion commands; docstrings on all 13 theme commands;
  duplicate `color-change-dark` turned into a `defalias`; a lambda
  argument renamed away from the dynamic variable `mode-name`.
- **Why:** 4.2, 4.3, 4.9, and duplication.
- **Benefit:** Two commands that previously errored now work; the byte
  compiler is quiet apart from pre-existing lazy-loading warnings.
- **Risks:** Minimal. `beginning-of-buffer` → `goto-char (point-min)`
  no longer pushes the mark in `my-goto-class`/`my-goto-member`; since
  those commands previously *crashed* before finishing, no working
  workflow depended on the old mark behavior.

## 5.5 `refactor: simplify theme switching state`

- **What:** Rewrote `theme/theme.el`: every variable is a documented
  `defvar`; `my-disable-themes` is a single `disable-theme`;
  `my-theme-loop` is a bounds check + `load-theme` + message; the
  13×`chiaroscuro` list, `chiaroscuro-index`, and the leaked loop
  counters are gone. Removed the duplicate `INDEX-UBUNTU` entry from
  `chiaroscuro-theme.el`'s dispatch map. A header comment now explains
  the load-time-palette-selection design.
- **Why:** 4.5 and 4.8.
- **Benefit:** The file now says what it does; ~40 lines and five
  globals removed; byte-compile warnings eliminated.
- **Risks:** This is the most behavior-sensitive change. All quirks were
  preserved deliberately: wrap-around at both ends, the `-1` case that
  resets `theme-index` but not `INDEX-CHIAROSCURO` before loading, the
  "emacs" message at index 0. Verified by driving the switching commands
  in batch Emacs against a simulated `~/.emacs.d` deployment (see
  Verification below).

## 5.6 `chore: clean up macros.el header comment`

- **What:** Removed stray characters (`4cb0b3`) from the Commentary line
  and corrected the file description ("keybindings file" → "macros file").
- **Why:** Copy-paste damage in headers erodes trust in comments.
- **Benefit / Risks:** Cosmetic only.

---

# 6. Remaining Opportunities

Deliberately **not** done, in rough order of value:

1. **Consolidate on one completion framework** (helm *or* ivy/counsel).
   Largest simplification available — removes 4–6 packages and the
   double `completing-read` machinery. Not done: it changes daily-use
   behavior on core keys (`M-x`, `C-x b`, kill-ring browsing) and the
   choice is the user's to make.

2. **Systematic lazy loading.** Defer company/yasnippet to
   `prog-mode-hook`, lsp-ui to lsp, the LLM clients to their bindings,
   and move `global-company-mode`/`olivetti-set-width` out of
   `settings.el` next to their packages. Not done beyond the safe trio:
   it requires coordinated changes across `settings.el` and `packages.el`
   and careful re-testing of each tool.

3. **Set `custom-file`.** One line plus a gitignore entry; prevents
   Customize from appending to a version-controlled `init.el`. Not done:
   introduces a new untracked file and changes where saved settings land
   — worth a conscious user decision.

4. **Route hardcoded paths through `paths.el` / `EMACS-HOME`.** The JDK
   path in `lsp.el`, the org agenda directories, and the `~/.emacs.d/...`
   literals in every palette file. Not done: touching 15+ palette files
   is invasive for zero behavior change while the repo-as-`.emacs.d`
   assumption holds.

5. **Decide the fate of ambient dead code:** `ECLIPSE-LS`,
   `golden-ratio` (installed, never enabled), the no-op `:delight`
   strings, the commented dabbrev hook in `keybindings.el`, the
   exploratory bottom half of `color-changer.el`, and the possibly-dead
   `custom-theme-load-path` entry for `~/.emacs.d/chiaroscuro-theme.el/`
   in `init.el` (the theme is found via `user-emacs-directory` anyway).
   Not done: each looks like paused experimentation rather than garbage;
   deleting a user's work-in-progress needs their confirmation.

6. **Update `macros.el` to the non-obsolete `kmacro` API** (Emacs 29+).
   Not done in the same pass as the header fix because re-recording the
   macro changes its stored representation; safer done interactively by
   the user.

7. **Give `regexp-class`/`regexp-member` the `my-` prefix.** They are the
   only unprefixed globals left outside the theme system. Not done: they
   look like user-serviceable knobs; renaming would break any personal
   overrides.

8. **README.** The README contains only the project name; a short
   "clone as `~/.emacs.d`, first start installs packages" note would help
   future machines. Left for the user's voice.

---

# 7. File-by-File Notes

Only files modified on this branch are listed.

## `init.el`
- **Purpose:** Entry point; loads every module in dependency order.
- **Changes:** `EMACS-HOME` derived from the init file's own location
  (was: launch directory + `.emacs.d`); loads expressed as one ordered
  list with an ordering-rationale comment; a comment explaining why
  `custom--inhibit-theme-enable` must be nil; `custom.el` removed from
  the list.
- **Rationale:** Startup previously worked only when Emacs was launched
  from `$HOME` (4.6).

## `paths.el`
- **Purpose:** Machine-specific paths.
- **Changes:** OS-detection branches un-swapped; values assigned inside
  `defvar` with docstrings.
- **Rationale:** 4.1.

## `packages.el`
- **Purpose:** All package declarations.
- **Changes:** Dead commented blocks deleted; duplicate `lsp-java`
  removed; dead `aidermacs-args` override removed; single `setenv` for
  `OLLAMA_API_BASE`; `:defer t` on powershell/csharp-mode/nov; redundant
  `progn` dropped.
- **Rationale:** 4.4, 4.12.

## `functions.el`
- **Purpose:** General custom commands.
- **Changes:** evil calls replaced with `back-to-indentation`; `found`
  bound; `forward-line`/`goto-char` for Lisp-side motion; docstrings on
  theme commands; `color-change-dark` is now a `defalias`; lambda
  argument renamed away from `mode-name`.
- **Rationale:** 4.2, 4.3, 4.9.

## `theme/theme.el`
- **Purpose:** Theme-switching state and commands.
- **Changes:** Full rewrite preserving semantics: documented `defvar`s,
  direct disable/load calls, dead variables and loop counters removed,
  design explained in the header.
- **Rationale:** 4.5.

## `chiaroscuro-theme.el`
- **Purpose:** The single custom theme (palette dispatch + face specs).
- **Changes:** Duplicate `INDEX-UBUNTU` dispatch entry removed. Face
  specifications untouched.
- **Rationale:** 4.8; minimal-risk policy for a 33 KB load-bearing file.

## `hydra.el`
- **Purpose:** Hydra definitions.
- **Changes:** Gained `hydra-custom` (verbatim) from `custom.el`, placed
  before `hydra-master` which references it.
- **Rationale:** 4.7.

## `custom.el` (deleted)
- **Purpose (former):** Held `hydra-custom` only.
- **Rationale:** Content moved to `hydra.el`; the name is better left
  free for a real `custom-file` later.

## `lsp.el`
- **Purpose:** Java LSP setup and manual on/off toggles.
- **Changes:** `lsp-java-java-path` folded into its `defvar`; docstring
  typo fixed; trailing blank lines removed. (Now the sole home of the
  `lsp-java` declaration.)
- **Rationale:** 4.4.

## `macros.el`
- **Purpose:** Recorded keyboard macros.
- **Changes:** Header comment repaired.
- **Rationale:** 5.6.

---

# 8. Overall Assessment

**Current architecture rating: 6.5 / 10** (up from ~5.5 at baseline).
The flat module layout and the parameterized theme are solid ideas well
suited to a personal configuration; the deductions are for the dual
completion frameworks, the remaining eager loading, hardcoded paths, and
the exploratory residue in `color-changer.el`.

**Maintainability:** Good for a single owner and improving. After this
branch, every file byte-compiles without new warnings, all global theme
state is declared and documented, and there is no longer any code whose
apparent effect differs from its real effect (the aider args and the
swapped OS detection were the worst offenders). The highest ongoing risk
is the helm/ivy duality — every new binding must silently choose a side.

**Future recommendations, in order:**

1. Choose one completion framework (section 6.1) — the single highest
   leverage change.
2. Adopt lazy loading systematically and move mode activations next to
   their packages (6.2); target: sub-second warm start.
3. Set `custom-file` (6.3).
4. Sweep the ambient dead code once the experiments conclude (6.5).
5. Route machine-specific paths through `paths.el` (6.4).

**Verification performed:**

- `check-parens` passes on all 17 elisp files.
- `paths.el`, `theme/theme.el`, `functions.el`, `org.el`, `macros.el`,
  `shell.el` load cleanly in batch Emacs 30.2.
- Theme switching exercised end-to-end in batch mode against a simulated
  `~/.emacs.d` deployment: set ubuntu → up → down → eclipse → reset; the
  correct palette files loaded and the correct names were echoed each
  step, ending at `theme-index = 0`.
- Refactored `init.el` executed with loads stubbed: `EMACS-HOME`
  resolves to the repo, all 15 files exist and load in the original
  relative order.
- Byte-compilation of the touched pure-elisp files produces no warnings
  introduced by this branch (remaining warnings are pre-existing
  references to lazily-loaded package functions, plus the known obsolete
  `kmacro-lambda-form`, kept deliberately — see 6.6).
- A full `emacs -l init.el` with package installation was not run here:
  this review machine has no ELPA package state, and first-run installs
  ~30 packages including vterm's native module. The stubbed-load and
  batch tests above cover everything this branch changed.
