# Log Cleanup Script

A Bash script for cPanel/Linux servers that cleans common log files, Laravel logs, Razor logs, Analog cache files, Apache logs, and old PHP sessions.

## Download

```bash
curl -sSL https://raw.githubusercontent.com/waytohost/cleanup/main/log_cleanup.sh -o log_cleanup.sh
chmod +x log_cleanup.sh
```

## Run

```bash
./log_cleanup.sh
```

Or run directly without saving:

```bash
curl -sSL https://raw.githubusercontent.com/waytohost/cleanup/main/log_cleanup.sh | bash
```

## Features

* Clears `error_log` files in `public_html`
* Clears account `error.log` files
* Removes compressed log files (`*.gz`) in /home
* Clears Razor agent logs in /home
* Clears Analog cache files in /home
* Clears Laravel logs in /home
* Clears Apache domlogs
* Deletes PHP session files older than 120 minutes

