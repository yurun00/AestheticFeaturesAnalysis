%Description: This script extracts the 4D rgb histogram plot from a certain
%directory. Save them as '.jpg' and '.mat' files. 
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author: Run Yu
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn 
% Created: 01/22/2016; Last revision: 01/22/2016

%------------- BEGIN CODE --------------

clear all;

address_jpg = '..\..\data\paintings_classified\genre\landscape\';
address_mat = '..\..\data\paintings_mat\';
address_feature = '..\..\data\features\rgb_hist\genre\landscape\';
files = dir(fullfile(address_jpg,'*.jpg'));

for i=1:length(files)
        name_len = strfind(files(i).name,'.jpg')-1;
        %Load image
        img_in = load(strcat(address_mat,[files(i).name(1:name_len),'.mat']));
        img_in = img_in.img;
        
        %Compute the RGB histogram
        [rgb_hist, scatter_input] = histogram_rgb(img_in);
        
        %Save the RGB histogram 3D pictures
%         scatter3_rgb(scatter_input);
%         print(strcat(address_feature,files(i).name(1:name_len),'_rgb_hist'), '-djpeg');
        
        %Save RGB histogram as files
        save(strcat(address_feature,files(i).name(1:name_len),'_rgb_hist.mat'),'rgb_hist');
        disp(i);
end

%------------- END OF CODE --------------