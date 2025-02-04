# containerization

[ros dockerhub page](https://hub.docker.com/_/ros/)

# Using this repo with Docker.

- Directory structure to build and run the container:
    - parent_directory:
        - containerization
        - TapeWorm
- Use "docker compose build" inside containerization to build the container.
- Use "docker compose up" inside containerization to run the container.

# Notes

### Add Linux user to group

If a user is falling out of a docker permission group on computer restart check the output of `echo $DOCKER_HOST`. If the output is empty add the following line to .bashrc `export DOCKER_HOST=unix:///var/run/docker.sock`

### Enable X11 forwarding

Linux and macOS need the following line to enable x11 forwarding `xhost +localhost`
If the container was built previously use `docker compose up --build` to rebuild only necessary components.
MacOS will need to install [XQuartz](https://www.xquartz.org/) to forward the container window. You **must** restart your computer and open a new terminal to enable.

### SSH config 

Not much modification is required but adding the line `ForwardX11 yes`


# links used to migrate motor_control package to ros2 directory structure:
- https://docs.ros.org/en/jazzy/Tutorials/Beginner-Client-Libraries/Creating-Your-First-ROS2-Package.html

- https://docs.ros.org/en/crystal/Tutorials/Writing-A-Simple-Py-Publisher-And-Subscriber.html#create-a-package

- https://docs.ros.org/en/humble/How-To-Guides/Migrating-from-ROS1/Migrating-Python-Package-Example.html