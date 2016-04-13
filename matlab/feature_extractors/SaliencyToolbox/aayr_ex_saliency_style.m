% DESCRIPTION: Extracts the saliency-related features of all paintings in 
% global variable 'paintings_by_style' and save them as '.mat'files. 
% The saliency map should be generated using The SaliencyToolBox downloaded
% from http://www.saliencytoolbox.net/. The saliency-based features 
% includes 'rule of thirds' and 'golden section'. The saliency map is 
% divided into thirds both horizontal and vertical wise and compute the 
% mean salience for each of the nine sections to interpret 'rule of
% thirds'. Properties of the most salient region such as 'size', 
% 'symmetricity', 'rectangularity' and ¡°most salient point¡± are used to 
% represent properties of ¡°golden section¡± composition principles.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: ..\..\..\data\global_var\paintings_by_style.mat
%   ..\..\..\data\features\saliency\*_saliency.mat
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

mkdir([addr_feature, 'features_style\']);
for i = 1:length(paintings)
    if(exist([addr_feature, 'features_style\', paintings{i} , '_saliency.mat'],'file'))
        disp(i);
        continue;
    end
    % Load saliency maps
    load([addr_feature, 'sal_maps_style\',paintings{i}, '_sal_maps.mat']);

    % Calculate saliency-related features
    % Rule of thirds
    sm = salMaps.data;
    [m,n] = size(sm);
    rot = zeros(9,1);
    idx = 1;
    for j = 1:3
        for k = 1:3
            rot(idx) = sum(sum(sm((j-1)*m/3+1:j*m/3, (k-1)*n/3+1:k*n/3)));
            idx = idx+1;
        end
    end
    
    % Golden section

    % Save saliency-related features as files
    save([addr_feature, 'features_style\', paintings{i} , '_saliency.mat'], 'rot');
    disp(i);
end

%------------- END OF CODE --------------