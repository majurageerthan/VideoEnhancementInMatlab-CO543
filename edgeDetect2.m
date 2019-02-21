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
% mm =10;
while hasFrame(vidObj)
    %waitbar increase
    waitbar(k/3,f,'Processing Edge detect..... Please wait');
    
    %histogram processing start
      RGBimg = readFrame(vidObj); %taking frame
      grayImg = rgb2gray(RGBimg); %convert gray      
      x = grayImg;
%       /*****************************/
%       function

[r,c]=size(x);
max=0;
min=0;

   

for j=2:r-1
    for i=2:c-1
        p=i-1;
        q=i+1;
        a=j-1;
        b=j+1;
        d1=abs(x(j,i)-x(j,p));
        d2=x(j,i)-x(j,q);
        e1=x(j,i)-x(a,i);
        e2=x(j,i)-x(b,i);
        f1=x(j,i)-x(a,p);
        f2=x(j,i)-x(b,q);
        g1=x(j,i)-x(a,q);
        g2=x(j,i)-x(b,p);
        if (d1 < 0)
            d1=d1*(-1);
        end
        if (d2 < 0)
            d2=d2*(-1);
        end
        if (e1 < 0)
            e1=e1*(-1);
        end
        if (e2 < 0)
            e2=e2*(-1);
        end
        
        if (f1 < 0)
            f1=f1*(-1);
        end
        if (f2 < 0)
            f2=f2*(-1);
        end
        if (g1 < 0)
            g1=g1*(-1);
        end
        if (g2 < 0)
            g2=g2*(-1);
        end
        
        
        if (d1 >= mm) && (d2 >= mm)
            x(j,i)=255;
        elseif (e1 >= mm) && (e2 >= mm)
            x(j,i)=255;
        elseif (f1 >= mm) && (f2 >= mm)
            x(j,i)=255;
        elseif (g1 >= mm) && (g2 >= mm)
            x(j,i)=255;
        else
            x(j,i)=0;  
                
        end
    end
end
      
%       /********************************/
      

  
%   C = cat(dim, A, B)concatenates the arrays A and B along array the dimension specified by dim. The dim argument must be a real, positive, integer value.
    finalFrame = cat(3, x, x, x);
   
    %histogram processing end
    mov(k).cdata = finalFrame;
    movOriginal(k).cdata = RGBimg;
    k = k+1;
    
    if k > 2
        break;
    end
end

%close the wait bar
close(f);

% Size a figure based on the width and height of the video. Then, play back the movie once at the video frame rate.
hf = figure('Name','Original video');
set(hf,'position',[200 300 vidWidth vidHeight]);

% movie function plays the movie defined by a matrix whose columns are movie frames
movie(hf,movOriginal,1,vidObj.FrameRate);
 
% Size a figure based on the width and height of the video. Then, play back the movie once at the video frame rate.
hf1 = figure('Name','Edge direct video');
set(hf1,'position',[700 300 vidWidth vidHeight]);

%Play the original video
movie(hf1,mov,1,vidObj.FrameRate);

%close the figures after 3 sec
% pause(3);
% close(hf);
% close(hf1);
