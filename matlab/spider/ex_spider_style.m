% DESCRIPTION: Extracts the radar maps of features classification 
% efficiency between every two styles in global variable 
% 'paintings_by_style' and save them as '.mat' files. 
%
% Other m-files required: spider_style
% Subfunctions: none
% MAT-files required: ..\..\data\global_var\paintings_by_style.mat
%   ..\..\..\data\paintings_mat\*.mat
%
% See also: none

%------------- BEGIN CODE --------------

clear all; clc;

addr_glb = '..\..\data\global_var\';
addr_rst = '..\..\data\results\spider_style\';

styles = load([addr_glb, 'all_styles.mat']);
styles = styles.all_styles;

for i = 1:length(styles)
    for j = 1:length(styles)
        if(i < j)
            sp = spider_style(styles{i},styles{j});
            set(sp, 'visible', 'off');
            saveas(sp, [addr_rst,styles{i},'_',styles{j},'.jpg']);
        end
    end
end

%------------- END OF CODE --------------