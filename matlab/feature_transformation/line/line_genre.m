% DESCRIPTION:The extract the straight line features with corresponding 
% genre labels will be classified by genres. Then it saves the transformed 
% observations in feature space to '.mat' files for clustering analysis.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: ..\..\..\data\global_var\all_genres.mat
%   ..\..\..\data\features\line\features_genre\*_lines.mat
%
% See also: none

%------------- BEGIN CODE --------------

clear; clc;

addr_features = '..\..\..\data\features\line\features_genre\';
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
            
            % Straight line features of the first genre
            lines1 = zeros(length(fid1), 5);
            for m=1:length(fid1)
                % Load features
                load([addr_features, fid1{m}, '_lines.mat']);

                % Concatenate the straight line features for PCA input
                lines1(m,:) = lines;

                grp{m} = s1;
            end
            tmp = length(lines1);
            
            % Straight line features of the second genre
            lines2 = zeros(length(fid2), 5);
            for m=1:length(fid2)
                % Load features
                load([addr_features, fid2{m}, '_lines.mat']);

                % Concatenate the straight line features for PCA input
                lines2(m,:) = lines;

                grp{m+tmp} = s2;
            end

            fs_obs = [lines1;lines2];
            
            save([addr_features,'..\obs_grp_genre\',s1,'_',s2,'_obs_grp.mat'],'fs_obs','grp');
        end
    end
end

%------------- END OF CODE --------------