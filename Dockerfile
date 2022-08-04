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
