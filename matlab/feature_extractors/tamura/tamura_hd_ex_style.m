% DESCRIPTION: This file uses the extracted Tamura texture features to form
% the histograms of all paintings in global variable 'paintings_by_style' 
% and save them as '.mat' files. 
% The Tamura texture feature consists of six components:coarseness, 
% contrast, directionality, line-likeness, regularity, and roughness. But
% only the first three of them are used. Instead of a global value, for
% these three features a per-pixel value is demanded. 
%
% The three values are available for each pixel, so the histograms are 
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
% Created: 03/29/2016; Last revision: 03/29/2016

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\..\data\global_var\';
addr_mat = '..\..\..\data\paintings_mat\';
addr_feature = '..\..\..\data\features\tamura\';

paintings_by_style = load([addr_glb, 'paintings_by_style.mat']);
paintings_by_style = paintings_by_style.paintings_by_style;
paintings = paintings_by_style.values;
paintings = [paintings{:}];

mkdir([addr_feature, 'features_style\']);
mxCon = 0;
for i = 1:length(paintings)
    if(exist([addr_feature, 'features_style\', paintings{i} , '_tamura_hd.mat'],'file'))
        disp(i);
        continue;
    end
%     paintings{i} = paintings{i}(1:strfind(paintings{i},'.jpg')-1);
    % Load image
    load([addr_feature, 'perpixel_features_style\',paintings{i}, '_tamura_perpixel.mat']);
    % Max value of contrast: 124.78
    Pcrs = Pcrs(3:end-2,3:end-2);
    Pcrs = Pcrs(:);
    Pcon = Pcon(7:end-6,7:end-6);
    Pcon = Pcon(:);
    Pdir = Pdir(:);
    
    % Compute the tamura texture feature histograms
    [hd_crs, hd_con, hd_dir] = tamura_hd(Pcrs, Pcon, Pdir);

    % Save tamura texture feature histograms as files
    save([addr_feature, 'features_style\', paintings{i} , '_tamura_hd.mat'], 'hd_crs', 'hd_con', 'hd_dir');
    disp(i);
end

%------------- END OF CODE --------------