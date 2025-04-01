#!/bin/bash

# ASUS ROG 10 Script for Termux Brevent Qute
# Developer: Willy Gailo
# Version: 2.1

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

# Function to apply device name spoofing regardless of root status
spoof_device_name() {
    echo "Applying device spoofing..."
    
    # These commands will work on non-rooted devices
    settings put global device_name "ROG Phone 10" >/dev/null 2>&1
    
    # If we have root, add these more powerful spoofing commands
    if [ "$IS_ROOTED" = true ]; then
        (
        # Spoofing ROG PHONE 10 - system props (needs root)
        run_with_root "resetprop ro.product.brand asus"
        run_with_root "resetprop ro.product.manufacturer asus"
        run_with_root "resetprop ro.product.model ASUSAI2601"
        run_with_root "resetprop ro.product.marketname 'ASUS ROG 10'"
        run_with_root "resetprop ro.product.system.marketname 'ASUS ROG 10'"
        run_with_root "resetprop ro.product.system.model ASUSAI2601"
        run_with_root "resetprop ro.product.vendor.model ASUSAI2601"
        run_with_root "resetprop ro.product.vendor.marketname 'ASUS ROG 10'"
        run_with_root "resetprop ro.product.vendor.manufacturer asus"
        run_with_root "resetprop ro.product.vendor.brand asus"
        run_with_root "resetprop ro.product.odm.marketname 'ASUS ROG 10'"
        run_with_root "resetprop ro.product.odm.model ASUSAI2601"
        run_with_root "resetprop ro.product.product.marketname 'ASUS ROG 10'"
        run_with_root "resetprop ro.product.product.model ASUSAI2601"
        run_with_root "resetprop ro.build.product ASUSAI2601"
        
        # Fallback to setprop if resetprop is not available
        run_with_root "setprop ro.product.brand asus"
        run_with_root "setprop ro.product.manufacturer asus"
        run_with_root "setprop ro.product.model ASUSAI2601"
        run_with_root "setprop ro.product.marketname 'ASUS ROG 10'"
        run_with_root "setprop ro.product.system.marketname 'ASUS ROG 10'"
        run_with_root "setprop ro.product.system.model ASUSAI2601"
        run_with_root "setprop ro.product.vendor.model ASUSAI2601"
        run_with_root "setprop ro.product.vendor.marketname 'ASUS ROG 10'"
        
        # Spoof Chipset (Qualcomm Snapdragon 8 Gen 3)
        run_with_root "resetprop ro.vendor.soc.model.external_name 'Qualcomm® Snapdragon™ 8 Gen 3'"
        run_with_root "resetprop ro.vendor.soc.model.part_name SM8650-AC"
        run_with_root "resetprop ro.soc.manufacturer Qualcomm"
        run_with_root "resetprop ro.soc.model 'Snapdragon™ 8 Gen 3'"
        run_with_root "resetprop ro.hardware.chipname SM8650-AC"
        run_with_root "resetprop ro.chipname SM8650-AC"
        ) >/dev/null 2>&1
    else
        # Additional settings for non-rooted devices to try to change appearance
        settings put system device_name "ROG Phone 10" >/dev/null 2>&1
        settings put secure device_name "ROG Phone 10" >/dev/null 2>&1
        settings put global asus_device_name "ROG Phone 10" >/dev/null 2>&1
        settings put system model "ASUSAI2601" >/dev/null 2>&1
        settings put system manufacturer "asus" >/dev/null 2>&1
        settings put global model "ASUSAI2601" >/dev/null 2>&1
    fi
}

# Show notification
cmd notification post -S bigtext -t 'ASUS ROG 10' 'Willy Gailo' 'STARTING INSTALLATION PROCESS' > /dev/null 2>&1
clear
echo ""
echo "█▓▒▒░░░TERMUX BREVENT QUTE - ASUS ROG 10░░░▒▒▓█"
echo ""
sleep 0.5

# Display device information
echo "│ 👨‍💻 Developer: Willy Gailo                      │"
echo "│ 📱 Current Device : $(getprop ro.product.manufacturer) $(getprop ro.product.model) │"
echo "│ ⚙️ CPU           : $(getprop ro.board.platform) │"
echo "│ 🎮 GPU           : $(getprop ro.hardware) │"
echo "│ 📲 Android       : $(getprop ro.build.version.release) │"
echo "│ 🔥 Thermal       : $(cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null || echo "N/A")°C │"
echo "│ 🔰 Kernel        : $(uname -r) │"
echo "│ 🔹 Build         : $(getprop ro.build.display.id) │"

# Check for root
check_root
echo "│ 🛑 Root          : $(if [ "$IS_ROOTED" = true ]; then echo 'Yes'; else echo 'No'; fi) │"
echo "│ 🔗 SELinux       : $(getenforce 2>/dev/null || echo 'Unknown') │"
echo "└───────────────────────────────────────────────┘"
echo ""
echo "█▓▒▒░░░WELCOME TO BREVENT QUTE INSTALLATION░░░▒▒▓█"
echo ""
sleep 0.5
echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠔⠒⠉⠉⠉⠉⠒⠢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠔⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡜⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡄⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⡀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢇⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⣀⣏⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠘⡀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡠⠔⠒⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠢⢄⠀⠀⠀⠀⠀⢇⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⠔⠊⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⣄⠀⠀⠀⠘⡄⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢠⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢆⠀⠀⠀⢱⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢠⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢣⠀⠀⠀⡇⠀⠀⠀⠀
⠀⠀⠀⠀⠀⡎⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢇⠀⠀⢸⠀⠀⠀⠀
⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡄⠀⠸⡀⠀⠀⠀
⠀⠀⠀⠀⠀⢇⠀⠀⠀⠀⢀⣀⡠⠔⠊⠉⠉⠉⠉⠉⠉⠉⠑⠊⠉⠉⠉⠉⠉⠉⠉⠉⠉⠒⠦⢄⡀⠀⠀⠀⠀⠀⠀⠀⠀⢣⠀⠀⢇⠀⠀⠀
⠀⠀⠀⠀⠀⠘⡄⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠸⡀⠀⠸⡀⠀⠀"
echo ""
sleep 0.5
echo ""
echo "⠀⠀⠀⠀⣠⣶⡾⠏⠉⠙⠳⢦⡀⠀⠀⠀⢠⠞⠉⠙⠲⡀⠀
⠀⠀⠀⣴⠿⠏⠀⠀⠀⠀⠀⠀⢳⡀⠀⡏⠀⠀⠀⠀⠀⢷
⠀⠀⢠⣟⣋⡀⢀⣀⣀⡀⠀⣀⡀⣧⠀⢸⠀⠀⠀⠀⠀ ⡇
⠀⠀⢸⣯⡭⠁⠸⣛⣟⠆⡴⣻⡲⣿⠀⣸  OK   ⡇ 
⠀⠀⣟⣿⡭⠀⠀⠀⠀⠀⢱⠀⠀⣿⠀⢹⠀⠀⠀⠀⠀ ⡇
⠀⠀⠙⢿⣯⠄⠀⠀⠀⢀⡀⠀⠀⡿⠀⠀⡇⠀⠀⠀⠀⡼
⠀⠀⠀⠀⠹⣶⠆⠀⠀⠀⠀⠀⡴⠃⠀⠀⠘⠤⣄⣠⠞⠀
⠀⠀⠀⠀⠀⢸⣷⡦⢤⡤⢤⣞⣁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢀⣤⣴⣿⣏⠁⠀⠀⠸⣏⢯⣷⣖⣦⡀⠀⠀⠀⠀⠀⠀
⢀⣾⣽⣿⣿⣿⣿⠛⢲⣶⣾⢉⡷⣿⣿⠵⣿⠀⠀⠀⠀⠀⠀
⣼⣿⠍⠉⣿⡭⠉⠙⢺⣇⣼⡏⠀⠀⠀⣄⢸⠀⠀⠀⠀⠀⠀
⣿⣿⣧⣀⣿.........⣀⣰⣏⣘⣆⣀⠀⠀"
echo ""
sleep 3

# First apply device name spoofing
spoof_device_name

# Now apply performance optimizations
echo "Applying optimizations for $(if [ "$IS_ROOTED" = true ]; then echo 'rooted'; else echo 'non-rooted'; fi) device..."

if [ "$IS_ROOTED" = true ]; then
    # Root performance optimizations
    (
    # Try with resetprop first (Magisk) then fallback to setprop
    run_with_root "resetprop debug.egl.force_msaa false || setprop debug.egl.force_msaa false"
    run_with_root "resetprop debug.hwui.use_gpu_pixel_buffers 1 || setprop debug.hwui.use_gpu_pixel_buffers 1"
    run_with_root "resetprop debug.hwui.render_dirty_regions false || setprop debug.hwui.render_dirty_regions false"
    run_with_root "resetprop debug.hwui.disable_vsync true || setprop debug.hwui.disable_vsync true"
    run_with_root "resetprop debug.sf.latch_unsignaled 1 || setprop debug.sf.latch_unsignaled 1"
    run_with_root "resetprop debug.sf.disable_backpressure 1 || setprop debug.sf.disable_backpressure 1"
    run_with_root "resetprop debug.composition.type gpu || setprop debug.composition.type gpu"
    
    # Gaming optimizations
    run_with_root "resetprop debug.enable_game_driver 1 || setprop debug.enable_game_driver 1"
    run_with_root "resetprop debug.game_driver_prerelease 1 || setprop debug.game_driver_prerelease 1"
    run_with_root "resetprop debug.enable_game_driver_all_apps 1 || setprop debug.enable_game_driver_all_apps 1"
    run_with_root "resetprop debug.egl.traceGpuCompletion 1 || setprop debug.egl.traceGpuCompletion 1"
    
    # Refresh rate improvements
    run_with_root "resetprop ro.surface_flinger.enable_frame_rate_override 1 || setprop ro.surface_flinger.enable_frame_rate_override 1"
    run_with_root "resetprop debug.display.allow_non_native_refresh_rate_override 1 || setprop debug.display.allow_non_native_refresh_rate_override 1"
    run_with_root "resetprop debug.display.render_frame_rate_is_physical_refresh_rate 1 || setprop debug.display.render_frame_rate_is_physical_refresh_rate 1"
    ) > /dev/null 2>&1
else
    # Non-root optimizations (using settings command which doesn't require root)
    (
    # Game performance settings (accessible without root)
    settings put global debug.enable_game_driver 1
    settings put global debug.game_driver_prerelease 1
    settings put global debug.enable_game_driver_all_apps 1
    
    # Memory & Performance
    settings put global ram_expand_size_limit 4
    settings put global cached_apps_freezer enabled
    settings put global app_standby_enabled 1
    settings put global adaptive_battery_management_enabled 1
    
    # Try to set refresh rate if available on device
    settings put system min_refresh_rate 60.0
    settings put system peak_refresh_rate 165.0
    
    # Game optimizer (non-root version)
    settings put secure gaming_mode_enabled 1
    settings put global high_performance_mode_enabled 1
    settings put global low_power 0
    
    # Graphics performance (accessible without root)
    settings put global opengl_traces none
    settings put global debug_view_attributes 0
    settings put global show_refresh_rate_switch 1
    ) > /dev/null 2>&1
fi

# Verify changes were made - only check device name as it's easier to verify
echo ""
echo "Verifying changes..."
if [ "$IS_ROOTED" = true ]; then
    NEW_DEVICE=$(getprop ro.product.marketname 2>/dev/null || getprop ro.product.model)
else
    NEW_DEVICE=$(settings get global device_name 2>/dev/null || echo "Verification not possible")
fi

echo "Device now showing as: $NEW_DEVICE"
echo ""
echo "█▓▒▒░░░ BREVENT QUTE PROCESS [✓] ░░░▒▒▓█"
sleep 0.5
echo ""
echo "SUCCESSFULLY IMPLEMENTED ASUS ROG 10 ON TERMUX BREVENT QUTE"
sleep 2.0
echo ""
echo "DEV: WILLY GAILO @ BREVENT QUTE"
echo ""
sleep 0.5
echo ""
echo "THANK YOU FOR USING WILLY GAILO's MODULE"
echo ""
sleep 0.5
echo ""
echo "ENJOY YOUR ENHANCED GAMING EXPERIENCE!"
echo ""
sleep 0.5
echo ""
echo "█▓▒▒░░░ BREVENT QUTE ACTIVATED SUCCESSFULLY ░░░▒▒▓█"
echo ""
cmd notification post -S bigtext -t 'ASUS ROG 10' 'Willy Gailo' 'BREVENT QUTE RUNNING SUCCESSFULLY' > /dev/null 2>&1

# Restarting certain services may improve spoofing effect (only with root)
if [ "$IS_ROOTED" = true ]; then
    echo "Finalizing changes..."
    run_with_root "setprop ctl.restart surfaceflinger" > /dev/null 2>&1
    run_with_root "killall -TERM android.hardware.graphics.composer" > /dev/null 2>&1
fi

# End of script