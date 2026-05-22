# How to Record Your Screencast

The continuous screencast is 20 points of this lab's rubric. The grader uses it to confirm that you — the named submitter — actually did the work. This guide is the entire instruction set: read it once, set up your recording tool of choice, then start working.

If you've done a screencast for a previous lab, the bottom-line summary at the end is all you need to re-check.

---

## Primary path — record with Zoom Cloud (recommended)

Every Alamo Colleges student and instructor has a Zoom account with cloud recording. Use it. Three reasons this is the recommended path:

1. **No Canvas upload limit.** You submit a Zoom cloud link, not a multi-hundred-MB video file. Canvas only stores the link.
2. **Authenticated identity is baked into the metadata.** Your Alamo SSO identity is attached to the recording — the grader can verify in Zoom that the named submitter is the one who recorded.
3. **No software to install.** Every lab machine already has Zoom; every browser can launch it; no OBS, no HandBrake, no `ffmpeg`.

### What you actually do

1. **Sign in to Zoom** at <https://alamo.zoom.us> (or open the Zoom desktop client and sign in with your Alamo Colleges credentials — use **SSO** as the sign-in method, not email/password).
2. Click **New Meeting**. You can join with or without computer audio — audio is not required.
3. Click **Share Screen** in the meeting toolbar. Choose **Screen 1** (or the specific display where your terminal is) and click **Share**.
4. In the meeting controls toolbar (now floating at the top of the shared display), click **More** → **Record to the Cloud**.

   > If "Record to the Cloud" is greyed out, your account may not have cloud recording enabled — see the troubleshooting section below.

5. **In your terminal (on your host machine, NOT inside any container)**, run the integrity opener as the first thing you do on the recording:

   ```bash
   whoami
   hostname
   date
   ```

   This is your host's `whoami` (your actual username, e.g., `aaron`) and host's `hostname` (your actual machine, e.g., `MacBook-Pro.local`). It binds the recording to YOUR identity on YOUR machine.

   (Later, when you run `./scripts/start.sh`, that script also runs `whoami` / `hostname` inside the lab's container. Inside the container those report `root` and a 12-character container ID — that's the container's identity, separate from yours. Both end up in the recording; both serve a purpose.)

6. Type your full name and the lab number in the terminal. For example:

   ```bash
   echo "Jane Doe — ITSY-2301 Lab 00 — $(date)"
   ```

   This, together with the host `whoami / hostname / date` output above, is the integrity anchor for the recording.

7. **Work the lab.** Run `./scripts/start.sh` to bring up the container, `cat output/identity.txt` to inspect the output, then `./scripts/verify.sh`. Lab 00 is AI-FREE, so you won't be interacting with any LLM during the recording.

8. **At the end**, run `./scripts/verify.sh` one final time, then show the verify-report:

   ```bash
   cat output/verify-report.json
   ```

9. Click **More** → **Stop Recording**. Then **End Meeting**.

10. Wait for the recording to process. Zoom emails you when it's ready (usually 10–30 minutes for a session under 90 minutes). The link appears at <https://alamo.zoom.us/recording>.

### Set sharing permissions on the recording

Default Zoom cloud sharing is "Internal users only" — meaning anyone with an Alamo Colleges Zoom account can view with the link. That's the right setting for this lab; the instructor is internal.

1. Go to <https://alamo.zoom.us/recording> and find your recording.
2. Click **Share**.
3. Confirm **Internal users only** is selected. Do **not** open it to "Anyone with the link" unless your instructor explicitly asks.
4. **Optional but recommended:** turn on **Passcode protection** and include the passcode in your Canvas submission text.
5. Copy the share link.

### Submit the link in Canvas

In the Canvas assignment's text-submission field, paste the Zoom recording link. That's the screencast portion of your submission. Then attach `verify-report.json` as a Canvas file attachment. **For Lab 00 (AI-FREE), you do NOT attach an AI Use Log** — that becomes a required attachment starting in Module 1's AI-OPEN/AI-REQUIRED labs. See [`privacy-and-submission.md`](privacy-and-submission.md) for the full submission flow.

### Caveats

- **Retention.** Alamo Colleges' Zoom cloud recordings have a retention window (usually 120–180 days). If you want to keep the recording as a personal portfolio artifact beyond the term, download it from <https://alamo.zoom.us/recording> and store it locally.
- **Processing delay.** Don't start recording one hour before the assignment is due. Give Zoom time to process — leave at least a couple of hours of margin.
- **Audio narration is completely optional and does not affect your grade either way.** If you want to talk through what you're doing, you can — laptop mic is fine. If you'd rather work silently, that's equally fine. The integrity anchor lives in what's on screen, not in the audio.
- **Do not turn on your webcam.** No part of the rubric requires it, and the work happens in the terminal, not on your face. Keep your camera off.

---

## What to record (content requirements)

This applies whether you're using Zoom Cloud (primary) or a local recorder (fallback).

A single continuous recording. No edits, no cuts, no time-skips.

**At the start (first 30 seconds):**

- A terminal at readable size (≥100 columns, large font).
- Run `whoami && hostname && date`.
- Type your full name and the lab number into the terminal (`echo "Jane Doe — ITSY-2301 Lab 00 — $(date)"`).

**During the work (the bulk of the recording):**

- Run `./scripts/start.sh`, then `cat output/identity.txt`, then `./scripts/verify.sh`. Read each output as it appears.
- Lab 00 is AI-FREE — you won't be using an LLM during this recording.
- If you look something up (a man page, your platform's docs), show the lookup.

**At the end (last 60 seconds):**

- One final `./scripts/verify.sh` run, completed on screen.
- `cat output/verify-report.json` to display the report.
- Stop the recording.

**Minimum length:** 10 minutes of continuous work. Recordings shorter than 10 minutes lose the screencast rubric points. Lab 00 is short by design; you can fill the time by talking through what you're doing, reading the README or PLATFORM_SETUP on screen, or showing your setup steps. The integrity anchor is what's visible on screen end-to-end, not how busy each minute is.

---

## Fallback path — local recording

Use the local path only if Zoom Cloud Recording is unavailable for your account, you can't get on Wi-Fi for the duration of the lab, or you have a specific reason to keep the recording entirely on your machine. The submission flow is the same except you upload the file to Canvas instead of pasting a Zoom link.

### macOS — built-in Screen Recording

1. Press **Cmd + Shift + 5**.
2. Choose **Record Entire Screen** or **Record Selected Portion**.
3. Click **Options** to set the save location, microphone, and "Show Mouse Clicks."
4. Click **Record**. Stop via the menu bar icon or **Cmd + Control + Esc**.
5. The file lands as `Screen Recording <timestamp>.mov`. Rename to `screencast-<lastname>-<YYYYMMDD>.mov`.

### Windows — Snipping Tool record mode (Windows 11)

1. Open **Snipping Tool** → click the **⏺ Record** icon → **+ New**.
2. Drag a box around your terminal or whole screen → **Start**.
3. Click the stop icon in the taskbar when done. Files land in `Videos/Screen Recordings`.

### Windows — OBS Studio (any version)

1. Download from <https://obsproject.com>.
2. **Sources** → **+** → **Display Capture**.
3. **Settings** → **Output** → format **mp4** (or **mkv** for crash safety; remux later).
4. **Settings** → **Audio** → microphone only if you've chosen the optional narration; otherwise leave it unset.
5. **Start Recording** / **Stop Recording**.

### Linux — GNOME built-in

GNOME's recorder has a 30-second cap by default. Lift it once:

```bash
gsettings set org.gnome.settings-daemon.plugins.media-keys max-screencast-length 3600
```

Press **Ctrl + Shift + Alt + R** to start, again to stop. Files land in `~/Videos` as `.webm`.

### Linux — KDE Spectacle

Spectacle has built-in video recording in KDE Plasma 5.27+. Open Spectacle → switch to the camcorder tab → choose Region or Full Screen → Record.

### Any Linux — OBS Studio

`sudo apt install obs-studio` (or your distro equivalent). Same workflow as Windows OBS above.

### Compressing a too-big file (local recording only)

A 60-minute screen recording is often 500 MB–2 GB. Canvas typically caps attachments at 500 MB. Two options:

1. **HandBrake** (free, [handbrake.fr](https://handbrake.fr)) — open the recording, preset "Fast 1080p30," Quality RF 22, Start. Usually shrinks 3–5×.
2. **ffmpeg one-liner:**

   ```bash
   ffmpeg -i input.mov -c:v libx264 -crf 23 -preset medium -c:a aac -b:a 96k output.mp4
   ```

If still too big after compression, switch to the Zoom Cloud primary path — that's exactly the friction it eliminates.

---

## Privacy during recording

Whether you're recording to Zoom Cloud or locally, take 30 seconds before pressing Record to clean your screen. Practice the habit — security professionals develop muscle memory around it.

- **Close** email, messages, password manager, banking tabs, social media, unrelated chat apps.
- **Hide** the browser bookmarks bar (Ctrl/Cmd + Shift + B in most browsers).
- **Mute** OS notifications (macOS Focus mode, Windows Focus assist, Linux depends on DE).
- **Don't** record screens with other classmates' work, family photos, or open documents from your job.
- **Audio:** since narration is fully optional, the simplest choice is to record with the microphone off. If you do choose to narrate and you live with other people, use earbuds-with-mic so only you are picked up.

If a notification appears on screen anyway, mention it in the recording ("just got a notification, not part of the lab") and keep going. Don't restart — the grader sees the human moment and you keep your continuous-recording credit.

---

## When things go wrong

**Zoom shows "Record to the Cloud" greyed out.**
Your account may not have cloud recording enabled. Check at <https://alamo.zoom.us/profile/setting> under Recording → "Cloud recording" toggle. If it's off and you can't turn it on, message your instructor through Canvas Inbox. Use the local recording fallback in the meantime.

**Zoom processed the recording but the link is private to me only.**
Go to <https://alamo.zoom.us/recording>, click your recording, click **Share**, and confirm sharing is set to "Internal users only." Send your instructor the link if they can't open it.

**The recording crashed mid-session.**
Start a new recording immediately. Don't try to edit the two files together. Submit both links (or both files for local recording) and note the gap in your Canvas submission comments (and in your AI Use Log too, for labs that require one): "Zoom session ended unexpectedly at ~minute 22, resumed in part 2."

**I forgot to do the `whoami / hostname / date` opener.**
Do it now in your current session, even if you've been working for an hour. Better late than never. Mention the late start in your Canvas submission comments (and in your AI Use Log too, for labs that require one).

**Audio missing.**
Audio is fully optional and doesn't affect the grade — submit without it. (If you intended to narrate and the mic was disabled by OS privacy settings, you can fix that for next time: macOS Settings → Privacy & Security → Microphone; Windows Settings → Privacy → Microphone.)

**I accidentally exposed a password or token on screen.**
Stop the recording, **rotate the credential immediately** (change the password, revoke the token), and start a new recording. Mention it in your Canvas submission comments (and in your AI Use Log, for labs that require one) — it's a learning moment, not a failure.

---

## Bottom-line summary

1. **Primary:** record with **Zoom Cloud** via your Alamo Colleges account. Sign in at <https://alamo.zoom.us>, New Meeting, Share Screen, More → Record to the Cloud.
2. **Fallback:** local OS recorder (macOS Cmd+Shift+5 / Windows Snipping Tool / Linux GNOME or OBS) — only if Zoom Cloud isn't an option.
3. Start with `whoami && hostname && date` on screen.
4. End by showing `output/verify-report.json`.
5. At least 10 minutes, continuous, no edits.
6. **Zoom Cloud:** set sharing to "Internal users only," submit the link in Canvas's text field.
7. **Local:** MP4 H.264 (or MOV on macOS) under 500 MB, named `screencast-<lastname>-<YYYYMMDD>.mp4` (or `.mov` for macOS Screen Recording), uploaded as a Canvas file attachment.
8. **Never** commit recordings to GitHub. File extensions and Zoom links are kept out of the repo by `.gitignore` and convention.
9. Close personal apps and notifications before you press Record.
