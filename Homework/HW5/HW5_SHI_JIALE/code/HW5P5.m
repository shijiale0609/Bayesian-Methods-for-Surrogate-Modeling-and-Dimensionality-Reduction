clear all;
clc;

I = imread('~/ML/2019S/HW5/Resources/P5/P5.jpg');
txt = ocr(I) ; 
R = txt.WordBoundingBoxes
img = I;
for i = 1:298
    for j = 1:439
        if (I(i,j,1)>=180) && (I(i,j,2)<=60) && (I(i,j,3)<=60)
            img(i,j,1) = 0;
            img(i,j,2) = 0;
            img(i,j,3) = 0;
            img(i-1,j,1) = 0;
            img(i-1,j,2) = 0;
            img(i-1,j,3) = 0;
            img(i+1,j,1) = 0;
            img(i+1,j,2) = 0;
            img(i+1,j,3) = 0;
            img(i,j-1,1) = 0;
            img(i,j-1,2) = 0;
            img(i,j-1,3) = 0;
            img(i,j+1,1) = 0;
            img(i,j+1,2) = 0;
            img(i,j+1,3) = 0;
            
%             img(i+1,j+1,1) = 0;
%             img(i+1,j+1,2) = 0;
%             img(i+1,j+1,3) = 0;
%             
%             img(i+1,j-1,1) = 0;
%             img(i+1,j-1,2) = 0;
%             img(i+1,j-1,3) = 0;
%             
%             img(i-1,j+1,1) = 0;
%             img(i-1,j+1,2) = 0;
%             img(i-1,j+1,3) = 0;
%             
%             img(i-1,j-1,1) = 0;
%             img(i-1,j-1,2) = 0;
%             img(i-1,j-1,3) = 0;
            
            
        end
    end
end
figure;

imshowpair(I,img,'montage');