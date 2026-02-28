# Introduction

This is a simple install and updater script for Stoat, an open source alternative for discord.

This script will download Stoat from the official GitHub repo, install it, and create an entry in your application launcher. If you run the script again, it will tell you which version you currently have installed and let you know if there's an update.

# Usage

## Automatic download/install

Copy/paste this command to automatically download and run this script:

```shell
git clone https://github.com/JshKlsn/stoat_install_script && cd stoat_install_script && chmod +x stoat_install.sh && ./stoat_install.sh
```

# Changes

This script has a few big changes from the original.

- Downloads the latest version every time.
- Checks which version you have installed and compares it to the latest version (creates version file on first run, and compares it on subsequent runs).
- Adds error handling for wget and unzip.
- Adds "Discord" keyword to desktop file, so Stoat shows up when you search for "Discord" in your launcher.

# About 

All files downloaded by this script come from the the official Stoat GitHub repo.

NO AI was used in this project. Feel free to improve my crappy code with a PR.

Original script by Sylphux. Modified by JshKlsn.
