# containerization

[ros dockerhub page](https://hub.docker.com/_/ros/)

# Using this repo with Docker.

- Pull with `git clone --single-branch --branch turtlesim https://github.com/MUsurf/containerization.git`
- Use `docker compose build` to build the container.
- Use `docker compose up` to run the container. You should see the turtlesim window open up.

# Notes

### Add Linux user to group

If a user is falling out of a docker permission group on computer restart check the output of `echo $DOCKER_HOST`. If the output is empty add the following line to .bashrc `export DOCKER_HOST=unix:///var/run/docker.sock`

### Enable X11 forwarding

Linux and macOS need the following line to enable x11 forwarding `xhost +localhost`
If the container was built previously use `docker compose up --build` to rebuild only necessary components.
MacOS will need to install [XQuartz](https://www.xquartz.org/) to forward the container window. You **must** restart your computer and open a new terminal to enable.

### SSH config 

Not much modification is required but adding the line `ForwardX11 yes`

### Tutrlesim
```bash
docker exec -it (CONTAINER_NAME) bash
source /opt/ros/$ROS_DISTRO/setup.bash
source /home/ros2_ws/install/local_setup.bash
ros2 run turtlesim turtle_node
```

In a new terminal
```bash
docker exec -it (CONTAINER_NAME) bash
ros2 run turtlesim turtle_teleop_key
```
