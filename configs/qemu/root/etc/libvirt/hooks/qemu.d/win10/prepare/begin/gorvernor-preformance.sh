echo "Setting preformance governor..."
for file in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo "performance" > $file; done
echo "Succesfully set preformance governor."
