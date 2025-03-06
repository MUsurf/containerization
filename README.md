# containerization

[ros dockerhub page](https://hub.docker.com/_/ros/)

# Directory setup.
- Directory structure to build and run the container:
    - parent_directory:
        - containerization
        - TapeWorm
- To achieve this directory structure you can make a directory on your system and clone both containerization and TapeWorm into that directory.

# Developing without a Raspberry Pi.
- If you are developing a ros2 package without the raspberry pi, You will want to have the same directory structure as above.
- Use "docker compose --profile=no_pi build" inside containerization to build the container.
- Use "docker compose --profile=no_pi up" inside containerization to run the container.
- When the container starts it will run the run.sh script in containerization. You may have to modify this script to get it to run the code you want it to run.
- If you have created a new package, you will want to add the entire package directory to TapeWorm. You will then want to add a bind mount for its package.xml file in the Dockerfile. There are instructions on how to do this in the Dockerfile.

# Developing with a Raspberry Pi.
- If you are developing on a Raspberry Pi, You will want to have the same directory structure as above.
- Use "docker compose --profile=pi build" inside containerization to build the container.
- Use "docker compose --profile=pi up" inside containerization to run the container.
- When the container starts it will run the run.sh script in containerization. You may have to modify this script to get it to run the code you want it to run.
- If you have created a new package, you will want to add the entire package directory to TapeWorm. You will then want to add a bind mount for its package.xml file in the Dockerfile. There are instructions on how to do this in the Dockerfile.

# Working on Dockerfile and docker-compose.yaml.
- When working on the docker-compose.yaml file, try to remove anything you don't think you will be actively using or add a comment as to why you left something.
- It can be hard to tell what is worth keeping in the file when we have lots of commented out lines.
- When working on the Dockerfile, try to install only the packages you need. It is okay to install lots of packages when you are trying to get something to work.
- It is important to go back and clean up any packages you think are not necessary. It is difficult for someone else to go back and decide which packages are worth keeping.

# Getting started with a fresh Raspberry Pi.
- Install Docker.
- Enable i2c.

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