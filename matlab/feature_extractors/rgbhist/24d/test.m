% addr_jpg = '..\..\..\..\test\data\rgb_hsv\green.jpg';
addr_jpg = '..\..\..\..\test\data\rgb_hsv\canal-near-brussels-1871.jpg';
img = imread(addr_jpg);
[nh_r,nh_g,nh_b] = histograms_rgb(img);
xmx = numel(nh_r) + 1;

f = figure(1);
set(f, 'Position', [200,100,1000,500]);

sp1 = subplot(1,3,1);
br = bar(nh_r,'r');
title('red histogram');
axis([0,xmx,0,max(nh_r)]);
set(sp1,'Position',[0.025,0.4,0.3,0.3]);

sp2 = subplot(1,3,2);
bg = bar(nh_g,'g');
title('green histogram');
axis([0,xmx,0,max(nh_g)]);
set(sp2,'Position',[0.35,0.4,0.3,0.3]);

sp3 = subplot(1,3,3);
bb = bar(nh_b,'b');
title('blue histogram');
axis([0,xmx,0,max(nh_b)]);
set(sp3,'Position',[0.675,0.4,0.3,0.3]);