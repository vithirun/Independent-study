# Independent-study


Measuring the metrics[CPU, memory and Network Usage] of Android Application.

query.sh \<application name\> <query runtime>
  - Shell script to extract the CPU, memory and network usage of the running android application 
  parameters: 
  1. application name : Android application name can be figured out by using adb shell command.
  2. query runtime    : The time for the which the query should run

toggle.sh <toggle time>
  - Performs random swipe function until the specified time duration
  parameters:
  1. toggle time      : For how long toggling should be enforced.
