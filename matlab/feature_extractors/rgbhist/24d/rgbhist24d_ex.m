% DESCRIPTION: This file extracts the rgb histograms scatters from each
% genre directory in '..\..\..\data\paintings_classified\genre\' and save 
% them as '.mat' files. The rgb histograms are three histograms indicate
% the red, green and blue component seperately.
%
% Other m-files required: none
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

addr_glb = '..\..\..\..\data\global_var\';
addr_mat = '..\..\..\..\data\paintings_mat\';
addr_feature = '..\..\..\..\data\features\rgb_hist\24d\';

paintings = load([addr_glb, 'paintings.mat']);
paintings = paintings.paintings;

mkdir([addr_feature, 'all_features\']);
for i = 1:length(paintings)
    % Load image
    img_in = load([addr_mat, paintings{i}, '.mat']);
    img_in = img_in.img;

    % Compute the RGB histogram
    [nh_r,nh_g,nh_b] = histograms_rgb(img_in);
    rgbhist = [nh_r,nh_g,nh_b];

    % Save RGB histogram as files
    save([addr_feature, 'all_features\', paintings{i} , '_rgbhist24d.mat'], 'rgbhist');
    disp(i);
end

%------------- END OF CODE --------------