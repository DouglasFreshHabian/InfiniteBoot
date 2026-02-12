# Infinite Boot Simulator - Fresh Forensics Edition

A **visual-only Bash boot simulation engine** that recreates realistic Linux startup sequences directly in your terminal.

Designed for **demos, tutorials, screen recordings, livestreams, and terminal aesthetics** — without modifying your system or interacting with real services.

InfiniteBoot mimics the *look and feel* of:

* Raw Linux kernel boot output
* systemd `[  OK  ]` aligned service initialization
* `journalctl -f` live log streaming
* Disk encryption unlock prompts
* Service failures and automatic recovery

> ⚠️ **Simulation only** — no real services are started, stopped, modified, or monitored.

---

## Features

* ✅ Infinite kernel-style boot simulation
* ✅ Realistic systemd `[  OK  ]` formatting
* ✅ journalctl-style live log stream mode
* ✅ Fake disk encryption unlock prompt
* ✅ Randomized timestamps and memory values
* ✅ Random service failures with auto-recovery
* ✅ Real hostname detection
* ✅ Clean CLI flags and colorized `--help`
* ✅ Safe for recording, teaching, and presentations

---

## Usage

Make the script executable:

```bash
chmod +x infiniteBoot.sh
```

Run default infinite boot mode:

```bash
./infiniteBoot.sh
```

Run journal mode (boot → login → infinite journal):

```bash
./infiniteBoot.sh --journal
```

Run systemd-style boot mode:

```bash
./infiniteBoot.sh --systemd
```

Display the help menu:

```bash
./infiniteBoot.sh --help
```

Show version information:

```bash
./infiniteBoot.sh --version
```

---

## Command-Line Options

| Option            | Description                                   |
| ----------------- | --------------------------------------------- |
| `--journal`       | Boot + login + infinite journalctl simulation |
| `--systemd`       | Realistic systemd-style infinite boot         |
| `--help`, `-h`    | Display help menu and exit                    |
| `--version`, `-v` | Show version information                      |

---

## What This Tool Does *Not* Do

This script **does not**:

* ❌ Modify system services
* ❌ Interact with systemd
* ❌ Access system logs
* ❌ Monitor real hardware
* ❌ Change boot configuration
* ❌ Access disk encryption
* ❌ Interact with the kernel in any way

All output is **randomly generated and purely visual**.

---

## Use Cases

* 🎥 YouTube cybersecurity B-roll
* 🧠 Teaching Linux boot processes safely
* 🎤 Conference demos and presentations
* 🖥️ Terminal screensaver aesthetics
* 📚 Documentation screenshots
* 🔴 Livestream background visuals

---

## Requirements

* Bash (GNU Bash recommended)
* `tput`
* A terminal that supports ANSI colors

No additional dependencies required.

Tested on:

* Debian
* Kali Linux
* Ubuntu

---

## Modes Overview

### Default Mode

Simulates a forensic-themed infinite kernel boot with:

* Service initialization
* Randomized memory detection
* Occasional failure + recovery
* Endless service activity

---

### Journal Mode

Simulates:

1. Kernel boot
2. Disk unlock
3. Login prompt
4. Infinite `journalctl -f` style logging

---

### systemd Mode

Simulates a realistic Debian/Kali-style systemd boot sequence featuring:

* Properly aligned `[  OK  ]` formatting
* Service start/target transitions
* Random dependency failures
* Background reload messages

---

## Disclaimer

This project is intended **strictly for educational, demonstration, and visual purposes**.

It does **not** interact with your operating system or modify system behavior.
All output is simulated.

---

## License

MIT License — feel free to fork, modify, and adapt for demos or educational content.

---

### ☕ Support This Project

If **InfiniteBoot** enhances your terminal demos, consider supporting continued development:

<p align="center">
  <a href="https://www.buymeacoffee.com/dfreshZ" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>
</p>

<!-- 
 _____              _       _____                        _          
|  ___| __ ___  ___| |__   |  ___|__  _ __ ___ _ __  ___(_) ___ ___ ™️
| |_ | '__/ _ \/ __| '_ \  | |_ / _ \| '__/ _ \ '_ \/ __| |/ __/ __|
|  _|| | |  __/\__ \ | | | |  _| (_) | | |  __/ | | \__ \ | (__\__ \
|_|  |_|  \___||___/_| |_| |_|  \___/|_|  \___|_| |_|___/_|\___|___/
        freshforensicsllc@tuta.com Fresh Forensics, LLC 2026 -->
