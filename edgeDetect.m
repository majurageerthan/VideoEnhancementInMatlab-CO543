clc;
%clear all;
close all;

vidFile = '1New1.mp4';
%create waitbar
f = waitbar(0,'Please wait...'); % default = false


vidObj = VideoReader(vidFile);
% numFrames = vidObj.NumberOfFrames;
vidWidth = vidObj.Width;
vidHeight = vidObj.Height;
vidFrames = vidObj.Duration * vidObj.FrameRate; 

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
    %waitbar increase
    waitbar(k/vidFrames,f,'Processing Edge detect..... Please wait');
    
    %histogram processing start
      RGBimg = readFrame(vidObj); %taking frame
      grayImg = rgb2gray(RGBimg); %convert gray      
      BWs = edge(grayImg,'canny');
      BWs = uint8(BWs);

  
%   C = cat(dim, A, B)concatenates the arrays A and B along array the dimension specified by dim. The dim argument must be a real, positive, integer value.
    finalFrame = cat(3, BWs, BWs, BWs);
   
    %histogram processing end
    mov(k).cdata = finalFrame;
    movOriginal(k).cdata = RGBimg;
    k = k+1;
end

%close the wait bar
close(f);

% Size a figure based on the width and height of the video. Then, play back the movie once at the video frame rate.
hf = figure('Name','Original video');
set(hf,'position',[200 300 vidWidth vidHeight]);

% movie function plays the movie defined by a matrix whose columns are movie frames
movie(hf,movOriginal,1,vidObj.FrameRate);
 
% Size a figure based on the width and height of the video. Then, play back the movie once at the video frame rate.
hf1 = figure('Name','Brightness video');
set(hf1,'position',[700 300 vidWidth vidHeight]);

%Play the original video
movie(hf1,mov,1,vidObj.FrameRate);

%close the figures after 3 sec
pause(3);
close(hf);
close(hf1);
