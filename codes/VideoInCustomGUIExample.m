function VideoInCustomGUIExample()
videoSrc = vision.VideoFileReader('1New1.mp4', 'ImageColorSpace', 'Intensity');
[hFig, hAxes] = createFigureAndAxes();

insertButtons(hFig, hAxes, videoSrc);
% Initialize the display with the first frame of the video
frame = getAndProcessFrame(videoSrc, 0);
% Display input video frame on axis
showFrameOnAxis(hAxes.axis1, frame);
% showFrameOnAxis(hAxes.axis2, zeros(size(frame)+60,'uint8'));
showFrameOnAxis(hAxes.axis1, frame);
end