# Integrity Artifacts — Lab 00 Hello Lab

Every lab in this course has two possible integrity components alongside your code: a continuous screencast and an AI Use Log. **For Lab 00 (AI-FREE), only the screencast is required** — the AI Use Log starts in Module 1, when the AI-OPEN and AI-REQUIRED labs begin. Whichever components apply to a lab, they're **submitted via Canvas, not GitHub** — see [`privacy-and-submission.md`](privacy-and-submission.md) for the dual-track flow that keeps your identifying artifacts private.

## 1. Continuous screencast

Record your work session continuously — no edits, no cuts. The rubric assigns 20 points to the screencast as a separately-weighted line item — it's the strongest integrity control in the design and that's reflected in the weighting.

**Primary path: record with Zoom Cloud via your Alamo Colleges Zoom account, then submit the cloud link in Canvas's text field.** This is the recommended path because (a) no Canvas upload size limit applies — Canvas just stores the link, (b) your Alamo SSO identity is bound to the recording's metadata automatically, and (c) every student has cloud-recording entitlement on their institution Zoom account, so no software install is needed.

**Fallback path:** local OS recorder + Canvas file attachment, for the rare case Zoom Cloud isn't an option.

**See [`screencast-howto.md`](screencast-howto.md) for the full step-by-step recording instructions — Zoom Cloud setup, the local fallback, sharing-permissions guidance, privacy-during-recording, and what to do when something goes wrong.** Do not skip that document on your first lab.

High-level requirements (the rubric checks these regardless of which path you chose):

- Single continuous recording. No cuts. No editing.
- Starts with `whoami && hostname && date` visible on screen.
- Ends by displaying `output/verify-report.json`.
- Minimum length: 10 minutes. (Lab 00 is short; you can fill the time by talking through what you're doing, reading the README/PLATFORM_SETUP on screen, or showing your setup. The integrity anchor is what's visible on screen end-to-end, not how busy each minute is.)
- **Zoom path:** sharing set to "Internal users only." Link pasted in Canvas text field.
- **Local fallback:** MP4 H.264 (or macOS's native MOV) under 500 MB. Filename `screencast-<your-last-name>-<YYYYMMDD>.mp4` (or `.mov` for macOS Screen Recording). Canvas file attachment.
- **Never committed to GitHub** — Zoom links don't go in the repo, and local recordings' file extensions are `.gitignore`d.

## 2. AI Use Log

This lab's AI policy is **AI-FREE**. First lab; focus is environment setup and the integrity-anchor habits, not AI use.

The AI Use Log is **not required** for this lab. The point of this lab is to install Docker, run a tiny container, and submit the artifacts — there's no substantive work an LLM would meaningfully help with. If you used an LLM to help install Docker (e.g., to debug a platform-specific install error), feel free to mention it informally in your Canvas submission comments, but no formal Use Log is graded.

Subsequent labs ARE in AI-OPEN or AI-REQUIRED tiers and DO require the Use Log. Familiarize yourself with the template at [`../AI_USE_LOG.template.md`](../AI_USE_LOG.template.md) so you're ready when Module 1 begins.

## Identity binding (how the grader knows it's you)

There is no separate biometric prompt in this course. Identity is bound to your work in two places, both via your Alamo SSO credential:

1. **At record time** — when you start the Zoom Cloud recording with your Alamo Colleges Zoom account, Zoom's metadata captures your authenticated SSO identity on the recording. The grader can verify the named participant in Zoom matches the named Canvas submitter.
2. **At submit time** — Canvas requires SSO sign-in. Your submission is bound to that authenticated session.

The practical implication: protect your Alamo SSO credential the way you'd protect any other work credential.

---

## What the grader is verifying

When the instructor opens your submission, they:

1. Open your `verify-report.json` and confirm `"fail": 0`.
2. Watch the first 90 seconds of your screencast to confirm hostname, the typed name line, and the terminal visibility.
3. Confirm the Zoom recording's authenticated participant matches the named Canvas submitter (Zoom path) — or for the local fallback, confirm the screencast filename and the embedded identifying terminal output line up with the submitter.
4. For labs that require an AI Use Log (Lab 00 does NOT): spot-check the log against the screencast — claims in the log should match what they see you doing on screen.

If any of those four fail, the grader has the option of requesting a follow-up artifact rather than auto-zeroing — but the rubric is conservative by design.
