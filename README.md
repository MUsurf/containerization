# containerization

[ros dockerhub page](https://hub.docker.com/_/ros/)

# Using this repo with Docker.

- Use "docker compose build" to build the container.
- Use "docker compose up" to run the container. You should see the turtlesim window open up.

# Notes

### Add Linux user to group

If a user is falling out of a docker permission group on computer restart check the output of `echo $DOCKER_HOST`. If the output is empty add the following line to .bashrc `export DOCKER_HOST=unix:///var/run/docker.sock`

### Enable X11 forwarding

Linux and macOS need the following line to enable x11 forwarding `xhost +localhost`
If the container was built previously use `docker compose up --build` to rebuild only necessary components.
MacOS will need to install [XQuartz](https://www.xquartz.org/) to forward the container window. You **must** restart your computer and open a new terminal to enable.

### SSH config 

Not much modification is required but adding the line `ForwardX11 yes`