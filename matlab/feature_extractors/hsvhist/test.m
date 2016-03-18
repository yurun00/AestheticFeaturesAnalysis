% addr_jpg = '..\..\..\..\test\data\rgb_hsv\red.jpg';
addr_jpg = '..\..\..\..\test\data\rgb_hsv\a-nook-of-old-yerevan-1928.jpg';
img = imread(addr_jpg);
[nh_h,nh_s,nh_v] = histograms_hsv(img);
xmx = numel(nh_h) + 1;

f = figure(1);
set(f, 'Position', [200,100,1000,500]);

ax_sp1 = subplot(1,3,1);
hold(ax_sp1, 'on');
itv = (1:2:15)/16;
c = [itv.',ones(8,1),ones(8,1)];
c = hsv2rgb(c);
% c = hsv(numel(nh_h));
for i = 1:numel(nh_h)
    bar(i, nh_h(i), 'parent', ax_sp1, 'facecolor', c(i,:));
end
title('hue histogram');
axis([0,xmx,0,max(nh_h)]);
set(ax_sp1,'Position',[0.025,0.4,0.3,0.3]);

ax_sp2 = subplot(1,3,2);
hold(ax_sp2, 'on');
c = [ones(8,1),itv.',ones(8,1)];
c = hsv2rgb(c);
for i = 1:numel(nh_s)
    bar(i, nh_s(i), 'parent', ax_sp2, 'facecolor', c(i,:));
end
title('saturation histogram');
axis([0,xmx,0,max(nh_s)]);
set(ax_sp2,'Position',[0.35,0.4,0.3,0.3]);

ax_sp3 = subplot(1,3,3);
hold(ax_sp3, 'on');
c = [ones(8,1),zeros(8,1),itv.'];
c = hsv2rgb(c);
for i = 1:numel(nh_v)
    bar(i, nh_v(i), 'parent', ax_sp3, 'facecolor', c(i,:));
end
title('value histogram');
axis([0,xmx,0,max(nh_v)]);
set(ax_sp3,'Position',[0.675,0.4,0.3,0.3]);