% DESCRIPTION: This file uses the extracted 4D rgb histogram data from the
% genre director in '..\..\..\data\features\rgb_hist\genre\' and calculate 
% the average rgb histogram for each genre. Save them as '.mat' files. 
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author: Run Yu
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn 
% Created: 02/24/2016; Last revision: 02/24/2016

%------------- BEGIN CODE --------------

clear; clc;

addr_feature = '..\..\..\data\features\rgb_hist\genre\';
addr_glb = '..\..\..\data\global_var\';
genres = load([addr_glb, 'genres.mat']);
genres = genres.genres;

for g = genres(1:end)
    files = dir([addr_feature, g{1}, '\*_rgbhist.mat']);
    avg_rgbhist = zeros(512,1);
    for i=1:length(files)
        name_len = strfind(files(i).name,'_rgbhist.mat')-1;
        %Load rgb histograms
        rgbhist_in = load([addr_feature, g{1}, '\', ...
            files(i).name(1:name_len), '_rgbhist.mat']);
        rgbhist_in = rgbhist_in.rgbhist;

        %Accumulate the rgb histograms
        avg_rgbhist = avg_rgbhist + rgbhist_in;
    end
    avg_rgbhist = avg_rgbhist/length(files);
    %Save RGB histogram as files
    save([addr_feature, '_avg_rgbhist\', g{1}, '_avg_rgbhist.mat'],'avg_rgbhist');
    disp(g{1});
    %Save the rgb histogram 3D pictures
    scatter3_rgb(avg_rgbhist);
    print([addr_feature, '_avg_rgbhist\', g{1}, '_avg_rgbhist'], '-djpeg');
end

%------------- END OF CODE --------------