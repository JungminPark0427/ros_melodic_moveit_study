# ROS Melodic MoveIt Study

## 실행 방법

### 1. 이미지 빌드
```bash
docker build -t ros_melodic_moveit .
```

### 2. 컨테이너 실행
```bash
docker run -it \
  --name ros_melodic \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  ros_melodic_moveit bash
```

### 3. roscore 실행 (터미널 1)
```bash
source /opt/ros/melodic/setup.bash
roscore
```

### 4. MoveIt Setup Assistant (터미널 2)
```bash
source /opt/ros/melodic/setup.bash
cd ~/catkin_ws && source devel/setup.bash
roslaunch moveit_setup_assistant setup_assistant.launch
```
