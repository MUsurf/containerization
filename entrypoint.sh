#!/bin/bash
set -e

# Source ROS and workspace setup
source /opt/ros/$ROS_DISTRO/setup.bash
source /home/ros2_ws/install/setup.bash

# If no arguments are passed, keep an interactive shell open
if [ "$#" -eq 0 ]; then
    exec bash
else
    exec "$@"
fi
