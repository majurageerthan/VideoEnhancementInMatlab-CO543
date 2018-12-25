clc;
clear all;
close all;

vidFile = '1New1.mp4';

vidObj = VideoReader(vidFile);
% numFrames = vidObj.NumberOfFrames;
vidWidth = vidObj.Width;
vidHeight = vidObj.Height;

% Create a movie structure array, mov.
% mov = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
%     'colormap',[]);

  mov = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
     'colormap',[]);
  movOriginal = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
     'colormap',[]);
    


% Read one frame at a time until the end of the video is reached
k = 1;
while hasFrame(vidObj)
    %histogram processing start
      RGBimg = readFrame(vidObj); %taking frame
      grayImg = rgb2gray(RGBimg); %convert gray
      hiseqedImg = histeq(grayImg); %histogram function
      
      %testing functions
      %****************************************
%      ind2rgb8(X,cmap)
%      testImg = ind2rgb8 (grayImg,gray);
     %****************************************

  
%   C = cat(dim, A, B)concatenates the arrays A and B along array the dimension specified by dim. The dim argument must be a real, positive, integer value.
    finalFrame = cat(3, hiseqedImg, hiseqedImg, hiseqedImg);
   
    %histogram processing end
    mov(k).cdata = finalFrame;
    movOriginal(k).cdata = RGBimg;
    k = k+1;
end

% Size a figure based on the width and height of the video. Then, play back the movie once at the video frame rate.
hf = figure('Name','Original video');
set(hf,'position',[150 150 vidWidth vidHeight]);

% movie function plays the movie defined by a matrix whose columns are movie frames
 movie(hf,movOriginal,1,vidObj.FrameRate);
 
% Size a figure based on the width and height of the video. Then, play back the movie once at the video frame rate.
hf = figure('Name','Histogram equ video');
set(hf,'position',[150 150 vidWidth vidHeight]);
 
%Play the original video
 movie(hf,mov,1,vidObj.FrameRate);




















% for f = 1:10
%     vidObj.CurrentTime = 2.5;
%     RGBimg = readFrame(vidObj); %taking frame
%     grayImg = rgb2gray(RGBimg); %convert gray
%     J = histeq(grayImg); %histogram function
%     figure;
%     imshow(J);
%     figure;
%     imshow(RGBimg);
%     figure;
%     imshow(grayImg);
% end


% implay('1.mp4');