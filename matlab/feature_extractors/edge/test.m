addr_jpg = '..\..\..\test\data\edge\machine.png';
img = imread(addr_jpg);
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

f = figure(1);
set(f, 'Position', [200,100,1000,500]);

sp1 = subplot(2,3,1);
imshow(gimg);
set(sp1,'Position',[0.025,0.55,0.3,0.3]);

sp2 = subplot(2,3,2);
imshow(bimg1);
set(sp2,'Position',[0.35,0.55,0.3,0.3]);

sp3 = subplot(2,3,3);
imshow(bimg2);
set(sp3,'Position',[0.675,0.55,0.3,0.3]);

sp4 = subplot(2,3,4);
imshow(bimg3);
set(sp4,'Position',[0.025,0.15,0.3,0.3]);

sp5 = subplot(2,3,5);
imshow(bimg4);
set(sp5,'Position',[0.35,0.15,0.3,0.3]);