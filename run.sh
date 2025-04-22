#!/bin/bash

source /opt/ros/$ROS_DISTRO/setup.bash && \
  source install/local_setup.bash
  # python3 ./src/motor_command/motor_command/motor_listener.py
  # ros2 launch motor_command motors.py
  # ros2 run motor_command motor_runner
  # ros2 run motor_command motor_listener
  ros2 launch ./src/imu/launch/imu.xml

  # ros2 launch py_launch launch.yaml
