# Video Object Tracking using Classic Computer Vision Algorithms 📹
This repository showcases a project that focuses on implementing classic computer vision algorithms for tracking a colored ball in a video. The project aims to provide a foundational understanding of fundamental concepts in computer vision and serves as a starting point for exploring more advanced tracking techniques.

## Project Overview
The primary objective of this project is to develop and demonstrate the implementation of classic computer vision algorithms for video object tracking. By focusing on tracking a colored ball in a video, the project provides a practical example to understand the core principles and techniques involved in video tracking.

## Implementation Details
The project includes the following key functions:

* Function 1 - Compute Green Mask:

This function, named ComputeGreenMask(I), takes an input frame I and converts it to the HSV color space. It then defines a range of green color and creates a mask based on the specified color range. The resulting mask isolates the green color within the frame, which will be used for further processing and tracking.

* Function 2 - Compute Ball Histogram:

The function ComputeBallHistogram(I, mask, nbbins) computes a histogram of the ball's color in the frame. It takes the input frame I, the mask obtained from the previous step, and the number of bins nbbins for histogram computation. The function converts the masked frame to the HSV color space and creates a histogram of the hue values. The resulting histogram, along with bin edges and the number of bins, is returned as the output.

* Function 3 - MeanShift Algorithm:

The meanShift(testBP, I, x0, y0, radius, maxIters, tol) function implements the MeanShift algorithm for object tracking. It takes the probability map testBP, the input frame I, the initial coordinates of the object's center (x0 and y0), the radius of the search window, the maximum number of iterations, and a tolerance value. The algorithm iteratively shifts the window's center based on the weighted average of pixel values within the window until convergence or reaching the maximum number of iterations. The final coordinates, the updated mask, and a limits mask are returned as outputs.

* Function 4 - BackProjection:

The BackProjection(I, ballHistogram) function performs backprojection for the input frame I using the ball's histogram. It converts the frame to the HSV color space and computes the hue value for each pixel. By matching the hue value to the corresponding histogram bin, a probability map is created. The resulting probability map, or backprojection, is returned as the output.

* Function 5 - Bounds Tracked Object:

The boundsTrackedObject(I, objLimits) function takes the input frame I and the limits of the tracked object as input. It overlays a circular boundary on the frame to visualize the tracked object's location. The resulting image with the boundary is returned as the output.


If you have any questions or require further information, please don't hesitate to contact me. 
