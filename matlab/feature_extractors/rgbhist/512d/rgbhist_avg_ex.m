% DESCRIPTION: The extracted 4D rgb histogram data from the genre director 
% in '..\..\..\..\data\features\paintings_classified\genre\' and calculate 
% the average rgb histogram for each genre. Save them as '.mat' files. 
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: ..\..\..\..\data\global_var\all_genres.mat
%
% See also: none

%------------- BEGIN CODE --------------

clear; clc;

addr_feature = '..\..\..\..\data\features\rgb_hist\512d\genre\';
addr_glb = '..\..\..\..\data\global_var\';
genres = load([addr_glb, 'all_genres.mat']);
genres = genres.genres;

for g = genres(1:end)
    files = dir([addr_feature, g{1}, '\*_rgbhist.mat']);
    avg_rgbhist = zeros(512,1);
    for i=1:length(files)
        name_len = strfind(files(i).name,'_rgbhist.mat')-1;
        % Load rgb histograms
        rgbhist_in = load([addr_feature, g{1}, '\', ...
            files(i).name(1:name_len), '_rgbhist.mat']);
        rgbhist_in = rgbhist_in.rgbhist;

        % Accumulate the rgb histograms
        avg_rgbhist = avg_rgbhist + rgbhist_in;
    end
    avg_rgbhist = avg_rgbhist/length(files);
    % Save RGB histogram as files
    save([addr_feature, '_avg_rgbhist\', g{1}, '_avg_rgbhist.mat'],'avg_rgbhist');
    disp(g{1});
    % Save the rgb histogram 3D pictures
    scatter3_rgb(avg_rgbhist);
    print([addr_feature, '_avg_rgbhist\', g{1}, '_avg_rgbhist'], '-djpeg');
end

%------------- END OF CODE --------------