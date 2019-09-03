clear all;
clc;

I= imread('~/ML/2019S/HW5/Resources/P5/P5.jpg');
% Load an image.
%I = imread('businessCard.png');


% Run OCR on the image
results = ocr(I);
% Set 'TextLayout' to 'Block' to instruct ocr to assume the image
% contains just one block of text.
results = ocr(I,'TextLayout','Block');

results.Text

% The regular expression, '\d', matches the location of any digit in the
% recognized text and ignores all non-digit characters.
regularExpr = '\w';

% Get bounding boxes around text that matches the regular expression
bboxes = locateText(results,regularExpr,'UseRegexp',true);

digits = regexp(results.Text,regularExpr,'match');

% draw boxes around the digits
Idigits = insertObjectAnnotation(I,'rectangle',bboxes,digits);

figure; 
imshow(Idigits);