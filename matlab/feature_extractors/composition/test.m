addr = '..\..\..\test\data\composition\';
img = imread([addr,'portrait-of-two-women-1914.jpg']);
[~,format,sa_cv,sa_ecc, sa_re, focus,thirds] = composition(img);