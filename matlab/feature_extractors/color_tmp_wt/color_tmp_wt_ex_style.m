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
addr_feature = '..\..\..\data\features\edge\';

paintings_by_style = load([addr_glb, 'paintings_by_style.mat']);
paintings_by_style = paintings_by_style.paintings_by_style;
paintings = paintings_by_style.values;
paintings = [paintings{:}];

mkdir([addr_feature, 'features_style\']);
thresh = [.2,.3,.4,.6];
for i = 1:length(paintings)
%     if(exist([addr_feature, 'features_style\', paintings{i} , '_edge_ratio.mat'],'file'))
%         continue;
%     end
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
    
    % Compute the edge pixel ratios
    ratios = zeros(4,1);
    [~, ~, ratios(1)] = canny(gimg, thresh(1));
    [~, ~, ratios(2)] = canny(gimg, thresh(2));
    [~, ~, ratios(3)] = canny(gimg, thresh(3));
    [~, ~, ratios(4)] = canny(gimg, thresh(4));

    % Save edge pixel ratios as files
    save([addr_feature, 'features_style\', paintings{i} , '_edge_ratio.mat'], 'ratios');
    disp(i);
end

%------------- END OF CODE --------------