
counter=0

# for while loop.
while true; do

  # Take screenshot
  filename="$(printf "book%05d.png" "$counter")"
  echo $filename
  adb shell screencap -p /sdcard/$filename
  adb pull /sdcard/$filename
  adb shell rm  /sdcard/$filename

  # Tap
  adb -s 06d9d068 shell input touchscreen tap 1000 1043

  # wait 3 seconds.
  sleep 3
  counter=$((counter+1))
done
