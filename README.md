# vnstat-data-usage

A comprehensive shell script that checks if `vnstat` is installed, installs it if necessary, and filters network data usage for a user-specified date range. This script uses `vnstat -d` to display the total and cumulative network usage in GiB between two given dates.

## Features

- Automatically installs `vnstat` if it's not found on the system.
- Filters network data usage based on a user-defined start and end date.
- Converts and displays daily and cumulative data usage in GiB for easier readability.
- Provides clear output with headers for "Day", "Total", and "Cumulative" data usage.

## Prerequisites

- A Linux-based system with one of the following package managers:
  - `apt` (e.g., Ubuntu, Debian)
  - `yum` (e.g., CentOS, RHEL)
  - `dnf` (e.g., Fedora)

## Usage

Clone the repository and run the script:

``` bash
git clone https://github.com/medovanx/vnstat-data-usage.git
cd vnstat-data-usage
chmod +x vnstat-usage.sh
./vnstat-usage.sh <start-date> <end-date>