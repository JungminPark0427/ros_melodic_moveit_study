FROM osrf/ros:melodic-desktop-full

RUN apt-get update && apt-get install -y \
    ros-melodic-moveit \
    ros-melodic-moveit-visual-tools \
    ros-melodic-rviz-visual-tools \
    ros-melodic-joint-state-publisher \
    ros-melodic-joint-state-publisher-gui \
    ros-melodic-robot-state-publisher \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc

WORKDIR /root/catkin_ws
