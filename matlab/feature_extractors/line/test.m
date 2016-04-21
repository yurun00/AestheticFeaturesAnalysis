addr = '..\..\..\test\data\line\seated-woman-with-blue-and-red-hat-1939.jpg';
img = imread(addr);
gimg = rgb2gray(img);

[bimg, threshs] = edge(gimg, 'canny', [0,0.5]);
bimg = bwmorph(bimg, 'dilate');
bimg = bwmorph(bimg,'thin');
% [H,T,R] = hough(bimg);
[H,T,R] = hough(bimg,'RhoResolution',5,'ThetaResolution',5);

f1 = figure(1);
imshow(bimg);

f2= figure(2);
imshow(H,[],'XData',T,'YData',R,...
            'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;

% P  = houghpeaks(H,999999,'threshold',ceil(0.3*max(H(:))));
P  = houghpeaks(H,9999,'threshold',ceil(0.2*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');

lines = houghlines(bimg,T,R,P,'FillGap',3,'MinLength',10);
figure(1);
hold on;
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',1,'Color','red');
   distance(1,k) = norm(lines(k).point1 - lines(k).point2);
   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','yellow');