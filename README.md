# EKF-Proj1-ROBGY6213
Extended Kalman Filter implementation for given IMU and Vicon data
## Overview
This is the implementation of an Extended Kalman Filter (EKF) for state estimation. It uses the body frame acceleration and angular velocity from the onboard
IMU as the control inputs. The measurement will be given by the pose or velocity from the Vicon. The body frame of the robot is coincident with the IMU frame.

## Sensor Data
The data for each trial is provided in a mat file. The mat file also contains Vicon data. The Vicon data
is stored in two matrix variables, time and vicon. The time variable contains the timestamp while the
vicon variable contains the Vicon data in the following format:
[x y z roll pitch yaw vx vy vz ωx ωy ωz]

The on board processor of the robot collects synchronized camera and IMU data and sends them to the
desktop computer. At this stage, the camera data should not be used. The sensor data is decoded into
standard MATLAB format. Note that since the sensor data is transmitted via wireless network, there may
or may not be a sensor packet available during a specific iteration of the control loop. A sensor packet is a
struct that contains following fields:
1 sensor.is_ready % True if a sensor packet is available, false otherwise
2 sensor.t % Time stamp for the sensor packet, different from the Vicon time
3 sensor.omg % Body frame angular velocity from the gyroscope
4 sensor.acc % Body frame linear acceleration from the accelerometer
5 sensor.img % Undistorted image.
6 sensor.K % Calibration matrix of the undistorted image
7 sensor.id % IDs of all AprilTags detected, empty if no tag is detected in the image
8 sensor.p0 % Corners of the detect AprilTags in the image,
9 sensor.p1 % the ordering of the corners, and the distribution of the tags
10 sensor.p2
11 sensor.p3
12 sensor.p4

## Kalman Filter
In this project, we use the Extended Kalman Filter (EKF) to estimate the position, velocity, and orientation, and sensor biases of an Micro Aerial Vehicle. 
The Vicon velocity is given in the world frame, whereas the angular rate in the body frame of the robot. The body frame acceleration and angular velocity from the on board IMU are used as inputs. 
The filter has two implementations. In the first oneone, the measurement update will be given by the position and orientation from vicon, whereas the second one uses only the velocity from the Vicon.