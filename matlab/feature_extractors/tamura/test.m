% addr_jpg = '..\..\..\test\data\rgb_hsv\green.jpg';
addr_jpg = '..\..\..\test\data\rgb_hsv\canal-near-brussels-1871.jpg';
img = imread(addr_jpg);
gimg = rgb2gray(img);
CoaFeatures = coarseness(double(gimg));
DirFeatures = min([directionality(double(gimg)),...
    directionality(double(imrotate(gimg,45,'bilinear','crop'))),...
    directionality(double(imrotate(gimg,90,'bilinear','crop'))),...
    directionality(double(imrotate(gimg,-45,'bilinear','crop')))]);
Contrasts = contrast(double(gimg));