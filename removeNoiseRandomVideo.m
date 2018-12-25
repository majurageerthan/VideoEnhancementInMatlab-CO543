clc;
clear all;
close all;
%create waitbar
f = waitbar(0,'Please wait...'); % default = false

vidFile = 'NoiseVideo1.MP4';

vidObj = VideoReader(vidFile);
% numFrames = vidObj.NumberOfFrames;
vidWidth = vidObj.Width;
vidHeight = vidObj.Height;
vidFrames = vidObj.Duration * vidObj.FrameRate; 

% Create a movie structure array, mov.
% mov = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
%     'colormap',[]);

%   mov = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
%      'colormap',[]);
  movOriginal = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
     'colormap',[]);
  movNoiseRemoved = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
     'colormap',[]);
    


% Read one frame at a time until the end of the video is reached
k = 1;
while hasFrame(vidObj)
    %waitbar increase
    waitbar(k/vidFrames,f,'Processing Salt and pepper..... Please wait');
    
    %change rgb to gray 
      RGBimg = readFrame(vidObj); %taking frame
      grayImg = rgb2gray(RGBimg); %convert gray
     
    
    %remove salt and pepper noise
    %****************************************************
    [m,n] = size(grayImg);

%     noiseRemovedImg = zeros(m,n);
    noiseRemovedImg = medfilt2(grayImg);
    noiseRemovedImg = uint8(noiseRemovedImg);
    
    %Algorithm to run median filter
    
%     for i = 1:m
%         for j = 1:n  %intesity of pixel in the noisy image is given as noisy(i,j)
%             % here we define max and minimum values x and y coordinates of any
%             % pixel can take
%             xmin = max(1,i-1); % minimum x coordinate has to be greater than or equal to 1
%             xmax = min(m,i+1);
%             ymin = max(1,j-1);
%             ymax = min(n,j+1);
%             % the neighbourhood matrix will then be
%             temp = noisyImg(xmin:xmax, ymin:ymax);
%             %now the new intensity of pixel at (i,j) will be median of this
%             %matrix
%             noiseRemovedImg(i,j) = median(temp(:));
%         end
%     end
    
    
    %******************************************************
    
    %   C = cat(dim, A, B)concatenates the arrays A and B along array the dimension specified by dim. The dim argument must be a real, positive, integer value.
    originalGrayFrame = cat(3, grayImg, grayImg, grayImg);
    finalNoiseRemovedFrame = cat(3, noiseRemovedImg, noiseRemovedImg, noiseRemovedImg);
   
    %histogram processing end
%     mov(k).cdata = originalGrayFrame;
    movOriginal(k).cdata = originalGrayFrame;
    movNoiseRemoved(k).cdata = finalNoiseRemovedFrame;
    k = k+1;
end
%close the wait bar
close(f);

% Size a figure based on the width and height of the video. Then, play back the movie once at the video frame rate.
hf = figure('Name','Original video');
set(hf,'position',[150 300 vidWidth vidHeight]);

% movie function plays the movie defined by a matrix whose columns are movie frames
 movie(hf,movOriginal,1,vidObj.FrameRate);
 
 
% Size a figure based on the width and height of the video. Then, play back the movie once at the video frame rate.
hf2 = figure('Name','Noise removed video');
set(hf2,'position',[800 300 vidWidth vidHeight]);
 
%Play the noise removed video
 movie(hf2,movNoiseRemoved,1,vidObj.FrameRate);

%close the figures after 3 sec
pause(3);
close(hf);
close(hf2);
