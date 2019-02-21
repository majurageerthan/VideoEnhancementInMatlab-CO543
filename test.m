% program for edge detection 
clc; clear all; close all;
%read an image


[filename, pathname, filterindex] = uigetfile( ...
{  '*.jpg','png (*.jpg)'; ...
   '*.bmp','Windows Bitmap (*.bmp)'; ...
   '*.fig','Figures (*.fig)'; ...
   '*.*',  'All Files (*.*)'}, ...
   'Choose image(s) to be processed', ...
   'MultiSelect', 'off');

if filterindex==0, break;end

filename=cellstr(filename);

y= imread(horzcat(pathname,char(filename)));

% y=imread('car3.jpg');
mm=input('Input your threshold between 0 and 255    ');

% convert color image to gray scale 

x= rgb2gray(y);
imshow(x);

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
figure
imshow(x);

BW = im2bw(x, 0.5);
figure
imshow(BW)

