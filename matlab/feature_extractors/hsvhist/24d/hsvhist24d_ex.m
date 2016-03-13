% DESCRIPTION: This file extracts the hsv histograms of all paintings in
% directory '..\..\..\data\paintings_mat' and save them as '.mat' files. 
% The hsv histograms are three histograms indicate the hue, saturation and 
% value component seperately.
%
% Other m-files required: histograms_hsv.m
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author: Run Yu
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn 
% Created: 03/13/2016; Last revision: 03/13/2016

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\..\..\data\global_var\';
addr_mat = '..\..\..\..\data\paintings_mat\';
addr_feature = '..\..\..\..\data\features\hsv_hist\24d\';

paintings = load([addr_glb, 'paintings.mat']);
paintings = paintings.paintings;

mkdir([addr_feature, 'all_features\']);
for i = 1:length(paintings)
    % Load image
    img_in = load([addr_mat, paintings{i}, '.mat']);
    img_in = img_in.img;

    % Compute the RGB histogram
    [nh_h,nh_s,nh_v] = histograms_hsv(img_in);
    hsvhist = [nh_h,nh_s,nh_v];

    % Save RGB histogram as files
    save([addr_feature, 'all_features\', paintings{i} , '_hsvhist24d.mat'], 'hsvhist');
    disp(i);
end

%------------- END OF CODE --------------