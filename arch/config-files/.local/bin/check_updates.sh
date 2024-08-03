#!/usr/bin/env zsh

# Check for updates and count the number of available updates
update_count=$(checkupdates 2>/dev/null | wc -l)

# Construct JSON output
if (( update_count > 0 )); then
    output="{\"text\":\"$update_count updates\", \"tooltip\":\"$update_count available updates\"}"
else
    output="{\"text\":\"No updates\", \"tooltip\":\"No updates available\"}"
fi

# Print JSON output
echo "$output"
