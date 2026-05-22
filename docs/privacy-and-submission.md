# Privacy & Submission Flow

This lab uses a **dual-track submission model**. Your technical work goes to GitHub. Your identifying artifacts go to Canvas. Each track carries what it should carry, and nothing it shouldn't.

## Why two tracks?

GitHub is public-by-default and tied to your real-world identity over time. Canvas is FERPA-protected and instructor-only. Putting your name, your AI use disclosures, your hostname, or your screen recording on a public GitHub repo would be a privacy mistake — both for the term and for your future. Keeping them out of GitHub is how this lab is designed.

## The two tracks

### Track A — GitHub (your portfolio artifact)

This goes on your GitHub fork. **A fork of a public GitHub repository is always public — that's a GitHub platform constraint, not something you can change in fork settings.** If you don't want your work on a public repo, see "What about my GitHub username?" below for the duplicate-repo workaround.

What goes to GitHub for Lab 00: **nothing.** Lab 00 is the environment check-in — there's nothing to commit. Just submit your fork's URL as-is (your fork already has all the starter files from the upstream repo; you just don't need to add anything on top). Future labs will ask you to commit the work you did inside the lab's `rules/`, `configs/`, or `src/` directory; each lab's README spells out exactly which files.

What is automatically kept out by `.gitignore` (in this lab and every later lab):

- `AI_USE_LOG.md` (your filled-in copy — contains your name).
- `verify-report.json` (contains your machine's hostname).
- `output/` (any lab artifacts written here).
- `*.mp4`, `*.mkv`, `*.mov`, `*.webm` (your screencast).

### Track B — Canvas (the graded submission)

This is what gets graded. Canvas is FERPA-protected; only the instructor sees these artifacts.

What you submit through Canvas:

1. **The URL of your GitHub fork** — pasted into the Canvas text submission field.
2. **The link to your Zoom Cloud recording** — also pasted into the Canvas text field. Record using your Alamo Colleges Zoom account (the institution provides one to every student), share the recording with "Internal users only," and paste the link. The screencast does **not** get uploaded as a file — Canvas just stores the link, so there's no attachment-size problem. See [`screencast-howto.md`](screencast-howto.md) for the full recording flow, including the local-recording fallback if Zoom Cloud isn't available for some reason.
3. **Your filled-in `AI_USE_LOG.md`** — **not required for Lab 00 (AI-FREE), so skip this for Lab 00.** In future AI-OPEN or AI-REQUIRED labs, you'll copy `AI_USE_LOG.template.md` to `AI_USE_LOG.md` at the start of the work and upload the filled copy as a Canvas file attachment. That file is `.gitignore`d so it never leaves your machine through git.
4. **`verify-report.json`** — uploaded as a file attachment. Same logic — `.gitignore`d, lives only on your machine and in Canvas.
Identity at submission is established by your Alamo SSO sign-in to Canvas, which is the same SSO that gates your Zoom Cloud recording — so the recording and the submission are authenticated under the same institutional credential.

## What about my GitHub username?

If your GitHub username is your real name, that's still fine. Employers see it as your portfolio identity. The point of the dual track is not anonymity — it's that you control what becomes a permanent public artifact.

If you have any reason to keep your GitHub identity separate from your academic one, you can:

- Use a non-identifying GitHub handle for this course's forks (handle changes are free).
- Or use the **private duplicate-repo workaround**: `gh repo create my-private-copy --private --clone` then push the lab files into that private repo. Add your instructor as a collaborator with read access. (GitHub forks of public repos are always public — duplicate-repos let you bypass that. Less convenient than forking; only worth the extra step if you genuinely don't want a public footprint.)

Message your instructor through Canvas Inbox if you need help setting any of this up. The decision about how visible your GitHub work is is yours — the rubric doesn't reward public over private.

## How identity binding works in this course

There are two places identity is bound to your work:

1. **At record time** — when you start a Zoom Cloud recording with your Alamo Colleges Zoom account, the recording's metadata captures your authenticated SSO identity. The grader can verify in Zoom that the named participant matches the named Canvas submitter.
2. **At submit time** — Canvas requires SSO sign-in (the same Alamo credential). Canvas binds the submission to that identity.

Both layers ride on your Alamo SSO credential — so the practical advice is the practical advice for any SSO: don't share it. Protect it like any other work credential.

## Cheat-sheet for this lab

```
GitHub fork:                  Canvas submission:
  (nothing to commit;           the GitHub fork URL (text field)
   the fork URL is what          Zoom Cloud recording link (text field) ← primary
   you submit; the fork can      screencast path, "Internal users only" sharing
   be left empty)                verify-report.json (file attachment)
                                 (AI Use Log NOT required — Lab 00 is AI-FREE)

Local recording fallback (only if Zoom Cloud isn't an option):
                                screencast-<lastname>-YYYYMMDD.mp4 or .mov (file attachment, ≤500MB)
```

## What if I already committed something I shouldn't have?

`git filter-repo` (or BFG Repo-Cleaner) will rewrite history to remove a file or directory from every commit. The fastest practical fix (substitute the actual path you committed):

```bash
# Make sure git filter-repo is installed (pip install git-filter-repo).
# Examples — substitute the actual leaked path:
git filter-repo --path AI_USE_LOG.md       --invert-paths --force   # leaked your name
git filter-repo --path verify-report.json  --invert-paths --force   # leaked your hostname
git filter-repo --path output/             --invert-paths --force   # leaked lab artifacts
git filter-repo --path screencast.mp4      --invert-paths --force   # leaked a recording
git push --force
```

Then rotate any secrets that were in the file (passwords, tokens) — once it's been on a public repo, treat it as leaked.

If you're not sure how to do this, post on the Q&A board (without including the file's contents). Your instructor will help.
