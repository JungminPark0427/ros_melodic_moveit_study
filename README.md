# ROS Melodic MoveIt Docker 환경 구축 (Windows)

## 사전 준비
- Docker Desktop 설치
- VcXsrv 설치 → XLaunch 실행 → Disable access control 체크 → 완료

## 1단계 — 저장소 클론
```powershell
git clone https://github.com/JungminPark0427/ros_melodic_moveit_study.git
cd ros_melodic_moveit_study
```

## 2단계 — Dockerfile 생성
Windows에서 클론하면 src/CMakeLists.txt가 심볼릭 링크 대신 텍스트로 깨지기 때문에 Dockerfile에서 직접 고쳐줘야 해요.
```powershell
@"
FROM osrf/ros:melodic-desktop-full

RUN apt-get update && apt-get install -y \
    python-catkin-tools \
    ros-melodic-moveit \
    ros-melodic-moveit-visual-tools \
    ros-melodic-joint-state-publisher-gui \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root/catkin_ws
COPY src/ /root/catkin_ws/src/

RUN /bin/bash -c "source /opt/ros/melodic/setup.bash && \
    rm -f /root/catkin_ws/src/CMakeLists.txt && \
    ln -s /opt/ros/melodic/share/catkin/cmake/toplevel.cmake /root/catkin_ws/src/CMakeLists.txt && \
    catkin_make"

RUN echo 'source /opt/ros/melodic/setup.bash' >> ~/.bashrc && \
    echo 'source /root/catkin_ws/devel/setup.bash' >> ~/.bashrc

CMD ["/bin/bash"]
"@ | Out-File -FilePath Dockerfile -Encoding utf8
```

## 3단계 — 이미지 빌드
```powershell
docker build -t ros_melodic_moveit .
```
⏳ 처음엔 10~20분 소요

## 4단계 — 컨테이너 실행 & roscore (터미널 1)
```powershell
docker run -it --name ros_melodic -e DISPLAY=host.docker.internal:0.0 ros_melodic_moveit bash
```
컨테이너 안에서:
```bash
source /opt/ros/melodic/setup.bash
roscore
```

## 5단계 — MoveIt 실행 (터미널 2)
새 PowerShell 창에서:
```powershell
docker exec -it ros_melodic bash
```
컨테이너 안에서:
```bash
source /opt/ros/melodic/setup.bash
cd ~/catkin_ws && source devel/setup.bash
roslaunch moveit_setup_assistant setup_assistant.launch
```
✅ RViz 창이 뜨면 성공!

## 🔄 다음에 다시 실행할 때
```powershell
# 컨테이너 재시작
docker start ros_melodic

# 터미널 1 — roscore
docker exec -it ros_melodic bash
# → source /opt/ros/melodic/setup.bash && roscore

# 터미널 2 — MoveIt
docker exec -it ros_melodic bash
# → source /opt/ros/melodic/setup.bash && cd ~/catkin_ws && source devel/setup.bash && roslaunch moveit_setup_assistant setup_assistant.launch
```
