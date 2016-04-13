% DESCRIPTION: This file extracts the saliency maps and shapes of all 
% paintings in global variable 'paintings_by_style' and save them as '.mat'
% files. 
% The saliency map should be generated using The SaliencyToolBox downloaded
% from http://www.saliencytoolbox.net/. The saliency maps will be 
% extracted. Then the shapes of the most saliency locations will be stored.

% Other m-files required: aayrrunSaliency.m
% Subfunctions: none
% MAT-files required: ..\..\..\data\global_var\paintings_by_style.mat
%   ..\..\..\data\paintings_mat\*.mat
%
% See also: SaliencyToolBox\

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\..\data\global_var\';
addr_mat = '..\..\..\data\paintings_mat\';
addr_feature = '..\..\..\data\features\saliency\';

paintings_by_style = load([addr_glb, 'paintings_by_style.mat']);
paintings_by_style = paintings_by_style.paintings_by_style;
paintings = paintings_by_style.values;
paintings = [paintings{:}];

mkdir([addr_feature, 'sal_maps_style\']);
for i = 1:length(paintings)
    if(exist([addr_feature, 'sal_maps_style\', paintings{i} , '_sal_maps.mat'],'file'))
        disp(i);
        continue;
    end

    % Load the image
    load([addr_mat, paintings{i}, '.mat']);
    
    % Calculate saliency maps
    [salMaps,fixations,shapes] = aayrrunSaliency(img,5);

    % Save saliency-related features as files
    save([addr_feature, 'sal_maps_style\', paintings{i} , '_sal_maps.mat'], 'salMaps', 'fixations', 'shapes');
    disp(i);
end

%------------- END OF CODE --------------