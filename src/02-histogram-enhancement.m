% Remote Sensing - Lab 2
% Histogram Manipulation in MATLAB (Separated Figures)

% Clear workspace
clear; close all; clc;

% Step 1: Load and convert the image to grayscale
img = imread('drone.png');          % Load the original image
gray_img = rgb2gray(img);          % Convert to grayscale

% Step 2: Display grayscale image and its histogram in separate figure
figure;
imshow(gray_img);
title('Original Grayscale Image');

figure;
imhist(gray_img);
title('Histogram of Original Image');

% Step 3: Perform histogram equalization
equalized_img = histeq(gray_img);  % Histogram equalization

% Step 4: Display equalized image and its histogram in separate figure
figure;
imshow(equalized_img);
title('Histogram Equalized Image');

figure;
imhist(equalized_img);
title('Histogram After Equalization');

% Optional: Save output images (if needed)
imwrite(gray_img, 'gray_drone.png');
imwrite(equalized_img, 'equalized_drone.png');
