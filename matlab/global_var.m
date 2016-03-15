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
% Created: 02/25/2016; Last revision: 02/25/2016

%------------- BEGIN CODE --------------

addr_sv = '..\data\global_var\';

% Save all paintings names
addr_paintings = '..\data\paintings_mat\';
paintings = dir(addr_paintings);
paintings = {paintings(3:end).name};
for i = 1:length(paintings)
    paintings{i} = paintings{i}(1:strfind(paintings{i},'.mat')-1);
end
save([addr_sv, 'paintings.mat'], 'paintings');


% Save all genres
addr_genres = '..\data\paintings_classified\genre\';
all_genres = dir(addr_genres);
all_genres = {all_genres(3:end).name};
save([addr_sv, 'all_genres.mat'], 'all_genres');

% Save files' names of all genres
genre_files = {};
i = 1;
for g = all_genres(1:end)
    files = dir([addr_genres, g{1}]);
    files = {files(3:end).name};
    for j = 1:length(files)
        files{j} = files{j}(1:strfind(files{j},'.jpg')-1);
    end
    genre_files{i} = files;
    i = i+1;
end
paintings_by_genre = containers.Map(all_genres, genre_files);
save([addr_sv, 'paintings_by_genre.mat'], 'paintings_by_genre');

% Save all styles
addr_styles = '..\data\paintings_classified\style\'; 
all_styles = dir(addr_styles);
all_styles = {all_styles(3:end).name};
% Choose some styles
all_styles = {'Cubism', 'Impressionism', 'Realism', 'Expressionism', 'Romanticism'};
save([addr_sv, 'all_styles.mat'], 'all_styles');

% Save files' names of all styles
style_files = {};
i = 1;
for s = all_styles(1:end)
    files = dir([addr_styles, s{1}]);
    files = {files(3:end).name};
    for j = 1:length(files)
        files{j} = files{j}(1:strfind(files{j},'.jpg')-1);
    end
    style_files{i} = files;
    i = i+1;
end
paintings_by_style = containers.Map(all_styles, style_files);
save([addr_sv, 'paintings_by_style.mat'], 'paintings_by_style');

% Save all artists
addr_artists = '..\data\paintings_classified\artist\'; 
all_artists = dir(addr_artists);
all_artists = {all_artists(3:end).name};
save([addr_sv, 'all_artists.mat'], 'all_artists');

% Save files' names of all artists
artist_files = {};
i = 1;
for a = all_artists(1:end)
    files = dir([addr_artists, a{1}]);
    files = {files(3:end).name};
    for j = 1:length(files)
        files{j} = files{j}(1:strfind(files{j},'.jpg')-1);
    end
    artist_files{i} = files;
    i = i+1;
end
paintings_by_artist = containers.Map(all_artists, artist_files);
save([addr_sv, 'paintings_by_artist.mat'], 'paintings_by_artist');


%------------- END OF CODE --------------