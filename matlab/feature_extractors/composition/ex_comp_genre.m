% DESCRIPTION: Extracts the composition features of all paintings in global
% variable 'paintings_by_genre' and save them as '.mat' files. 
% The saliency map should be generated using The SaliencyToolBox downloaded
% from http://www.saliencytoolbox.net/. The saliency maps will be extracted
% and the composition features will be stored.

% Other m-files required: composition.m ..\simpsal\*.m
% Subfunctions: none
% MAT-files required: ..\..\data\global_var\paintings_by_genre.mat
%   ..\..\..\data\paintings_mat\*.mat
%
% See also: simpsal\

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\..\data\global_var\';
addr_mat = '..\..\..\data\paintings_mat\';
addr_feature = '..\..\..\data\features\composition\';

paintings_by_genre = load([addr_glb, 'paintings_by_genre.mat']);
paintings_by_genre = paintings_by_genre.paintings_by_genre;
paintings = paintings_by_genre.values;
paintings = [paintings{:}];

mkdir([addr_feature, 'features_genre\']);
for i = 1:length(paintings)
    if(exist([addr_feature, 'features_genre\', paintings{i} , '_comp.mat'],'file'))
        disp(i);
        continue;
    end
    
    load([addr_mat, paintings{i},'.mat']);
    
    % Check the dimension of the input image
    if (ndims(img) == 2)
        disp('dim is 2');
        img = repmat(img, [1, 1, 3]);
    end
    
    % Calculate composition features
    [~,sa_cv,sa_ecc, sa_re,focus,thirds] = composition(img);
    comp(1)= sa_cv;
    comp(2)= sa_ecc;
    comp(3)= sa_re;
    comp(4:5)= focus(1,1:2);
    comp(6:9)= thirds(1,1:4);

    % Save saliency-related features as files
    save([addr_feature, 'features_genre\', paintings{i} , '_comp.mat'], 'comp');
    disp(i);
end

%------------- END OF CODE --------------