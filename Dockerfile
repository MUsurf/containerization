FROM ros:jazzy-ros-base

# Set Docker's default shell to bash instead of sh.
SHELL ["/bin/bash", "-c"] 


RUN apt install git -y

### Basic workspace setup from https://docs.ros.org/en/jazzy/Tutorials/Beginner-Client-Libraries/Creating-A-Workspace/Creating-A-Workspace.html#creating-a-workspace
WORKDIR /home/ros2_ws/src

# COPY ./TapeWorm/catkin_ws /home/ros2_ws

# WORKDIR /home/ros2_ws

# RUN rosdep install -i --from-path src --rosdistro $ROS_DISTRO -y

# RUN source /opt/ros/$ROS_DISTRO/setup.bash && \
#   colcon build --symlink-install

# COPY ./containerization/run.sh /home/ros2_ws/run.sh

# RUN chmod +x /home/ros2_ws/run.sh

# CMD ["/home/ros2_ws/run.sh"]


