# Git Quickstart

A focused walkthrough of the git workflow this course uses. Assumes you've completed [PLATFORM_SETUP.md](PLATFORM_SETUP.md). 10-minute read.

## Mental model

Three places store your work. They are physically different machines, even though git makes them feel continuous:

```
+-------------------+                       +-----------------------+
|  Your computer    |  -- git push -->      |  Your fork on GitHub  |
|  (the clone)      |  <-- git pull --      |  (github.com/<you>/…) |
+-------------------+                       +-----------------------+
                                                     ^
                                                     | "fork" (one-time copy
                                                     |  via the GitHub UI)
                                                     |
                                            +-------------------------+
                                            |  The course repo        |
                                            |  (itsy2301-nlc/lab-…)   |
                                            |  read-only to you       |
                                            +-------------------------+
```

You only ever push to **your fork**. The course's original repo is read-only to you. Your fork's URL is what you paste into Canvas as your lab submission.

## One-time setup

### Set your git identity (if you didn't already in PLATFORM_SETUP)

```bash
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"
```

### Authenticate to GitHub via `gh auth login`

`gh` was installed in PLATFORM_SETUP. Sign in once:

```bash
gh auth login
```

Answer the prompts:

1. **What account do you want to log into?** → `GitHub.com`.
2. **What is your preferred protocol for Git operations?** → `HTTPS`.
3. **Authenticate Git with your GitHub credentials?** → `Y`.
4. **How would you like to authenticate GitHub CLI?** → `Login with a web browser`.

`gh` prints an 8-character code (something like `XXXX-XXXX`) and opens https://github.com/login/device in your browser. Paste the code there, sign in to GitHub, click "Authorize github." When the browser shows "Congratulations, you're all set!", come back to the terminal.

`gh` stores credentials so plain `git push` / `git pull` work for the rest of the course without prompting you for a password. This is the path of least friction — it avoids personal access tokens and SSH key management.

### Verify

```bash
gh auth status
```

Expected output mentions `Logged in to github.com as <your-username>`.

## The daily flow

You'll use four commands 95% of the time. The working example below uses Lab 01 (Lab 00 itself requires no commits — see Step 3 below):

```bash
# What's changed since the last commit?
git status

# Stage your changes for the next commit.
git add -A                  # everything
# or:
git add path/to/specific/file.md

# Record the staged changes locally.
git commit -m "Add my findings.json for Lab 01"

# Send your commits to your fork on GitHub.
git push
```

Expected: `git push` prints something like:

```
To https://github.com/<you>/lab-00-hello-lab.git
   abc1234..def5678  main -> main
```

If you see that line, your fork is up to date.

### About commit messages

Imperative mood, one short sentence is fine for lab work. Examples:

- `Add reference findings for Lab 02`
- `Fix verifier path in start.sh`
- `Update memo with executive summary`

Don't sweat it — the message is for *future you* finding the commit, not for a grading rubric.

## Fork and submit (the lab pattern)

Every lab in this course uses the same shape. The full walkthrough using Lab 00:

### Step 1 — Fork the lab repo on GitHub

Go to the lab's GitHub page (your instructor gives you the URL — for Lab 00 it's https://github.com/itsy2301-nlc/lab-00-hello-lab).

Click the **Fork** button (top-right). Click **Create fork**. Wait ~5 seconds.

You now have your own copy at `https://github.com/<you>/lab-00-hello-lab`. Bookmark it.

### Step 2 — Clone your fork

> **Critical:** clone YOUR fork, not the course org's repo. You don't have push access to the course repo, so cloning that URL leads to permission errors when you `git push` later.

```bash
# Replace YOUR-GITHUB-USERNAME with your actual GitHub username before running.
# (Angle brackets are shell redirects — don't type literal <you>.)
git clone https://github.com/YOUR-GITHUB-USERNAME/lab-00-hello-lab.git
cd lab-00-hello-lab
```

### Step 3 — Do the lab

Follow the lab's `README.md`. Run scripts, make any required edits, write findings, etc.

> **Lab 00 is special:** there's nothing to commit. Your fork already has the starter files; you just don't need to add anything on top. Submit the fork URL in Canvas with no student commits. **Skip Step 4 below** for Lab 00 and go straight to Step 5.

### Step 4 — Commit and push (Module 1+ labs only)

Starting in Module 1, each lab asks you to commit the work you did inside the lab's `rules/`, `configs/`, or `src/` directory (the README of that lab spells out which files).

```bash
git add -A
git commit -m "Complete Lab NN"
git push
```

### Step 5 — Submit on Canvas

Your fork's URL — for example `https://github.com/your-username/lab-00-hello-lab` — is what you paste into the Canvas submission text field. Your instructor browses your fork to see your work.

### One pitfall to avoid

If `git push` fails with **"Permission denied"** or **"remote: Repository does not exist"**, you almost certainly cloned the course org's URL instead of your fork's URL. To check:

```bash
git remote -v
```

Expected: lines starting with `origin  https://github.com/<your-username>/lab-…`. If you see `origin  https://github.com/itsy2301-nlc/lab-…` instead, you cloned the wrong URL. Delete the directory, re-fork (Step 1), re-clone (Step 2).

## When git surprises you

| Symptom | What it means | Fix |
| ------- | ------------- | --- |
| `error: failed to push some refs ... rejected` | Someone (or earlier-you) pushed first | `git pull --rebase` then `git push` again |
| `Permission denied (publickey)` or HTTP 403 on push | Not authenticated | Re-run `gh auth login` |
| `Updates were rejected because the tip of your current branch is behind` | Same as the first row | Same fix |
| `fatal: not a git repository` | You're outside a cloned repo | `cd` into the cloned directory |
| Accidentally committed `output/` | Shouldn't happen — `output/` is gitignored — but if you bypassed `.gitignore`: | `git rm --cached -r output && git commit -m "Remove output/"` |

## You're done

Once `gh auth status` shows you're logged in and you have your fork cloned locally, you have everything you need for every lab in this course. (For Lab 00 you stop here — no commits required. Module 1+ labs ask you to commit your work and push.)

Next: head to the lab's `README.md` and follow the lab-specific instructions. For Lab 00, that's [../README.md](../README.md).
