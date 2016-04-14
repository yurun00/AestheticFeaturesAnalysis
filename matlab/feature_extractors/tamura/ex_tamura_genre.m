% DESCRIPTION: Extracts the Tamura texture features of all paintings in 
% global variable 'paintings_by_genre' and save them as '.mat' files. 
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
% Other m-files required: coarseness.m,contrast.m,directionality.m
% Subfunctions: none
% MAT-files required: ..\..\..\data\global_var\paintings_by_genre.mat
%   ..\..\..\data\paintings_mat\*.mat
%
% See also: none

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\..\data\global_var\';
addr_mat = '..\..\..\data\paintings_mat\';
addr_feature = '..\..\..\data\features\tamura\';

paintings_by_genre = load([addr_glb, 'paintings_by_genre.mat']);
paintings_by_genre = paintings_by_genre.paintings_by_genre;
paintings = paintings_by_genre.values;
paintings = [paintings{:}];

mkdir([addr_feature, 'perpixel_features_genre\']);
for i = 1:length(paintings)
    if(exist([addr_feature, 'perpixel_features_genre\', paintings{i} , '_tamura_perpixel.mat'],'file'))
        disp(i);
        continue;
    end
    % Load image
    load([addr_mat, paintings{i}, '.mat']);
    
    % Check the dimension of the input image
    if (ndims(img) == 2)
        disp('dim is 2');
        img = repmat(img, [1, 1, 3]);
    end
    gimg = rgb2gray(img);
    
    % Compute the tamura texture features for per pixel
    [Fcrs, Pcrs] = coarseness(double(gimg));
    [Fcon, Pcon] = contrast(double(gimg));
    [Fdir, Pdir, HD] = directionality(double(gimg));

    % Save tamura texture features for per pixel as files
    save([addr_feature, 'perpixel_features_genre\', paintings{i} , '_tamura_perpixel.mat'], 'Pcrs', 'Pcon', 'Pdir');
    disp(i);
end

%------------- END OF CODE --------------