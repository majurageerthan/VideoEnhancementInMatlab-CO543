clc;
clear all;
close all;

vidFile = '1.mp4';
vidObj = VideoReader(vidFile);
numFrames = vidObj.NumberOfFrames;
vidWidth = vidObj.Width;
vidHeight = vidObj.Height;

for f = 1:10
    I = read(vidObj, f);
    figure;
    imshow(I);
end


% implay('1.mp4');