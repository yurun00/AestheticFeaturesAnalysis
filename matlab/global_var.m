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

% Save all genres
addr_genres = '..\data\paintings_classified\genre\'; 
addr_sv = '..\data\global_var\';
genres = dir(addr_genres);
genres = {genres(3:end).name};
save([addr_sv, 'all_genres.mat'], 'genres');

% Save file names of all genres
genre_files = {};
i = 1;
for g = genres(1:end)
    files = dir([addr_genres, g{1}]);
    files = {files(3:end).name};
    genre_files{i} = files;
    i = i+1;
end
paintings_by_genre = containers.Map(genres, genre_files);
save([addr_sv, 'paintings_by_genre.mat'], 'paintings_by_genre');

% Save all styles
addr_styles = '..\data\paintings_classified\style\'; 
styles = dir(addr_styles);
styles = {styles(3:end).name};
save([addr_sv, 'all_styles.mat'], 'styles');

% Save file names of all styles
style_files = {};
i = 1;
for s = styles(1:end)
    files = dir([addr_styles, s{1}]);
    files = {files(3:end).name};
    style_files{i} = files;
    i = i+1;
end
paintings_by_style = containers.Map(styles, style_files);
save([addr_sv, 'paintings_by_style.mat'], 'paintings_by_style');

% Save all artists
addr_artists = '..\data\paintings_classified\artist\'; 
artists = dir(addr_artists);
artists = {artists(3:end).name};
save([addr_sv, 'all_artists.mat'], 'artists');

% Save file names of all artists
artist_files = {};
i = 1;
for a = artists(1:end)
    files = dir([addr_artists, a{1}]);
    files = {files(3:end).name};
    artist_files{i} = files;
    i = i+1;
end
paintings_by_artist = containers.Map(artists, artist_files);
save([addr_sv, 'paintings_by_artist.mat'], 'paintings_by_artist');


%------------- END OF CODE --------------