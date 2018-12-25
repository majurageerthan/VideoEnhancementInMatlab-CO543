clc;
clear all;
close all;

vidFile = '1.mp4';
vidObj = VideoReader(vidFile);
numFrames = vidObj.NumberOfFrames;
vidWidth = vidObj.Width;
vidHeight = vidObj.Height;

falseNegativeCount = 0;
tic;
figure;
for f = 1:numFrames
    
    I = read(vidObj, f);
    subplot(3,3,[1 2 3]);
    imshow(I);
    title('Original Frame');
    
    [row col nch] = size(I);
    
    if(nch >1)
        Igray = rgb2gray(I);
    else
        Igray = I;
    end
    subplot(3,3,4);
    imshow(Igray,[]);
    title('Gray Image');
    
    % Add salt and pepper noise
    Inoise = imnoise(Igray, 'Salt & Pepper');
    subplot(3,3,5);
    imshow(Inoise,[]);
    title('Salt & Pepper Noise Image');
    
    % Median filtering
    
    ImedFIlteredImage = medfilt2(Inoise, [3 3]);
    subplot(3,3,6);
    imshow(ImedFIlteredImage,[]);
    title('Median Filtered Image');
    
    
    img1 = double(Igray);
    img2 = double(ImedFIlteredImage);
    [row col] = size(img1);
    
%     if(img1 == img2)
%         disp('PSNR value is infinite');
%     else
%         MSE = 0;
%         for r = 1: row
%             for c = 1:col
%                 MSE = MSE + (img1(r,c) - img2(r,c))^2;
%             end
%         end
%         MSE = MSE / (row * col);
%         
%         PSNR = 10 * log((255^2) / MSE);
%     end
%     disp('MSE for Median Filtering:');
%     disp(MSE);
%     disp('PSNR for Median Filtering:');
%     disp(PSNR);
    



    % Average filtering
    
    IavgFIlteredImage = imfilter(Igray, fspecial('average',[3 3]));
    subplot(3,3,7);
    imshow(IavgFIlteredImage,[]);
    title('Average Filtered Image');
    
    img1 = double(Igray);
    img2 = double(IavgFIlteredImage);
    [row col] = size(img1);
    
%     if(img1 == img2)
%         disp('PSNR value is infinite');
%     else
%         MSE = 0;
%         for r = 1: row
%             for c = 1:col
%                 MSE = MSE + (img1(r,c) - img2(r,c))^2;
%             end
%         end
%         MSE = MSE / (row * col);
%         
%         PSNR = 10 * log((255^2) / MSE);
%     end
%     disp('MSE for Avrage Filtering:');
%     disp(MSE);
%     disp('PSNR for Avrage Filtering:');
%     disp(PSNR);
    
    
    % Edge detection
    Iedge = edge(Igray, 'sobel');
    subplot(3,3,8);
    imshow(Iedge);
    title('Sobel Edge Detected Image');
    
    % Intensity Slicing
    Islice = grayslice(Igray,8);
    subplot(3,3,9);
    imshow(Islice,[]);
    title('Intensity Slicing Image');
    
end
