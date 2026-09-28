# Global Instructions

## Comments and Docs: Nothing That Goes Stale

Write comments and docs so a routine change elsewhere can't make them wrong.

- Say what something does and why, not which files, counts or versions surround it. Name a
  specific file only when the reader needs that exact name to act.
- Describe a set by what its members share, not by listing them: "each build script", not
  the script names. Sets grow.
- No measured or counted numbers: timings, sizes, file or test counts, speedups.
- A version, pinned value or setting lives in the one file that sets it. Point there; don't
  repeat the value.
- No "currently", "new", "now" or "not yet". Describe how things are.
- Exception: dated records such as changelog entries may state the figures they measured.
- Before writing, ask: would renaming a file, adding a sibling or bumping a dependency make
  this wrong? If so, rewrite it.
