#!/bin/bash

# Restore Device Normal State Script for Termux
# Developer: Claude
# Version: 1.0
# Description: Reverts changes made by the ASUS ROG 10 spoofing script

# Function to check if device is rooted
check_root() {
    if [ "$(id -u)" -eq 0 ] || command -v su >/dev/null 2>&1; then
        IS_ROOTED=true
        echo "Root access detected"
    else
        IS_ROOTED=false
        echo "No root access detected"
    fi
}

# Function to execute commands with root if available
run_with_root() {
    if [ "$IS_ROOTED" = true ]; then
        su -c "$1"
    else
        eval "$1"
    fi
}

# Function to restore original device name and properties
restore_device_properties() {
    echo "Restoring original device properties..."
    
    # For non-rooted devices, clear modified settings
    settings delete global device_name >/dev/null 2>&1
    settings delete system device_name >/dev/null 2>&1
    settings delete secure device_name >/dev/null 2>&1
    settings delete global asus_device_name >/dev/null 2>&1
    settings delete system model >/dev/null 2>&1
    settings delete system manufacturer >/dev/null 2>&1
    settings delete global model >/dev/null 2>&1
    
    # If we have root, restore system properties
    if [ "$IS_ROOTED" = true ]; then
        # Store original device info before doing anything
        ORIGINAL_BRAND=$(getprop ro.product.brand)
        ORIGINAL_MODEL=$(getprop ro.product.model)
        ORIGINAL_MANUFACTURER=$(getprop ro.product.manufacturer)
        
        # Reset all modified properties
        run_with_root "resetprop --delete ro.product.brand"
        run_with_root "resetprop --delete ro.product.manufacturer"
        run_with_root "resetprop --delete ro.product.model"
        run_with_root "resetprop --delete ro.product.marketname"
        run_with_root "resetprop --delete ro.product.system.marketname"
        run_with_root "resetprop --delete ro.product.system.model"
        run_with_root "resetprop --delete ro.product.vendor.model"
        run_with_root "resetprop --delete ro.product.vendor.marketname"
        run_with_root "resetprop --delete ro.product.vendor.manufacturer"
        run_with_root "resetprop --delete ro.product.vendor.brand"
        run_with_root "resetprop --delete ro.product.odm.marketname"
        run_with_root "resetprop --delete ro.product.odm.model"
        run_with_root "resetprop --delete ro.product.product.marketname"
        run_with_root "resetprop --delete ro.product.product.model"
        run_with_root "resetprop --delete ro.build.product"
        
        # Reset chipset spoofing
        run_with_root "resetprop --delete ro.vendor.soc.model.external_name"
        run_with_root "resetprop --delete ro.vendor.soc.model.part_name"
        run_with_root "resetprop --delete ro.soc.manufacturer"
        run_with_root "resetprop --delete ro.soc.model"
        run_with_root "resetprop --delete ro.hardware.chipname"
        run_with_root "resetprop --delete ro.chipname"
    fi
}

# Function to revert performance optimizations
restore_performance_settings() {
    echo "Restoring original performance settings..."
    
    if [ "$IS_ROOTED" = true ]; then
        # Reset root performance tweaks
        run_with_root "resetprop --delete debug.egl.force_msaa"
        run_with_root "resetprop --delete debug.hwui.use_gpu_pixel_buffers"
        run_with_root "resetprop --delete debug.hwui.render_dirty_regions"
        run_with_root "resetprop --delete debug.hwui.disable_vsync"
        run_with_root "resetprop --delete debug.sf.latch_unsignaled"
        run_with_root "resetprop --delete debug.sf.disable_backpressure" 
        run_with_root "resetprop --delete debug.composition.type"
        
        # Reset gaming optimizations
        run_with_root "resetprop --delete debug.enable_game_driver"
        run_with_root "resetprop --delete debug.game_driver_prerelease"
        run_with_root "resetprop --delete debug.enable_game_driver_all_apps"
        run_with_root "resetprop --delete debug.egl.traceGpuCompletion"
        
        # Reset refresh rate improvements
        run_with_root "resetprop --delete ro.surface_flinger.enable_frame_rate_override"
        run_with_root "resetprop --delete debug.display.allow_non_native_refresh_rate_override"
        run_with_root "resetprop --delete debug.display.render_frame_rate_is_physical_refresh_rate"
    else
        # Reset non-root optimizations
        settings delete global debug.enable_game_driver
        settings delete global debug.game_driver_prerelease
        settings delete global debug.enable_game_driver_all_apps
        
        # Reset memory & performance
        settings delete global ram_expand_size_limit
        settings delete global cached_apps_freezer
        settings delete global app_standby_enabled
        settings delete global adaptive_battery_management_enabled
        
        # Reset refresh rate
        settings delete system min_refresh_rate
        settings delete system peak_refresh_rate
        
        # Reset game optimizer
        settings delete secure gaming_mode_enabled
        settings delete global high_performance_mode_enabled
        settings delete global low_power
        
        # Reset graphics performance
        settings delete global opengl_traces
        settings delete global debug_view_attributes
        settings delete global show_refresh_rate_switch
    fi
}

# Show notification
cmd notification post -S bigtext -t 'Device Restore' 'System' 'STARTING RESTORATION PROCESS' > /dev/null 2>&1
clear
echo ""
echo "█▓▒▒░░░ DEVICE RESTORATION TOOL ░░░▒▒▓█"
echo ""
sleep 0.5

# Display device information before restoration
echo "│ Current Device Info (before restoration):       │"
echo "│ 📱 Device        : $(getprop ro.product.manufacturer) $(getprop ro.product.model) │"
echo "│ 🆔 Model         : $(getprop ro.product.model) │"
echo "│ 🏭 Manufacturer  : $(getprop ro.product.manufacturer) │"
echo "│ 📱 Marketname    : $(getprop ro.product.marketname 2>/dev/null || echo "N/A") │"
echo "└───────────────────────────────────────────────┘"
echo ""

# Check for root
check_root
echo "│ 🛑 Root          : $(if [ "$IS_ROOTED" = true ]; then echo 'Yes'; else echo 'No'; fi) │"
echo ""
echo "█▓▒▒░░░ STARTING RESTORATION PROCESS ░░░▒▒▓█"
echo ""
sleep 0.5

# Restore device properties
restore_device_properties

# Restore performance settings
restore_performance_settings

# If rooted, restart system services to apply changes
if [ "$IS_ROOTED" = true ]; then
    echo "Restarting system services to apply changes..."
    run_with_root "setprop ctl.restart surfaceflinger" > /dev/null 2>&1
    run_with_root "killall -TERM android.hardware.graphics.composer" > /dev/null 2>&1
fi

# Verify changes
echo ""
echo "Verifying restoration..."
sleep 1

# Display device information after restoration
echo "│ Current Device Info (after restoration):        │"
echo "│ 📱 Device        : $(getprop ro.product.manufacturer) $(getprop ro.product.model) │"
echo "│ 🆔 Model         : $(getprop ro.product.model) │"
echo "│ 🏭 Manufacturer  : $(getprop ro.product.manufacturer) │"
echo "│ 📱 Marketname    : $(getprop ro.product.marketname 2>/dev/null || echo "N/A") │"
echo "└───────────────────────────────────────────────┘"
echo ""

echo "█▓▒▒░░░ RESTORATION PROCESS COMPLETE [✓] ░░░▒▒▓█"
sleep 0.5
echo ""
echo "SUCCESSFULLY RESTORED DEVICE TO ORIGINAL STATE"
sleep 2.0
echo ""
echo "Your device has been restored to its original configuration."
echo "All ASUS ROG 10 spoofing has been removed."
echo ""
sleep 0.5
echo ""
echo "█▓▒▒░░░ DEVICE RESTORED SUCCESSFULLY ░░░▒▒▓█"
echo ""
cmd notification post -S bigtext -t 'Device Restore' 'System' 'DEVICE RESTORED TO ORIGINAL STATE' > /dev/null 2>&1

# End of script