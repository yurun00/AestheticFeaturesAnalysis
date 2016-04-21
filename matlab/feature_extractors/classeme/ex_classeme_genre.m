% DESCRIPTION: Extracts the classeme features of all paintings in global 
% variable 'paintings_by_genre' and save them as '.mat' files. 
% The classeme feature
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: ..\..\..\data\global_var\paintings_by_genre.mat
%   ..\..\..\data\paintings_mat\*.mat
%
% See also: none

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\..\data\global_var\';
addr_dat = '..\..\..\data\features\classeme\genre\';
addr_feature = '..\..\..\data\features\classeme\';

paintings_by_genre = load([addr_glb, 'paintings_by_genre.mat']);
paintings_by_genre = paintings_by_genre.paintings_by_genre;
paintings = paintings_by_genre.values;
paintings = [paintings{:}];

mkdir([addr_feature, 'features_genre\']);
for i = 1:length(paintings)
%     if(exist([addr_feature, 'features_genre\', paintings{i} , '_edge_ratio.mat'],'file'))
%         continue;
%     end
    % Load classeme feature data
	classemes = load_float_matrix([addr_dat, paintings{i}, '_classemes.dat']);

    % Save classeme features as files
    save([addr_feature, 'features_genre\', paintings{i} , '_classemes.mat'], 'classemes');
    disp(i);
end

%------------- END OF CODE --------------