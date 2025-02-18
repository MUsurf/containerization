# FROM ros:jazzy-ros-base

# # Set Docker's default shell to bash instead of sh.
# SHELL ["/bin/bash", "-c"] 


# RUN apt-get update -y && apt-get upgrade -y && apt-get install git -y

# ### Basic workspace setup from https://docs.ros.org/en/jazzy/Tutorials/Beginner-Client-Libraries/Creating-A-Workspace/Creating-A-Workspace.html#creating-a-workspace
# WORKDIR /home/ros2_ws/src

# COPY ./TapeWorm/ /home/ros2_ws

# WORKDIR /home/ros2_ws

# RUN rosdep install -i --from-path src --rosdistro $ROS_DISTRO -y

# RUN source /opt/ros/$ROS_DISTRO/setup.bash && \
#   colcon build --symlink-install

# COPY ./containerization/run.sh /home/ros2_ws/run.sh

# RUN chmod +x /home/ros2_ws/run.sh

# CMD ["/home/ros2_ws/run.sh"]


#
#
#
#
FROM ros:jazzy-ros-base

ENV DEBIAN_FRONTEND=noninteractive

# Set Docker's default shell to bash instead of sh.
SHELL ["/bin/bash", "-c"] 


RUN apt-get update -y && apt-get upgrade -y 

RUN apt-get install git -y

RUN apt-get update && apt-get install -y \
    lsb-release \
    wget \
    curl \
    gnupg2 \
    python3 \
    python3-pip \
    screen \
    nano \
    software-properties-common

# Ensure Python 3 is the default python version
RUN ln -s /usr/bin/python3 /usr/bin/python


# Install pip packages
RUN apt install -y \
  python3-numpy \
  python3-regex 


# Install packages not availble through system
# RUN sudo python3 -m pip install adafruit-circuitpython-pca9685 adafruit-blinka --break-system-packages
RUN sudo python3 -m pip install adafruit-blinka --break-system-packages
# RUN sudo python3 -m pip install adafruit-circuitpython-pca9685 --break-system-packages






### Basic workspace setup from https://docs.ros.org/en/jazzy/Tutorials/Beginner-Client-Libraries/Creating-A-Workspace/Creating-A-Workspace.html#creating-a-workspace
WORKDIR /home/ros2_ws/src

COPY ./TapeWorm/ /home/ros2_ws/src/




# WORKDIR /home/ros2_ws

# RUN git clone https://github.com/MUsurf/JellyRos2.git -b motor_test src && \
#   cd ./src && \
#   git pull origin motor_test


WORKDIR /home/ros2_ws


# Initialize rosdep and install dependencies
RUN rosdep update && \
    rosdep install -i --from-path src --rosdistro $ROS_DISTRO -y


RUN source /opt/ros/$ROS_DISTRO/setup.bash && \
  colcon build --symlink-install


# run.sh is where we run the turtle sim.
COPY ./containerization/run.sh /home/ros2_ws/run.sh

RUN chmod u+x /home/ros2_ws/run.sh

RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc

COPY ./containerization/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# CMD ["/home/ros2_ws/run.sh"]
ENTRYPOINT ["/entrypoint.sh"]





#apt-get install raspberrypi-kernel-headers