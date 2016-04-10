% DESCRIPTION: This file extracts the straight line features of all 
% paintings in global variable 'paintings_by_style' and save them as '.mat'
% files. 
% The straight line feature is a 4x1 vector in which each float number 
% indicates mean slope, mean length, standard deviation of slopes and 
% standard deviation of lengths of all the detected straight lines.
% Canny edge detector and Hough transform are used to find straight lines 
% that are longer than 10 pixels.
%
% Other m-files required: straight_line.m
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author: Run Yu
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn 
% Created: 04/09/2016; Last revision: 04/09/2016

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\..\data\global_var\';
addr_mat = '..\..\..\data\paintings_mat\';
addr_feature = '..\..\..\data\features\line\';

paintings_by_style = load([addr_glb, 'paintings_by_style.mat']);
paintings_by_style = paintings_by_style.paintings_by_style;
paintings = paintings_by_style.values;
paintings = [paintings{:}];

mkdir([addr_feature, 'features_style\']);
for i = 1:length(paintings)
%     if(exist([addr_feature, 'features_style\', paintings{i} , '_lines.mat'],'file'))
%         continue;
%     end
    % Load image
    img_in = load([addr_mat, paintings{i}, '.mat']);
    img_in = img_in.img;
    
    % Check the dimension of the input image
    if (ndims(img_in) == 2)
        disp('dim is 2');
        img_in = repmat(img_in, [1, 1, 3]);
    end
    gimg = rgb2gray(img_in);
    
    % Compute the straight line features
    lines = straight_line(gimg);

    % Save edge pixel ratios as files
    save([addr_feature, 'features_style\', paintings{i} , '_lines.mat'], 'lines');
    disp(i);
end

%------------- END OF CODE --------------