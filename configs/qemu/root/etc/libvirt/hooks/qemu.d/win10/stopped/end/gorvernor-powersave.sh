echo "Setting gorvernor to powersave..."
for file in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo "powersave" > $file; done
echo "Succesfully set gorvernor to powersave."
