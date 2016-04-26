addr = '..\..\..\test\data\composition\';
addr_mat = '..\..\..\data\paintings_mat\';
load([addr_mat,'along-the-amstel-1903.mat']);
[~,sa_cv,sa_ecc, sa_re, focus,thirds] = composition(img);
