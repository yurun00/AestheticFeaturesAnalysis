% DESCRIPTION: This file extracts the color based features of all paintings
% in global variable 'paintings_by_style' and save them as '.mat' files. 
% The color based features include 'visual temperature of color' and
% 'visual weight of color'.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author: Run Yu
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn 
% Created: 03/28/2016; Last revision: 03/28/2016

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\..\data\global_var\';
addr_mat = '..\..\..\data\paintings_mat\';
addr_feature = '..\..\..\data\features\color_tmp_wt\';

paintings_by_style = load([addr_glb, 'paintings_by_style.mat']);
paintings_by_style = paintings_by_style.paintings_by_style;
paintings = paintings_by_style.values;
paintings = [paintings{:}];

mkdir([addr_feature, 'features_style\']);
thresh = [.2,.3,.4,.6];
for i = 1:length(paintings)
    if(exist([addr_feature, 'features_style\', paintings{i} , '_color_tmp_wt.mat'],'file'))
        load([addr_feature, 'features_style\', paintings{i} , '_color_tmp_wt.mat']);
        if(sum(isnan(tmp)) == 0 && sum(isnan(wt)) == 0)
            disp(i);
            continue;
        end
    end
    % Load image
    load([addr_mat, paintings{i}, '.mat']);
    
    % Check the dimension of the input image
    if (ndims(img) == 2)
        disp('dim is 2');
        img = repmat(img, [1, 1, 3]);
    end
    
    % Compute the color temperature and weight
    [tmp, wt] = color_tmp_wt(img);

    % Save color temperature and weight as files
    save([addr_feature, 'features_style\', paintings{i} , '_color_tmp_wt.mat'], 'tmp', 'wt');
    disp(i);
end

%------------- END OF CODE --------------