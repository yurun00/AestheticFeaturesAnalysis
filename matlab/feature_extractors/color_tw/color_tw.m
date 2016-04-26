function [gbcolor, lccolor] = color_tw( I )
height = size(I,1);
width = size(I,2);
aspect_ratio = width/height;

% if image size is too big shrink 1/2
th = 500;
if (height>th||width>th)
 I = imresize(I,[th,th*aspect_ratio]);
end

[glb_t,glb_w,glb_contrast] = Glbcolor(I);
gbcolor(1,1)=glb_t;
gbcolor(1,2)=glb_w;
gbcolor(1,3:7)= glb_contrast(1,1:5);

[lc_t,lc_w,lc_contrast] = Localcolor(I);
lccolor(1,1:3)= lc_t(1:3);
lccolor(1,4:6)= lc_w(1:3);
lccolor(1,7:11)=lc_contrast(1:5);