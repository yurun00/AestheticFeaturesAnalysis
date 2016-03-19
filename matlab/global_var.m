% Description: This file is used to extract some global variables.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author: Run Yu
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn 
% Created: 02/25/2016; Last revision: 03/17/2016

%------------- BEGIN CODE --------------

clear;clc;
addr = '..\data\'; 
addr_sv = '..\data\global_var\';

% Save all paintings names
[~,~,raw] = xlsread([addr, 'paintings.xlsx']);
paintings = raw(:,1);
for i = 1:length(paintings)
    paintings{i} = paintings{i}(1:strfind(paintings{i},'.jpg')-1);
end
save([addr_sv, 'paintings.mat'], 'paintings');

% Extract all genres
[~,~,raw] = xlsread([addr, 'paintings_genre.xlsx']);
genres = raw(:,1);
files = raw(:,2);
all_genres = unique(genres);
% Extract files' names of each genre
genre_files = cell(length(all_genres),1);
for i = 1:length(files)
    t = cellfun(@(s)strcmp(genres{i},s),all_genres','UniformOutput', false);
    idx = find(cell2mat(t) == 1);
    genre_files{idx}{end+1} = files{i}(1:strfind(files{i},'.jpg')-1); 
end
% Choose 120 samples from each genre and filt genres with insufficient
% samples
del_genres = [];
for i = 1:length(all_genres)
    if(length(genre_files{i}) > 120)
        genre_files{i} = datasample(genre_files{i},120, 'replace', false);
    else
        if(length(genre_files{i}) < 100)
            del_genres = [del_genres,i];
        end
    end
end
all_genres(del_genres) = [];
genre_files(del_genres) = [];
paintings_by_genre = containers.Map(all_genres, genre_files);
save([addr_sv, 'all_genres.mat'], 'all_genres');
save([addr_sv, 'paintings_by_genre.mat'], 'paintings_by_genre');

% Extract all styles
[~,~,raw] = xlsread([addr, 'paintings_style.xlsx']);
styles = raw(:,1);
files = raw(:,2);
all_styles = unique(styles);
% Extract files' names of each style
style_files = cell(length(all_styles),1);
for i = 1:length(files)
    t = cellfun(@(s)strcmp(styles{i},s),all_styles','UniformOutput', false);
    idx = find(cell2mat(t) == 1);
    style_files{idx}{end+1} = files{i}(1:strfind(files{i},'.jpg')-1); 
end
% Choose 120 samples of each style and filt styles with insufficient
% samples
del_styles = [];
for i = 1:length(all_styles)
    if(length(style_files{i}) > 120)
        style_files{i} = datasample(style_files{i},120, 'replace', false);
    else
        if(length(style_files{i}) < 100)
            del_styles = [del_styles,i];
        end
    end
end
all_styles(del_styles) = [];
style_files(del_styles) = [];
paintings_by_style = containers.Map(all_styles, style_files);
save([addr_sv, 'all_styles.mat'], 'all_styles');
save([addr_sv, 'paintings_by_style.mat'], 'paintings_by_style');

%------------- END OF CODE --------------
