# Extended Kalman Filter (EKF) for State Estimation in Micro Aerial Vehicles (MAV)

## Project Overview

This project implements an **Extended Kalman Filter (EKF)** for state estimation in a **Micro Aerial Vehicle (MAV)**, utilizing body-frame acceleration and angular velocity data from an onboard **Inertial Measurement Unit (IMU)** for prediction, and pose or velocity data from a **Vicon motion capture system** for correction.

The project explores two filter versions:
1. **Part 1**: EKF using Vicon position and orientation data for measurement updates.
2. **Part 2**: EKF using only Vicon velocity data for measurement updates.

The aim is to demonstrate the EKF’s ability to accurately estimate the MAV's state, including its position, velocity, orientation, and sensor biases.

## Key Features

- **EKF Implementation**: Implements an EKF to handle non-linear process models and noise in the system.
- **State Estimation**: Accurate estimation of position, velocity, orientation, and sensor biases using IMU and Vicon data.
- **Two Filter Configurations**:
  - Part 1 uses position and orientation measurements.
  - Part 2 uses velocity measurements.
  
## Project Objectives

1. Implement an **Extended Kalman Filter** (EKF) for state estimation in MAV.
2. Utilize body-frame IMU data for prediction and Vicon data for correction.
3. Explore two versions of EKF: using position and orientation data vs. using velocity data.
4. Evaluate the EKF's performance in different configurations.

## Methodology

### Prediction Step

The prediction step uses IMU data (angular velocity and linear acceleration) to predict the MAV’s state (position, orientation, velocity, and sensor biases). This step involves:
- Calculating state transition matrices.
- Applying the non-linear state transition model.
- Calculating predicted mean and covariance matrices.

### Update Step

Two different measurement models are implemented:
- **Part 1**: Uses Vicon’s position and orientation measurements to update the state estimate.
- **Part 2**: Uses Vicon’s velocity measurements to update the state estimate.

In both cases, the standard Kalman Filter update equations are used, but with different measurement matrices and noise covariance matrices.

## Results

The EKF successfully estimates the MAV's state in both configurations. The results show that:

- **Part 1**: EKF with position and orientation measurements from Vicon provides accurate estimates for the MAV’s position, orientation, velocity, and sensor biases.
- **Part 2**: EKF using only velocity measurements shows a slight trade-off in position estimation accuracy but still performs well in velocity estimation.

### Part 1: EKF with Position and Orientation Measurements

<p align="center">
  <img src="path-to-position-x-plot-part1.png" alt="Part 1: Position X Estimate" width="300"/>
  <img src="path-to-position-y-plot-part1.png" alt="Part 1: Position Y Estimate" width="300"/>
  <img src="path-to-position-z-plot-part1.png" alt="Part 1: Position Z Estimate" width="300"/>
</p>

<p align="center">
  <b>Fig 1:</b> Part 1 - Estimated Position X, Y, Z
</p>

<p align="center">
  <img src="path-to-orientation-x-plot-part1.png" alt="Part 1: Orientation X Estimate" width="300"/>
  <img src="path-to-orientation-y-plot-part1.png" alt="Part 1: Orientation Y Estimate" width="300"/>
  <img src="path-to-orientation-z-plot-part1.png" alt="Part 1: Orientation Z Estimate" width="300"/>
</p>

<p align="center">
  <b>Fig 2:</b> Part 1 - Estimated Orientation X, Y, Z
</p>

### Part 2: EKF with Velocity Measurements

<p align="center">
  <img src="path-to-position-x-plot-part2.png" alt="Part 2: Position X Estimate" width="300"/>
  <img src="path-to-position-y-plot-part2.png" alt="Part 2: Position Y Estimate" width="300"/>
  <img src="path-to-position-z-plot-part2.png" alt="Part 2: Position Z Estimate" width="300"/>
</p>

<p align="center">
  <b>Fig 3:</b> Part 2 - Estimated Position X, Y, Z
</p>

<p align="center">
  <img src="path-to-orientation-x-plot-part2.png" alt="Part 2: Orientation X Estimate" width="300"/>
  <img src="path-to-orientation-y-plot-part2.png" alt="Part 2: Orientation Y Estimate" width="300"/>
  <img src="path-to-orientation-z-plot-part2.png" alt="Part 2: Orientation Z Estimate" width="300"/>
</p>

<p align="center">
  <b>Fig 4:</b> Part 2 - Estimated Orientation X, Y, Z
</p>

The EKF also effectively estimated sensor biases for both the accelerometer and gyroscope.

## Conclusion

This project successfully implements an Extended Kalman Filter (EKF) for state estimation in a MAV, demonstrating its ability to handle nonlinearities and sensor noise. The two different filter versions illustrate the EKF's versatility, with future work focusing on incorporating additional sensor data or exploring alternative estimation techniques for more robust performance in real-world applications.

## Future Enhancements

1. **Additional Sensor Fusion**: Incorporating more sensors, such as GPS, for better state estimation.
2. **Exploring Other Filters**: Investigate other state estimation filters, such as **Unscented Kalman Filter (UKF)**, to improve performance in non-linear systems.
3. **Tuning and Optimization**: Further fine-tuning of parameters to enhance performance in different environments.

## References

1. Timothy D. Barfoot. *State Estimation for Robotics*. 1st ed. Cambridge University Press, 2017. ISBN: 1107159393.
2. “Basic Concepts in Estimation.” In: *Estimation with Applications to Tracking and Navigation*. John Wiley & Sons, Ltd. ISBN: 9780471221272. DOI: [10.1002/0471221279.ch2](https://doi.org/10.1002/0471221279.ch2).
3. “Introduction.” In: *Estimation with Applications to Tracking and Navigation*. John Wiley & Sons, Ltd. ISBN: 9780471221272. DOI: [10.1002/0471221279.ch1](https://doi.org/10.1002/0471221279.ch1).
4. Sebastian Thrun, Wolfram Burgard, and Dieter Fox. *Probabilistic Robotics*. The MIT Press, 2005. ISBN: 0262201623.
5. Wikipedia contributors. "Extended Kalman filter." Wikipedia, The Free Encyclopedia. Last modified March 15, 2024. [Link](https://en.wikipedia.org/w/index.php?title=Extended_Kalman_filter&oldid=1200061147).
  
