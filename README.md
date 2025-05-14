# Battery Alert Script

This script reminds you to plug in your PC when the battery level is low. It uses `dunst` and `dunstify` to send notifications to your screen and updates a log file every time it runs.

## Features
- Sends a notification via `dunst` to remind you to plug in your PC when battery level is low.
- Runs automatically at reboot and every 5 minutes using **cron**.
- Updates a log file with the status of the battery each time the script runs.

## Requirements

Before using the script, make sure you have the following installed:

- **`dunst`** - A lightweight notification daemon.
- **`dunstify`** - A command-line utility for sending notifications through `dunst`.
- **Fish Shell** - The script is written in Fish shell.
- **Cron** - To schedule the script to run at reboot and every 5 minutes. (You can change it :) .)

You can install `dunst` and `dunstify` on your system by following the appropriate installation instructions for your distribution.

The repo include a sample crontab you can use and tweak and a dunstrc file to have "nice" notifications.
