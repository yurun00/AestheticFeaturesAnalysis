% DESCRIPTION: This file extracts the rgb histograms of all paintings in
% the global variable 'paintings_by_genre' and save them as '.mat' files. 
% The rgb histograms are three histograms indicate the red, green and blue 
% component seperately.
%
% Other m-files required: histograms_rgb.m
% Subfunctions: none
% MAT-files required: ..\..\..\data\global_var\paintings_by_genre.mat
%   ..\..\..\data\paintings_mat\*.mat
%
% See also: none

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\..\data\global_var\';
addr_mat = '..\..\..\data\paintings_mat\';
addr_feature = '..\..\..\data\features\rgb_hist\';

paintings_by_genre = load([addr_glb, 'paintings_by_genre.mat']);
paintings_by_genre = paintings_by_genre.paintings_by_genre;
paintings = paintings_by_genre.values;
paintings = [paintings{:}];

mkdir([addr_feature, 'features_genre\']);
for i = 1:length(paintings)
    if(exist([addr_feature, 'features_genre\', paintings{i} , '_rgb_hist24d.mat'],'file'))
        continue;
    end
    % Load image
    load([addr_mat, paintings{i}, '.mat']);

    % Compute the RGB histogram
    [nh_r,nh_g,nh_b] = histograms_rgb(img);
    rgb_hist = [nh_r,nh_g,nh_b];

    % Save RGB histogram as files
    save([addr_feature, 'features_genre\', paintings{i} , '_rgb_hist24d.mat'], 'rgb_hist');
    disp(i);
end

%------------- END OF CODE --------------