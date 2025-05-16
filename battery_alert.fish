#!/usr/bin/env fish

# Set configuration variables
set threshold 20
set icon_path ~/Images/icons/empty_battery.svg
set notification_title "Battery Alert"
set notification_message "Charge your laptop"
set log_file ~/battery_monitor.log
set -x DISPLAY :0

# Function to log messages
function log_message
    echo (date "+%Y-%m-%d %H:%M:%S") " - $argv" >> $log_file
end

# Get the current battery info and store it in lowercase
set battery_info (string lower (acpi -b))
set battery_percentage (echo $battery_info | grep -oP '\d+(?=%)')

# Check if the battery percentage was retrieved successfully
if test -z "$battery_percentage"
    log_message "Failed to retrieve battery percentage."
    exit 1
end

# Log the current battery percentage
log_message "Current battery percentage: $battery_percentage%"

# Check if the battery percentage is below the threshold and the battery is discharging
if test $battery_percentage -lt $threshold
    if string match -q "*discharging*" "$battery_info"

        set full_notification_message "$notification_message: $battery_percentage%"
        
        # Attempt to send the notification and capture any errors
        set dunstify_output (dunstify "$notification_title" "$full_notification_message" -i $icon_path -u critical 2>&1)
        
        # Check if dunstify returned an error
        if test $status -ne 0
            log_message "dunstify error: $dunstify_output"
            log_message "dunstify arguments: $notification_title, $full_notification_message, -i $icon_path, -u critical"
            
            # Send a fallback notification
            set fallback_message "Something went wrong, check the log at: $log_file"
            dunstify "Error" "$fallback_message" -u critical
        else
            log_message "Notification sent: $full_notification_message"
        end
    else 
        log_message "The laptop is plugged in"
    end
else
    log_message "Battery percentage is above threshold: $battery_percentage% (above $threshold%)"
end

