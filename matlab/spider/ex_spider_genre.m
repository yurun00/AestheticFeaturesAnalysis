% DESCRIPTION: Extracts the radar maps of features classification 
% efficiency between every two genres in global variable 
% 'paintings_by_genre' and save them as '.mat' files. 
%
% Other m-files required: spider_genre
% Subfunctions: none
% MAT-files required: ..\..\data\global_var\paintings_by_genre.mat
%   ..\..\..\data\paintings_mat\*.mat
%
% See also: none

%------------- BEGIN CODE --------------

clear all; clc;

addr_glb = '..\..\data\global_var\';
addr_rst = '..\..\data\results\spider_genre\';

genres = load([addr_glb, 'all_genres.mat']);
genres = genres.all_genres;

for i = 1:length(genres)
    for j = 1:length(genres)
        if(i < j)
            sp = spider_genre(genres{i},genres{j});
            set(sp, 'visible', 'off');
            saveas(sp, [addr_rst,genres{i},'_',genres{j},'.jpg']);
        end
    end
end

%------------- END OF CODE --------------