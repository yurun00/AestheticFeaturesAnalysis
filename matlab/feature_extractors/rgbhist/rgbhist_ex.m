% DESCRIPTION: This file extracts the 4D rgb histogram plot from a each
% genre directory in '..\..\..\data\paintings_classified\genre\'. Save them
% as '.mat' files. 
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author: Run Yu
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn 
% Created: 01/22/2016; Last revision: 02/24/2016

%------------- BEGIN CODE --------------

clear all; clc;

address_jpg = '..\..\..\data\paintings_classified\genre\';
address_glb = '..\..\..\data\global_var\';
address_mat = '..\..\..\data\paintings_mat\';
address_feature = '..\..\..\data\features\rgb_hist\genre\';
genres = load([address_glb, 'genres.mat']);
genres = genres.genres;

for g = genres(1:end)
    files = dir([address_jpg, g{1}, '\', '*.jpg']);
    mkdir([address_feature, g{1}, '\']);
    for i=1:length(files)
        name_len = strfind(files(i).name,'.jpg')-1;
        %Load image
        img_in = load([address_mat, files(i).name(1:name_len), '.mat']);
        img_in = img_in.img;

        %Compute the RGB histogram
        rgbhist = histogram_rgb(img_in);

        %Save the RGB histogram 3D pictures
%         scatter3_rgb(rgbhist);
%         print(strcat(address_feature,files(i).name(1:name_len),'_rgb_hist'), '-djpeg');

        %Save RGB histogram as files
        save([address_feature, g{1}, '\', files(i).name(1:name_len), '_rgbhist.mat'],'rgbhist');
        disp(i);
    end
end

%------------- END OF CODE --------------