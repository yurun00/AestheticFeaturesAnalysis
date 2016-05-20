% DESCRIPTION:The extracted tamura feature histograms will be classified by
% genres. Then it saves the observations and the groups to '.mat' files for
% clustering analysis.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: ..\..\..\data\global_var\all_genres.mat
%   ..\..\..\data\features\tamura\features_genre\_tamura_hd.mat
%
% See also: none

%------------- BEGIN CODE --------------

clear; clc;

addr_features = '..\..\..\data\features\tamura\features_genre\';
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
            
            % Tamura feature histograms of the first genre
            tamura_hds1 = zeros(length(fid1), 20);
            for m=1:length(fid1)
                % Load features
                load([addr_features, fid1{m}, '_tamura_hd.mat']);

                % Concatenate the tamura feature histograms for PCA input
                tamura_hds1(m,:) = [hd_crs, hd_con, hd_dir];

                grp{m} = s1;
            end
            tmp = length(tamura_hds1);
            
            % Tamura feature histograms of the second genre
            tamura_hds2 = zeros(length(fid2), 20);
            for m=1:length(fid2)
                % Load features
                load([addr_features, fid2{m}, '_tamura_hd.mat']);

                % Concatenate the tamura feature histograms for PCA input
                tamura_hds2(m,:) = [hd_crs, hd_con, hd_dir];

                grp{m+tmp} = s2;
            end

            fs_obs = [tamura_hds1;tamura_hds2];
            
            save([addr_features,'..\obs_grp_genre\',s1,'_',s2,'_obs_grp.mat'],'fs_obs','grp');
        end
    end
end

%------------- END OF CODE --------------