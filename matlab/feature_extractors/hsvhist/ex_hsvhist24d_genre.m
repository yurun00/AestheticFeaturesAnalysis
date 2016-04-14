% DESCRIPTION: This file extracts the hsv histograms of all paintings in
% the global variable 'paintings_by_genre' and save them as '.mat' files. 
% The hsv histograms are three histograms indicate the hue, saturation and 
% value component seperately.
%
% Other m-files required: histograms_hsv.m
% Subfunctions: none
% MAT-files required: ..\..\..\data\global_var\paintings_by_genre.mat
%   ..\..\..\data\paintings_mat\*.mat
%
% See also: none

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\..\data\global_var\';
addr_mat = '..\..\..\data\paintings_mat\';
addr_feature = '..\..\..\data\features\hsv_hist\';

paintings_by_genre = load([addr_glb, 'paintings_by_genre.mat']);
paintings_by_genre = paintings_by_genre.paintings_by_genre;
paintings = paintings_by_genre.values;
paintings = [paintings{:}];

mkdir([addr_feature, 'features_genre\']);
for i = 1:length(paintings)
    if(exist([addr_feature, 'features_genre\', paintings{i} , '_hsv_hist24d.mat'],'file'))
        continue;
    end
    % Load image
    load([addr_mat, paintings{i}, '.mat']);

    % Compute the RGB histogram
    [nh_h,nh_s,nh_v] = histograms_hsv(img);
    hsv_hist = [nh_h,nh_s,nh_v];

    % Save RGB histogram as files
    save([addr_feature, 'features_genre\', paintings{i} , '_hsv_hist24d.mat'], 'hsv_hist');
    disp(i);
end

%------------- END OF CODE --------------