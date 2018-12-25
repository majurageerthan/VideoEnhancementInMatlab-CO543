clc;
clear all;
close all;
reader = vision.VideoFileReader('3.mp4');
viewer = vision.DeployableVideoPlayer;

%creating optical flow
opFlow = vision.OpticalFlow;
optical.OutputValue = 'Horizontal and vertical components in complex form';

%Displaying vector field
shapes = vision.ShapeInserter;
shapes.Shape = 'Lines';
shapes.BorderColor = 'white';

R=1:4:120;
C=1:4:160;
[Cv,Rv] = meshgrid(C,R);
Rv = Rv(:)';
Cv = Cv(:)';

%Execution
reset(reader);


while ~isDone(reader)
   I = step(reader); 
   
   of = step(opFlow,rgb2gray(I));
   
   y1 = of.* conj(of);
   
   step(viewer,y1 > mean(y1(:)));
    
end