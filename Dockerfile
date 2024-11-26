ARG ROS_DISTRO=humble

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

ENV LAUNCH_COMMAND='ros2 run septentrio_gnss_driver septentrio_gnss_driver_node --ros-args -p device:=tcp://192.168.60.1:28784 -p polling_period.pvt:=40 -p frame_id:="gnss_link" -p rtk_settings.ip_server_1.send_gga:="sec1" -p rtk_settings.ip_server_1.port:=6666 -p rtk_settings.ip_server_1.id:="IPS1"'

RUN echo 'alias run="su - ros --whitelist-environment=\"ROS_DOMAIN_ID\" /run.sh"' >> /etc/bash.bashrc && \
    echo "source /opt/ros/$ROS_DISTRO/setup.bash; echo UID: $UID; echo ROS_DOMAIN_ID: $ROS_DOMAIN_ID; $LAUNCH_COMMAND" >> /run.sh && chmod +x /run.sh

