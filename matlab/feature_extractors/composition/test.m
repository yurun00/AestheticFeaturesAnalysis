% addr = '..\..\..\test\data\composition\';
% img = imread([addr,'banks-of-a-river.jpg']);
% [~,format,sa_cv,sa_ecc, sa_re, focus,thirds] = composition(img);

n = 50000;
t = pi*rand(1);
X = [cos(t) -sin(t) ; sin(t) cos(t)]*[7 0; 0 2]*rand(2,n);
X = [X  20*(rand(2,1)-0.5)];  % add an outlier

tic
c = minBoundingBox(X);
toc

figure(42);
hold off,  plot(X(1,:),X(2,:),'.')
hold on,   plot(c(1,[1:end 1]),c(2,[1:end 1]),'r')
axis equal