# Platform Setup

This is the one-time setup you do before starting Lab 00. Once you finish the steps for your operating system, every lab in this course will work on this machine.

## Before you begin

> **You need admin rights on the machine you'll use for this course.** Docker, WSL2, and Wireshark all require administrator access to install. Borrowed school laptops where you don't have admin won't work. If that's your situation, please contact the registrar or instructor before the add/drop deadline.

**Hardware floor:** 8 GB RAM, ~15 GB free disk, broadband for image pulls.

**Time budget:**
- Windows: ~60 minutes (most of it waiting for installers)
- macOS: ~20 minutes
- Linux: ~10 minutes

Jump to your platform:
- [Windows (with admin)](#windows-with-admin)
- [macOS (Intel or Apple Silicon)](#macos-intel-or-apple-silicon)
- [Linux (Debian / Ubuntu)](#linux-debian--ubuntu)

---

## Windows (with admin)

**Mental model:** You're installing two things in two places. Ubuntu (and your command line) live *inside* WSL — that's a Linux environment running on top of Windows. Docker Desktop and Wireshark live in Windows itself but talk to Ubuntu under the hood. Your terminal home for the rest of this course is the **Ubuntu** window — that's where you'll spend the rest of the semester.

### Step 1 — Open PowerShell as administrator

- Right-click the Windows **Start** button.
- On **Windows 11**: click **Terminal (Admin)**.
- On **Windows 10**: click **Windows PowerShell (Admin)**.
- Click **Yes** on the User Account Control (UAC) prompt.

*Keyboard shortcut alternative:* press `Win + X`, then press `A`.

> **If a later command says "The requested operation requires elevation"** — you didn't open the window as admin. Close it and redo this step.

### Step 2 — Install WSL2 + Ubuntu

In the admin PowerShell window, type exactly:

```powershell
wsl --install
```

Press Enter. You'll see download progress (~2 GB total). When it finishes the prompt tells you to restart your computer. **Reboot now.**

> If the command says "Windows Subsystem for Linux is already installed" or you see "Ubuntu" appear without a reboot prompt, you're good — go to Step 3.

### Step 3 — First-launch Ubuntu

After the reboot finishes, **Ubuntu launches automatically in a new window** (this may take 1–2 minutes the first time — be patient). It prompts:

```
Enter new UNIX username:
```

Type a lowercase username (your first name works — e.g., `aaron`) and press Enter. Then:

```
New password:
```

Type a password. **You will NOT see anything appear as you type. This is normal — Linux hides password input by design.** Press Enter; retype the same password; Enter again.

You're now at an Ubuntu shell prompt that looks like:

```
aaron@LAPTOP-XYZ:~$
```

That prompt is your home base for this course.

To relaunch Ubuntu later: Start → type "Ubuntu" → Enter.

### Step 4 — Install Docker Desktop

Open a browser and go to **https://www.docker.com/products/docker-desktop/**.

Click **Download for Windows** — on most laptops the **AMD64** button. (If you have a Snapdragon ARM laptop, pick ARM64 — they're labeled clearly.)

Run the downloaded `Docker Desktop Installer.exe`. When the installer asks about configuration, **leave "Use WSL 2 instead of Hyper-V" checked** (default). Click OK and wait — install takes ~5 minutes.

When prompted, **sign out of Windows and sign back in** (or restart). Docker Desktop launches automatically.

> **If Docker Desktop says "WSL 2 installation is incomplete"** — the WSL kernel update is missing. Click the link in the dialog to install it, then restart Docker Desktop.

### Step 5 — Verify Docker is talking to WSL

Open the **Docker Desktop** application from the Start menu. Wait for the whale icon in the system tray (bottom-right corner of Windows) to **stop animating** — that means the daemon is up.

> **One-time setup: enable WSL Integration.** Docker Desktop only exposes the `docker` command inside WSL distros you opt in. Click the whale icon → **Settings** → **Resources** → **WSL Integration** → toggle on your **Ubuntu** distro → click **Apply & Restart**. (If you skip this step, Ubuntu will say `command not found: docker` even though Docker Desktop is running on Windows.)

Launch Ubuntu (Start → Ubuntu) and run:

```bash
docker run hello-world
```

Expected output (something like):

```
Hello from Docker!
This message shows that your installation appears to be working correctly.
...
```

> **If `docker run hello-world` says "Cannot connect to the Docker daemon" or "command not found"** — either Docker Desktop isn't fully started (check the system tray icon, give it 30 more seconds, retry) OR WSL Integration isn't enabled for your Ubuntu distro (see the box above).

### Step 6 — Install Wireshark on Windows

Open a browser and go to **https://www.wireshark.org/download.html**.

Click **Windows x64 Installer** (the .msi).

Run the installer. About halfway through, it asks whether to install **Npcap** — **click Yes**. Npcap is the driver that lets Wireshark capture live traffic. Accept Npcap's default options.

**Important:** Wireshark is installed *on Windows itself*, not inside Ubuntu. To open a pcap file from your Ubuntu home directory in Wireshark, point Wireshark at this path:

```
\\wsl.localhost\Ubuntu\home\<your-ubuntu-username>\<rest-of-path>
```

You can also drag-and-drop a `.pcap` from File Explorer onto the Wireshark icon.

### Step 7 — Install git, python3, gh CLI inside Ubuntu

In your Ubuntu window:

```bash
sudo apt update
sudo apt install -y git python3 python3-pip gh
```

When `sudo` asks for a password, it's your **Ubuntu** password from Step 3 (not your Windows password).

> **If `apt install gh` reports "Unable to locate package gh"** — your Ubuntu version doesn't have GitHub CLI in its default repo. Follow the official keyring install at <https://github.com/cli/cli/blob/trunk/docs/install_linux.md> (it's a copy-paste block), then re-run `sudo apt install -y gh`.

### Step 8 — Set your git identity

```bash
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"
```

The email shows publicly on commits to public repositories. Use your school email, or set up a GitHub privacy "noreply" address ([instructions](https://docs.github.com/account-and-profile/setting-up-and-managing-your-personal-account-on-github/managing-email-preferences/setting-your-commit-email-address)) if you'd rather not publish your personal address.

### Step 9 — Verify everything

In Ubuntu, paste this block and confirm every line returns a sensible value:

```bash
docker run hello-world
git --version
python3 --version
gh --version
git config --global user.name
git config --global user.email
```

Then verify Wireshark: open the Start menu, click **Wireshark**, confirm the application opens without errors. (`wireshark --version` from Ubuntu won't find it — that's expected; Wireshark lives in Windows.)

**If every check passed, you're done.** Continue to [GIT_QUICKSTART.md](GIT_QUICKSTART.md) before running Lab 00.

---

## macOS (Intel or Apple Silicon)

### Step 1 — Install Xcode CLI tools (gets git for free)

Open Terminal (Cmd-Space → "Terminal") and run:

```bash
xcode-select --install
```

A GUI prompt appears — click **Install**. Wait ~5 minutes. (If it says the tools are already installed, you're good.)

### Step 2 — Install a Docker runtime

Two reasonable choices. **Colima is lighter weight and recommended.** Docker Desktop is the default if you prefer a GUI tray icon.

> **Prerequisite — Homebrew.** Every macOS command below uses `brew`. If you don't have it yet, install it first from <https://brew.sh> (one paste-and-run command; the installer asks for your password and takes ~3 minutes). Confirm with `brew --version` before continuing.

**Option A — Colima (recommended):**

```bash
brew install colima docker docker-compose
colima start
```

**Option B — Docker Desktop:**

Download from https://www.docker.com/products/docker-desktop/ → install the .dmg → drag to Applications → launch from Applications.

Either way, verify:

```bash
docker run hello-world
```

### Step 3 — Install Wireshark

```bash
brew install --cask wireshark-app
```

> **Note on the cask name:** Homebrew renamed the GUI cask from `wireshark` to `wireshark-app`. The `wireshark` formula in homebrew-core is now CLI utilities only (`tshark`, `editcap`, etc.), not the GUI you'll use to open pcaps.

The `wireshark-app` cask bundles the ChmodBPF helper installer and prompts you for your macOS password during install — accept the prompt so Wireshark can read live packets from BPF devices without sudo. (There's a separate `wireshark-chmodbpf` cask in Homebrew that conflicts with `wireshark-app`; you don't need it unless you installed Wireshark some other way.)

### Step 4 — Install python3 and gh CLI

```bash
brew install python3 gh
```

### Step 5 — Set your git identity

```bash
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"
```

The email shows publicly on commits. Use your school email or a GitHub privacy "noreply" address ([instructions](https://docs.github.com/account-and-profile/setting-up-and-managing-your-personal-account-on-github/managing-email-preferences/setting-your-commit-email-address)).

### Step 6 — Verify everything

```bash
docker run hello-world
git --version
python3 --version
gh --version
git config --global user.name
git config --global user.email
```

Then verify Wireshark: open it from Spotlight (Cmd-Space → "Wireshark"). The app should launch. (`wireshark --version` from Terminal won't find it — Homebrew's GUI cask installs to `/Applications/Wireshark.app`, not your `$PATH`.)

If every check passed, you're done. Continue to [GIT_QUICKSTART.md](GIT_QUICKSTART.md) before running Lab 00.

---

## Linux (Debian / Ubuntu)

> **Other Linux distros.** The commands below use `apt`. If you're on Fedora/RHEL, swap to `dnf`; on Arch, swap to `pacman`; on openSUSE, swap to `zypper`. Package names are usually the same (`docker.io` / `docker-compose-v2` may be `docker` / `docker-compose-plugin` elsewhere). If a step doesn't translate cleanly, message your instructor on Canvas Inbox.

### Step 1 — Install everything in one shot

```bash
sudo apt update
sudo apt install -y docker.io docker-compose-v2 git python3 python3-pip wireshark gh
```

If `gh` isn't in your distro's repo (older Debian/Ubuntu), follow https://github.com/cli/cli/blob/trunk/docs/install_linux.md to add the keyring first, then `sudo apt install -y gh`.

### Step 2 — Allow non-root packet capture (Debian/Ubuntu prompt)

During the `apt install wireshark` in Step 1, an interactive prompt asks **"Should non-superusers be able to capture packets?"** Answer **Yes**. If you missed the prompt (or said No), re-run:

```bash
sudo dpkg-reconfigure wireshark-common
```

and select Yes when it asks again.

### Step 3 — Add yourself to the docker and wireshark groups

```bash
sudo usermod -aG docker $USER
sudo usermod -aG wireshark $USER
```

**Log out and log back in** for the new group memberships to take effect, then verify with `groups`. (Some online guides suggest `newgrp` to apply group changes without logging out — for two groups in one shell, that's unreliable; the logout/login path is the only one that consistently works.)

### Step 4 — Set your git identity

```bash
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"
```

The email shows publicly on commits.

### Step 5 — Verify everything

```bash
docker run hello-world
git --version
python3 --version
gh --version
wireshark --version
git config --global user.name
git config --global user.email
```

If every line returns a sensible value, you're done. Continue to [GIT_QUICKSTART.md](GIT_QUICKSTART.md) before running Lab 00.

---

## You're done

If your platform's "Verify everything" step printed sensible values for every command, your environment is ready for the entire course.

Next steps:

1. Read [GIT_QUICKSTART.md](GIT_QUICKSTART.md) — git basics + the fork-and-submit pattern this course uses.
2. Start [Lab 00](../README.md).

If anything didn't work, the [troubleshooting doc](troubleshooting.md) has the common fixes.
