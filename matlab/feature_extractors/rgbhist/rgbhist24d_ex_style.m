% DESCRIPTION: This file extracts the rgb histograms of all paintings in
% the global variable 'paintings_by_style' and save them as '.mat' files. 
% The rgb histograms are three histograms indicate the red, green and blue 
% component seperately.
%
% Other m-files required: histograms_rgb.m
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author: Run Yu
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn 
% Created: 03/12/2016; Last revision: 03/12/2016

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\..\data\global_var\';
addr_mat = '..\..\..\data\paintings_mat\';
addr_feature = '..\..\..\data\features\rgb_hist\';

paintings_by_style = load([addr_glb, 'paintings_by_style.mat']);
paintings_by_style = paintings_by_style.paintings_by_style;
paintings = paintings_by_style.values;
paintings = [paintings{:}];

mkdir([addr_feature, 'features_style\']);
for i = 1:length(paintings)
    if(exist([addr_feature, 'features_style\', paintings{i} , '_rgb_hist24d.mat'],'file'))
        continue;
    end
    % Load image
    img_in = load([addr_mat, paintings{i}, '.mat']);
    img_in = img_in.img;

    % Compute the RGB histogram
    [nh_r,nh_g,nh_b] = histograms_rgb(img_in);
    rgb_hist = [nh_r,nh_g,nh_b];

    % Save RGB histogram as files
    save([addr_feature, 'features_style\', paintings{i} , '_rgb_hist24d.mat'], 'rgb_hist');
    disp(i);
end

%------------- END OF CODE --------------