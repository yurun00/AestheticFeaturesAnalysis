clear;clc;
addr_jpg = '..\..\..\test\data\rgb_hsv\a-nook-of-old-yerevan-1928.jpg';
% addr_jpg = '..\..\..\test\data\texture\D15.jpg';
% addr_jpg = '..\..\..\test\data\texture\D49.gif';
img = imread(addr_jpg);
if (ndims(img) == 2)
    disp('dim is 2');
    img = repmat(img, [1, 1, 3]);
end
gimg = rgb2gray(img);
CoaFeatures = coarseness(double(gimg));
disp('coarseness');
% [DirFeatures,sita,HD] = min([directionality(double(gimg)),...
%     directionality(double(imrotate(gimg,45,'bilinear','crop'))),...
%     directionality(double(imrotate(gimg,90,'bilinear','crop'))),...
%     directionality(double(imrotate(gimg,-45,'bilinear','crop')))]);
Contrasts = contrast(double(gimg));