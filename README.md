# ITSY-2301 · Lab 00 · Hello Lab

**Course:** ITSY-2301 Network Security & Firewalls
**Module:** Module 0 — Environment Check-in
**Delivery:** 100% online, fully asynchronous
**AI policy for this lab:** **AI-FREE** *(see §3.1 of the course AI policy)*

> Your first deliverable. This lab proves your Docker/Colima environment works on whatever computer you'll use for the rest of the course. It is short, deliberately easy, and required: every subsequent lab assumes you completed this one.

---

## Learning objectives

By the end of this lab you will be able to:

1. Install and run Docker (or Colima on macOS) on your own machine.
2. Bring up a containerized lab with one command (`./scripts/start.sh`).
3. Run the integrity-anchor commands (`whoami && hostname && date`) that open every screencast in this course.
4. Submit a complete lab through Canvas with the screencast link and the verify-report.json.

## Prerequisites

None. This is the prerequisite for every other lab.

You will need your own computer (Windows / macOS / Linux), 8 GB RAM or more, ~15 GB free disk, an internet connection for the first Docker pull, an Alamo Colleges Zoom account (already set up; sign in at <https://alamo.zoom.us>), and a GitHub account (free).

---

## Setup

Before this lab, set up your environment using these two guides:

1. **[docs/PLATFORM_SETUP.md](docs/PLATFORM_SETUP.md)** — install docker, git, python3, wireshark, and gh CLI for your operating system. Admin rights required.
2. **[docs/GIT_QUICKSTART.md](docs/GIT_QUICKSTART.md)** — git basics and the fork-and-submit pattern this course uses.

If you've already done both once on this machine for another lab, you're ready to start the recording in Task 1 below.

You'll bring up the lab with `./scripts/start.sh` inside the recording (see Task 2) — **don't run it yet.** Running it before the recording means the integrity-anchor commands won't be captured. The lab pulls a tiny Alpine Linux image (~5 MB) on first run; resource budget is ~30 MB RAM, ~10 MB disk, ~5 second startup.

---

## Tasks

### Task 1 — Start your Zoom Cloud recording and run the integrity opener

Open `docs/screencast-howto.md` once and follow the Zoom Cloud Recording instructions. Start the recording before you run any of the commands below. Make sure your terminal is visible at readable size.

Once recording, in your **host** terminal (your normal shell — NOT inside any container), run:

```bash
whoami
hostname
date
```

These show *your* username and *your* machine name — that's the recording's identity anchor. The same three commands also run inside the container during Task 2, but those report `root` and a container ID; the host versions here are what bind the recording to you. Then move on to Task 2.

### Task 2 — Run the integrity-anchor commands

In your recording, run:

```bash
./scripts/start.sh
```

The script runs `whoami`, `hostname`, `uname -a`, and `date` inside the container and writes the output to `output/identity.txt`. Inspect the file (`cat output/identity.txt`). Note: `whoami` reports `root` and `hostname` reports a 12-character container ID — that's the container's identity, not yours. Your identity is established elsewhere in the recording: by your shell prompt outside the container, by your name typed in Task 3, and by the Alamo SSO that gates the Zoom upload.

### Task 3 — Type your name into the recording

Still in your recording, type the identifying line into your terminal:

```bash
echo "Jane Doe — ITSY-2301 Lab 00 — $(date)"
```

Replace `Jane Doe` with your actual name. This line, plus the identity commands' output, is what the grader uses to confirm you personally completed the lab.

### Task 4 — Run the verifier

```bash
./scripts/verify.sh
```

The verifier checks that the identity commands produced valid output and writes `output/verify-report.json`. Exit code 0 means pass. Show the report on screen before stopping the recording:

```bash
cat output/verify-report.json
```

### Task 5 — Stop the recording and gather artifacts

Stop the Zoom recording. Wait for Zoom to process it (10–30 minutes; you'll get an email). Set the Zoom share permissions to "Internal users only." Copy the link.

---

## Submission

This lab uses the dual-track submission model described in [`docs/privacy-and-submission.md`](docs/privacy-and-submission.md).

**Track A — GitHub fork:** Lab 00 doesn't require any commits — just submit your fork's URL as-is (the fork already has all the starter files from the upstream repo; you just don't need to add anything on top).

**Track B — Canvas:**

1. Paste the URL of your GitHub fork in the Canvas text field.
2. Paste the **Zoom Cloud recording link** (≥10 minutes, sharing set to "Internal users only"). See [`docs/screencast-howto.md`](docs/screencast-howto.md) for the full recording flow.
3. Attach `output/verify-report.json` as a file attachment.
4. Sign in to Canvas with your Alamo SSO to complete the submission.

Note: the AI Use Log is not required for this lab because it is AI-FREE.

---

## Definition of done

- [ ] Docker, git, python3 verified by the preflight inside `./scripts/start.sh`.
- [ ] Wireshark and gh CLI installed via [`docs/PLATFORM_SETUP.md`](docs/PLATFORM_SETUP.md). (Lab 00 does *not* verify these — they're exercised starting in Module 1. Confirm them yourself: open Wireshark from your OS launcher, and run `gh --version` in a terminal.)
- [ ] `./scripts/start.sh` ran without errors.
- [ ] `./scripts/verify.sh` exits 0 with `"fail": 0`.
- [ ] Zoom Cloud recording submitted (≥10 minutes, "Internal users only" sharing).
- [ ] `verify-report.json` attached.
- [ ] GitHub fork URL submitted (no student commits required for Lab 00).
- [ ] Canvas submission completed under Alamo SSO.

## License

This lab is released under the MIT license (see [LICENSE](LICENSE)).
