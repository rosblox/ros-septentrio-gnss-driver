ARG ROS_DISTRO

FROM ros:${ROS_DISTRO}-ros-core

RUN apt-get update && apt-get install -y --no-install-recommends \
    libboost-all-dev \
    libpcap-dev \
    libgeographic-dev \
    ros-${ROS_DISTRO}-nmea-msgs \
    ros-${ROS_DISTRO}-gps-msgs \
    ros-${ROS_DISTRO}-septentrio-gnss-driver \
    && rm -rf /var/lib/apt/lists/*

COPY ros_entrypoint.sh /ros_entrypoint.sh

WORKDIR /colcon_ws

ENV LAUNCH_COMMAND='ros2 run septentrio_gnss_driver septentrio_gnss_driver_node --ros-args -p device:=tcp://192.168.60.1:28784 -p polling_period.pvt:=40'

RUN echo 'alias run="su - ros /run.sh"' >> /etc/bash.bashrc && \
    echo "source /opt/ros/humble/setup.bash; $LAUNCH_COMMAND" >> /run.sh && chmod +x /run.sh
