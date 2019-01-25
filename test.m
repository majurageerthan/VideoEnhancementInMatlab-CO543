clc;
clear all;
close all;

I = imread('11.png');
grayImg = rgb2gray(I); %convert gray
y = edgeDe(grayImg);
imshow(y);

