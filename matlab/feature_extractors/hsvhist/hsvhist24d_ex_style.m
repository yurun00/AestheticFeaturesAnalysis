% DESCRIPTION: This file extracts the hsv histograms of all paintings in
% the global variable 'paintings_by_style' and save them as '.mat' files. 
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
% Created: 03/13/2016; Last revision: 03/18/2016

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\..\data\global_var\';
addr_mat = '..\..\..\data\paintings_mat\';
addr_feature = '..\..\..\data\features\hsv_hist\';

paintings_by_style = load([addr_glb, 'paintings_by_style.mat']);
paintings_by_style = paintings_by_style.paintings_by_style;
paintings = paintings_by_style.values;
paintings = [paintings{:}];

mkdir([addr_feature, 'features_style\']);
for i = 1:length(paintings)
    if(exist([addr_feature, 'features_style\', paintings{i} , '_hsv_hist24d.mat'],'file'))
        continue;
    end
    % Load image
    img_in = load([addr_mat, paintings{i}, '.mat']);
    img_in = img_in.img;

    % Compute the RGB histogram
    [nh_h,nh_s,nh_v] = histograms_hsv(img_in);
    hsv_hist = [nh_h,nh_s,nh_v];

    % Save RGB histogram as files
    save([addr_feature, 'features_style\', paintings{i} , '_hsv_hist24d.mat'], 'hsv_hist');
    disp(i);
end

%------------- END OF CODE --------------