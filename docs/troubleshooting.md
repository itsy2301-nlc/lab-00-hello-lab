# Troubleshooting — Lab 00 Hello Lab

Run through this list before posting on the Q&A board.

## "command not found: docker"

You haven't installed Docker yet. Return to Module 0 — Hello Lab.

- **macOS:** install Colima — `brew install colima docker docker-compose` then `colima start`.
- **Windows:** install [Docker Desktop](https://www.docker.com/products/docker-desktop/) with the WSL2 backend.
- **Linux:** `sudo apt install docker.io docker-compose-v2` (Debian/Ubuntu) or your distro's equivalent.

## "Cannot connect to the Docker daemon"

The daemon isn't running.

- macOS Colima: `colima start`.
- macOS Docker Desktop / Windows: open the Docker Desktop app and wait for it to say "Engine running."
- Linux: `sudo systemctl start docker`.

## "permission denied" running scripts

Make them executable: `chmod +x scripts/*.sh`.

## Docker Desktop on Windows: "WSL 2 installation is incomplete"

Microsoft's official guide: <https://learn.microsoft.com/en-us/windows/wsl/install>.

## Running on a low-memory laptop (≤4 GB)

The lab containers fit within Docker's ~2 GB overhead plus their own footprint, but on a 4 GB host you may need to close your browser before running the verifier. If a lab still won't start, message your instructor through Canvas Inbox — the course supports a borrow-a-lab-machine option for students whose hardware can't run the labs.

## Lab-specific issues

### `docker compose up` hangs forever on the first pull

Network/DNS issue. Try:

1. `docker pull alpine:3.23` directly. If that hangs, your Docker daemon can't reach Docker Hub.
2. Check your DNS: `nslookup registry-1.docker.io`. If it fails, fix your DNS first.
3. On corporate/campus networks you may need to configure Docker's proxy settings.

### `output/identity.txt` is empty, or `verify-report.json` shows `fail > 0`

`docker compose up` exited before the container's command finished. Re-run `./scripts/start.sh` and read the output carefully. If it still fails, capture the full output along with `docker version` and post on the Q&A board — the lab uses `alpine:3.23` which is multi-arch, so unusual failures here are more likely transient daemon/network issues than image-arch mismatches.

### Colima on macOS: "VM does not exist"

You haven't started Colima. Run `colima start` (~30 seconds on first run).

### Permission denied on `/var/run/docker.sock` (Linux)

You're not in the `docker` group. `sudo usermod -aG docker $USER`, then log out and log back in. Verify with `groups`.

## When all else fails

Post on the Q&A discussion board with:

- Your operating system + Docker/Colima version (`docker version`).
- The exact command you ran.
- The exact output (paste, don't paraphrase).
- What you've already tried.

Other students answering substantively earns up to 5 pts of Module participation per term. Your instructor responds within 24–48 hours per the course policy.
