#!/bin/bash

source /opt/ros/$ROS_DISTRO/setup.bash && \
  source install/local_setup.bash && \
  python3 ./src/motor_tester/motor_listener.py
  # ros2 launch motor_command motors.py
  # ros2 run motor_command motor_runner
  # ros2 run motor_command motor_listener