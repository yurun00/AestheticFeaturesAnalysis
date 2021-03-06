% DESCRIPTION: Extracts the 4D rgb histogram scatters from each genre 
% directory in '..\..\..\..\data\paintings_classified\genre\' and save 
% them as '.mat' files. 
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

%------------- BEGIN CODE --------------

clear; clc;

addr_jpg = '..\..\..\..\data\paintings_classified\genre\';
addr_glb = '..\..\..\..\data\global_var\';
addr_mat = '..\..\..\..\data\paintings_mat\';
addr_feature = '..\..\..\..\data\features\rgb_hist\512d\genre\';
genres = load([addr_glb, 'all_genres.mat']);
genres = genres.genres;

for g = genres(1:end)
    files = dir([addr_jpg, g{1}, '\', '*.jpg']);
    mkdir([addr_feature, g{1}, '\']);
    for i=1:length(files)
        name_len = strfind(files(i).name,'.jpg')-1;
        file_name = files(i).name(1:name_len);
        %Load image
        img_in = load([addr_mat, file_name , '.mat']);
        img_in = img_in.img;

        %Compute the RGB histogram
        rgbhist = histogram_rgb(img_in);

        %Save the RGB histogram 3D pictures
%         scatter3_rgb(rgbhist);
%         print(strcat(addr_feature,files(i).name(1:name_len),'_rgb_hist'), '-djpeg');

        %Save RGB histogram as files
        save([addr_feature, g{1}, '\', file_name , '_rgbhist.mat'],'rgbhist');
        disp(i);
    end
end

%------------- END OF CODE --------------