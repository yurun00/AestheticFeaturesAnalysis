addr = '..\..\..\test\data\edge\bathers-on-the-beach-under-umbrella-1955.jpg';
img = imread(addr);
gimg = rgb2gray(img);
thresh = [.2,.3,.4,.6];
% By default for canny edge detector, low threshold = high threshold * 0.4
% the input threshold is the high threshold
[bimg1, thresh1, ratio1] = canny(gimg, thresh(1));
[bimg2, thresh2, ratio2] = canny(gimg, thresh(2));
[bimg3, thresh3, ratio3] = canny(gimg, thresh(3));
[bimg4, thresh4, ratio4] = canny(gimg, thresh(4));
% [bimg1, thresh1, ratio1] = edge_ratio(gimg, [thresh(1)*0, thresh(1)]);
% [bimg2, thresh2, ratio2] = edge_ratio(gimg, [thresh(2)*0, thresh(2)]);
% [bimg3, thresh3, ratio3] = edge_ratio(gimg, [thresh(3)*0, thresh(3)]);
% [bimg4, thresh4, ratio4] = edge_ratio(gimg, [thresh(4)*0, thresh(4)]);

f1 = figure(1);
set(f1, 'Position',  [500,400,400,200]);
imshow(gimg);


f2 = figure(2);
set(f2, 'Position', [20,60,1300,600]);

sp1 = subplot(2,2,1);
imshow(bimg1);
set(sp1,'Position',[0.03,0,0.45,1]);

sp2 = subplot(2,2,2);
imshow(bimg2);
set(sp2,'Position',[0.52,0,0.45,1]);

f3 = figure(3);
set(f3, 'Position', [20,60,1300,600]);

sp3 = subplot(2,2,3);
imshow(bimg3);
set(sp3,'Position',[0.03,0,0.45,1]);

sp4 = subplot(2,2,4);
imshow(bimg4);
set(sp4,'Position',[0.52,0,0.45,1]);