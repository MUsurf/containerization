FROM ros:jazzy-ros-base

ENV DEBIAN_FRONTEND=noninteractive

# Set Docker's default shell to bash instead of sh.
SHELL ["/bin/bash", "-c"] 


RUN apt-get update && apt-get install -y \
  git \
  lsb-release \
  wget \
  curl \
  gnupg2 \
  python3 \
  python3-pip \
  screen \
  nano \
  software-properties-common \
  i2c-tools \
  libgpiod-dev \
  python3-libgpiod \
  libgpiod-doc

# Ensure Python 3 is the default python version
RUN ln -s /usr/bin/python3 /usr/bin/python


# Install pip packages
RUN apt update && apt install -y --upgrade \
  # python3-numpy \
  # python3-regex \
  python3-setuptools
  

# Install packages not availble through system
RUN python3 -m pip install --upgrade adafruit-circuitpython-pca9685 adafruit-blinka adafruit-python-shell rpi-lgpio --break-system-packages && \
  python3 -m pip uninstall -y RPi.GPIO --break-system-packages


### Basic workspace setup from https://docs.ros.org/en/jazzy/Tutorials/Beginner-Client-Libraries/Creating-A-Workspace/Creating-A-Workspace.html#creating-a-workspace


WORKDIR /home/ros2_ws


# Initialize rosdep and install dependencies for all packages.
# Here we are using bind mounts to temporarily copy our package.xml files into the container for this one step.
# After this step the /home/ros2_ws/deps directory will no longer exist in the container. 
# We are using bind mounts here to optimize build times so you will only have to install dependencies for packages the first time you build the image.
# If you add a package to the TapeWorm directory you can add it here. 
# Make sure you follow this syntax: "--mount=type=bind,source=./TapeWorm/<your_new_package>/package.xml,target=/home/ros2_ws/deps/<your_new_package>/package.xml \"
# Bind mounts are whitespace sensitive. You can copy and paste the given syntax and replace <your_new_package> with the name of the package you want to add.
RUN --mount=type=bind,source=./TapeWorm/motor_controller/package.xml,target=/home/ros2_ws/deps/motor_controller/package.xml \
    --mount=type=bind,source=./TapeWorm/motor_runner/package.xml,target=/home/ros2_ws/deps/motor_runner/package.xml \
    --mount=type=bind,source=./TapeWorm/process_depth/package.xml,target=/home/ros2_ws/deps/process_depth/package.xml \
    --mount=type=bind,source=./TapeWorm/process_imu/package.xml,target=/home/ros2_ws/deps/process_imu/package.xml \
    rosdep update && \
    rosdep install -i --from-path ./deps --rosdistro $ROS_DISTRO -y


COPY ./TapeWorm/ /home/ros2_ws/src/

RUN source /opt/ros/$ROS_DISTRO/setup.bash && \
  colcon build --symlink-install


# run.sh is where we run commands in the container on startup.
COPY ./containerization/run.sh /home/ros2_ws/run.sh

RUN chmod u+x /home/ros2_ws/run.sh

RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc

COPY ./containerization/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh


CMD ["/home/ros2_ws/run.sh"]