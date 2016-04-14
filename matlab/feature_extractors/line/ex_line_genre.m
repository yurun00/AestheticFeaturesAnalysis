% DESCRIPTION:Extracts the straight line features of all paintings in 
% global variable 'paintings_by_genre' and save them as '.mat' files. 
% The straight line feature is a 5x1 vector in which each float number 
% indicates hough ratio, long ratio, mean length, standard deviation of
% lengths and maximum length all the detected straight lines.
% Canny edge detector and Hough transform are used to find straight lines 
% that are longer than 10 pixels.
%
% Other m-files required: straight_line.m
% Subfunctions: none
% MAT-files required: ..\..\..\data\global_var\paintings_by_genre.mat
%   ..\..\..\data\paintings_mat\*.mat
%
% See also: none

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\..\data\global_var\';
addr_mat = '..\..\..\data\paintings_mat\';
addr_feature = '..\..\..\data\features\line\';

paintings_by_genre = load([addr_glb, 'paintings_by_genre.mat']);
paintings_by_genre = paintings_by_genre.paintings_by_genre;
paintings = paintings_by_genre.values;
paintings = [paintings{:}];

mkdir([addr_feature, 'features_genre\']);
for i = 1:length(paintings)
%     if(exist([addr_feature, 'features_genre\', paintings{i} , '_lines.mat'],'file'))
%         continue;
%     end
    % Load image
    img_in = load([addr_mat, paintings{i}, '.mat']);
    img_in = img_in.img;
    
    % Check the dimension of the input image
    if (ndims(img_in) == 2)
        disp('dim is 2');
        img_in = repmat(img_in, [1, 1, 3]);
    end
    gimg = rgb2gray(img_in);
    
    % Compute the straight line features
    lines = straight_line(gimg);

    % Save edge pixel ratios as files
    save([addr_feature, 'features_genre\', paintings{i} , '_lines.mat'], 'lines');
    disp(i);
end

%------------- END OF CODE --------------