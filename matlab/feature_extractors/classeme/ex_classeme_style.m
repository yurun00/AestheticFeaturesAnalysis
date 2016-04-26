% DESCRIPTION: Extracts the classeme features of all paintings in global 
% variable 'paintings_by_style' and save them as '.mat' files. 
% The classeme feature
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: ..\..\..\data\global_var\paintings_by_style.mat
%   ..\..\..\data\paintings_mat\*.mat
%
% See also: none

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\..\data\global_var\';
addr_dat = '..\..\..\data\features\classeme\style\';
addr_feature = '..\..\..\data\features\classeme\';

paintings_by_style = load([addr_glb, 'paintings_by_style.mat']);
paintings_by_style = paintings_by_style.paintings_by_style;
paintings = paintings_by_style.values;
paintings = [paintings{:}];

mkdir([addr_feature, 'features_style\']);
misfiles = {};
for i = 1:length(paintings)
%     if(~exist([addr_dat, paintings{i} , '_classemes.dat'],'file'))
%         misfiles{end+1} = paintings{i};
%         continue;
%     end
    % Load classeme feature data
	classemes = load_float_matrix([addr_dat, paintings{i}, '_classemes.dat']);

    % Save classeme features as files
    save([addr_feature, 'features_style\', paintings{i} , '_classemes.mat'], 'classemes');
    disp(i);
end

%------------- END OF CODE --------------