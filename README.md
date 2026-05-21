# ROS Melodic MoveIt Study (SIOR)

## 팀원 환경 세팅 방법

### 1. Clone (WSL 터미널에서)
git clone https://github.com/JungminPark0427/ros_melodic_moveit_study.git
cd ros_melodic_moveit_study

### 2. Docker 빌드
docker build -t ros_melodic_moveit .

### 3. 컨테이너 실행
docker run -it --name ros_melodic \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  ros_melodic_moveit bash

### 4. 실행
source /opt/ros/melodic/setup.bash
roscore
