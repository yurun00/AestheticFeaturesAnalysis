% DESCRIPTION:The extract the classeme features with corresponding genre 
% labels will be classified by genres. Then it saves the transformed 
% observations in feature space to '.mat' files for clustering analysis.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: ..\..\..\data\global_var\all_genres.mat
%   ..\..\..\data\features\classeme\features_genre\*_classemes.mat
%
% See also: none

%------------- BEGIN CODE --------------

clear; clc;

addr_features = '..\..\..\data\features\classeme\features_genre\';
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
            
            % Straight classeme features of the first genre
            classemes1 = zeros(length(fid1), 2659);
            for m=1:length(fid1)
                % Load features
                load([addr_features, fid1{m}, '_classemes.mat']);

                % Concatenate the classeme features for PCA input
                classemes1(m,:) = classemes';

                grp{m} = s1;
            end
            tmp = length(fid1);
            
            % Straight classeme features of the second genre
            classemes2 = zeros(length(fid2), 2659);
            for m=1:length(fid2)
                % Load features
                load([addr_features, fid2{m}, '_classemes.mat']);

                % Concatenate the classeme features for PCA input
                classemes2(m,:) = classemes';

                grp{m+tmp} = s2;
            end

            fs_obs = [classemes1;classemes2];
            
            save([addr_features,'..\obs_grp_genre\',s1,'_',s2,'_obs_grp.mat'],'fs_obs','grp');
        end
    end
end

%------------- END OF CODE --------------