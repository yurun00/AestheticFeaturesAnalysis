% Description: This file is used to classify '.jpg' files by genre and 
% style. The images belong to the same genre or style will be integrated to
% the same directory
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author: Run Yu
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn 
% Created: 04/07/2016; Last revision: 04/07/2016

%------------- BEGIN CODE --------------
clear;clc;
addr_glb = '..\data\global_var\'; 
addr_src = '..\data\oil_used\'; 
addr_tgt = '..\data\paintings_classified\';

styles = load([addr_glb, 'all_styles.mat']);
styles = styles.all_styles;
genres = load([addr_glb, 'all_genres.mat']);
genres = genres.all_genres;

paintings_by_style = load([addr_glb, 'paintings_by_style.mat']);
paintings_by_style = paintings_by_style.paintings_by_style;
paintings_by_genre = load([addr_glb, 'paintings_by_genre.mat']);
paintings_by_genre = paintings_by_genre.paintings_by_genre;

for i = 1:length(styles)
    mkdir([addr_tgt, 'style\', styles{i}]);
    fids = paintings_by_style(styles{i});
    for j = 1:length(fids);
        copyfile([addr_src,fids{j},'.jpg'], [addr_tgt,'style\',styles{i},'\']);
    end
end

for i = 1:length(genres)
    mkdir([addr_tgt, 'genre\', genres{i}]);
    fids = paintings_by_genre(genres{i});
    for j = 1:length(fids);
        copyfile([addr_src,fids{j},'.jpg'], [addr_tgt,'genre\',genres{i},'\']);
    end
end

%------------- END OF CODE --------------