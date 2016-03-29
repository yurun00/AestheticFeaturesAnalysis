% DESCRIPTION: This file extracts the Tamura texture features of all 
% paintings in global variable 'paintings_by_style' and save them as '.mat'
% files. 
% The Tamura texture feature consists of six components:coarseness, 
% contrast, directionality, line-likeness, regularity, and roughness. But
% only the first three of them are used. Instead of a global value, for
% these three features a per-pixel value is demanded. 
%
% To achieve per-pixel values, only the steps 1 to 3 are done in the 
% calculation of the |coarseness|, resulting in a coarseness measure per 
% pixel.
% The |contrast| is calculated in 13 ¡Á 13 neighborhoods for each pixel. 
% The |directionality| is calculated pixelwise. For each pixel, the 
% direction of the area around this pixel is denoted.
% Once Three values are available for each pixel, the histograms will be
% calculated just like the RGB or HSV histograms.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author: Run Yu
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn 
% Created: 03/23/2016; Last revision: 03/23/2016

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\..\data\global_var\';
addr_mat = '..\..\..\data\paintings_mat\';
addr_feature = '..\..\..\data\features\tamura\';

paintings_by_style = load([addr_glb, 'paintings_by_style.mat']);
paintings_by_style = paintings_by_style.paintings_by_style;
paintings = paintings_by_style.values;
paintings = [paintings{:}];

mkdir([addr_feature, 'perpixel_features_style\']);
for i = 1:length(paintings)
    if(exist([addr_feature, 'perpixel_features_style\', paintings{i} , '_tamura_perpixel.mat'],'file'))
        disp(i);
        continue;
    end
%     paintings{i} = paintings{i}(1:strfind(paintings{i},'.jpg')-1);
    % Load image
    img_in = load([addr_mat, paintings{i}, '.mat']);
    img_in = img_in.img;
    
    % Check the dimension of the input image
    if (ndims(img_in) == 2)
        disp('dim is 2');
        img_in = repmat(img_in, [1, 1, 3]);
    end
    gimg = rgb2gray(img_in);
    
    % Compute the tamura texture features for per pixel
    [Fcrs, Pcrs] = coarseness(double(gimg));
    [Fcon, Pcon] = contrast(double(gimg));
    [Fdir, Pdir, HD] = directionality(double(gimg));

    % Save tamura texture features for per pixel as files
    save([addr_feature, 'perpixel_features_style\', paintings{i} , '_tamura_perpixel.mat'], 'Pcrs', 'Pcon', 'Pdir');
    disp(i);
end

%------------- END OF CODE --------------