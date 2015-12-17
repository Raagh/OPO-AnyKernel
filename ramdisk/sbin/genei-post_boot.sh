#!/system/bin/sh

BB=/sbin/bb/busybox

############################
# Custom Kernel Settings for Genei Kernel!!
#
echo "[Genei-Kernel] Boot Script Started" | tee /dev/kmsg

############################
# Tweak Background Writeout
#
echo 200 > /proc/sys/vm/dirty_expire_centisecs
echo 40 > /proc/sys/vm/dirty_ratio
echo 5 > /proc/sys/vm/dirty_background_ratio
echo 10 > /proc/sys/vm/swappiness

############################
# Scheduler and Read Ahead
#
echo fiops > /sys/block/mmcblk0/queue/scheduler
echo 1024 > /sys/block/mmcblk0/bdi/read_ahead_kb

############################
# Governor Tunings
#
echo ondemand > /sys/kernel/msm_limiter/scaling_governor_0
echo 95 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
echo 50000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
echo 1 > /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
echo 4 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
echo 10 > /sys/devices/system/cpu/cpufreq/ondemand/down_differential
echo 75 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold_multi_core
echo 3 > /sys/devices/system/cpu/cpufreq/ondemand/down_differential_multi_core
echo 960000 > /sys/devices/system/cpu/cpufreq/ondemand/optimal_freq
echo 960000 > /sys/devices/system/cpu/cpufreq/ondemand/sync_freq
echo 85 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold_any_cpu_load

echo interactive > /sys/kernel/msm_limiter/scaling_governor_0
echo 20000 1400000:40000 1700000:20000 > /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
echo 90 > /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
echo 1190400 > /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
echo 1 > /sys/devices/system/cpu/cpufreq/interactive/io_is_busy
echo 85 1500000:90 1800000:70 > /sys/devices/system/cpu/cpufreq/interactive/target_loads
echo 40000 > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
echo 30000 > /sys/devices/system/cpu/cpufreq/interactive/timer_rate
echo 100000 > /sys/devices/system/cpu/cpufreq/interactive/max_freq_hysteresis
echo 30000 > /sys/devices/system/cpu/cpufreq/interactive/timer_slack

echo smartmax > /sys/kernel/msm_limiter/scaling_governor_0
echo smartmax > /sys/kernel/msm_limiter/scaling_governor_1
echo smartmax > /sys/kernel/msm_limiter/scaling_governor_2
echo smartmax > /sys/kernel/msm_limiter/scaling_governor_3
echo 729600 > /sys/devices/system/cpu/cpufreq/smartmax/suspend_ideal_freq
echo 1036800 > /sys/devices/system/cpu/cpufreq/smartmax/awake_ideal_freq
echo 0 > /sys/devices/system/cpu/cpufreq/smartmax/io_is_busy
echo 70 > /sys/devices/system/cpu/cpufreq/smartmax/max_cpu_load
echo 30 > /sys/devices/system/cpu/cpufreq/smartmax/min_cpu_load
echo 1497600 > /sys/devices/system/cpu/cpufreq/smartmax/touch_poke_freq
echo 1497600 > /sys/devices/system/cpu/cpufreq/smartmax/boost_freq

############################
# LMK Tweaks
#
echo 2560,4096,8192,16384,24576,32768 > /sys/module/lowmemorykiller/parameters/minfree
echo 32 > /sys/module/lowmemorykiller/parameters/cost

############################
# Disable Debugging
#
echo "0" > /sys/module/kernel/parameters/initcall_debug;
echo "0" > /sys/module/alarm_dev/parameters/debug_mask;
echo "0" > /sys/module/binder/parameters/debug_mask;
echo "0" > /sys/module/xt_qtaguid/parameters/debug_mask;
echo "[Genei-Kernel] disable debug mask" | tee /dev/kmsg

echo "[Genei-Kernel] Boot Script Completed!" | tee /dev/kmsg
