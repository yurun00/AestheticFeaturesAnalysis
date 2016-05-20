% DESCRIPTION:The extracted HSV histogram 
% features will be classified by genres. Then it saves the transformed 
% observations in feature space to '.mat' files for clustering analysis.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: ..\..\..\data\global_var\all_genres.mat
%   ..\..\..\data\features\hsv_hist\features_genre\*_hsv_hist24d.mat
%
% See also: none

%------------- BEGIN CODE --------------

clear; clc;

addr_features = '..\..\..\data\features\hsv_hist\features_genre\';
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
            
            % HSV histograms of the first genre
            hsvhds1 = zeros(length(fid1), 24);
            for m=1:length(fid1)
                % Load features
                hsvhd = load([addr_features, fid1{m}, '_hsv_hist24d.mat']);
                hsvhd = hsvhd.hsv_hist;

                % Concatenate the HSV histograms for PCA input
                hsvhds1(m,:) = hsvhd(:)';

                grp{m} = s1;
            end
            tmp = length(hsvhds1);
            
            % HSV histograms of the second genre
            hsvhds2 = zeros(length(fid2), 24);
            for m=1:length(fid2)
                % Load features
                hsvhd = load([addr_features, fid2{m}, '_hsv_hist24d.mat']);
                hsvhd = hsvhd.hsv_hist;

                % Concatenate the HSV histograms for PCA input
                hsvhds2(m,:) = hsvhd(:)';

                grp{m+tmp} = s2;
            end

            fs_obs = [hsvhds1;hsvhds2];
            
            save([addr_features,'..\obs_grp_genre\',s1,'_',s2,'_obs_grp.mat'],'fs_obs','grp');
        end
    end
end

%------------- END OF CODE --------------