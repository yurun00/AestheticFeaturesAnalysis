% DESCRIPTION:The extracted color temperature and weight features will be 
% classified by genres. Then it saves the observations and groups to '.mat'
% files for clustering analysis.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: ..\..\..\data\global_var\all_genres.mat
%   ..\..\..\data\global_var\paintings_by_genre.mat
%   ..\..\..\data\features\color_tmp_wt\features_genre\*_color_tmp_wt.mat
%
% See also: none

%------------- BEGIN CODE --------------

clear; clc;

addr_features = '..\..\..\data\features\color_tmp_wt\features_genre\';
addr_glb = '..\..\..\data\global_var\';

genres = load([addr_glb, 'all_genres.mat']);
genres = genres.all_genres;
paintings_by_genre = load([addr_glb, 'paintings_by_genre.mat']);
paintings_by_genre = paintings_by_genre.paintings_by_genre;

mkdir([addr_features,'..\obs_grp_genre\']);
for i = 1:length(genres)
    for j = 1:length(genres)
        if(i < j)
            s1 = genres{i};
            s2 = genres{j};
            fid1 = paintings_by_genre(s1);
            fid2 = paintings_by_genre(s2);
            
            % Store the categories of the corresponding paintings
            grp = cell(length(fid1) + length(fid2), 1);
            
            % Color features of the first genre
            colors1 = zeros(length(fid1), 10);
            for m=1:length(fid1)
                % Load features
                load([addr_features, fid1{m}, '_color_tmp_wt.mat']);

                % Concatenate the color features for PCA input
                colors1(m,:) = [tmp', wt'];
                grp{m} = s1;
            end
            t = length(colors1);
            
            % Color features of the second genre
            colors2 = zeros(length(fid2), 10);
            for m=1:length(fid2)
                % Load features
                load([addr_features, fid2{m}, '_color_tmp_wt.mat']);

                % Concatenate the color features for PCA input
                colors2(m,:) = [tmp', wt'];

                grp{m+t} = s2;
            end

            fs_obs = [colors1;colors2];
            
            save([addr_features,'..\obs_grp_genre\',s1,'_',s2,'_obs_grp.mat'],'fs_obs','grp');
        end
    end
end

%------------- END OF CODE --------------