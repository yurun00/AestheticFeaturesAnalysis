% DESCRIPTION: This file extracts the saliency maps and shapes of all 
% paintings in global variable 'paintings_by_style' and save them as '.mat'
% files. 
% The saliency map should be generated using The SaliencyToolBox downloaded
% from http://www.saliencytoolbox.net/. The saliency maps will be 
% extracted. Then the shapes of the most saliency locations will be stored.

% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: SaliencyToolBox\

% Author: Run Yu
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn 
% Created: 04/08/2016; Last revision: 04/08/2016

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

    % Calculate saliency maps
    [salMaps,fixations,shapes] = aayrrunSaliency([addr,'courtyard-of-a-farm-at-saint-mammes-1884.jpg'],5);

    % Save saliency-related features as files
    save([addr_feature, 'sal_maps_style\', paintings{i} , '_sal_maps.mat'], 'salMaps', 'fixations', 'shapes');
    disp(i);
end

%------------- END OF CODE --------------