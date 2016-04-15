% DESCRIPTION:The extracted principle components from the RGB histogram 
% features will be classified by genres. Then it saves the transformed 
% observations in feature space to '.mat' files for clustering analysis.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: ..\..\..\data\global_var\all_genres.mat
% ..\..\..\data\features\rgb_hist\features_genre\*_rgb_hist24d.mat
%
% See also: none

%------------- BEGIN CODE --------------

clear; clc;

addr_features = '..\..\..\data\features\rgb_hist\features_genre\';
addr_glb = '..\..\..\data\global_var\';

genres = load([addr_glb, 'all_genres.mat']);
genres = genres.all_genres;
paintings_by_genre = load([addr_glb, 'paintings_by_genre.mat']);
paintings_by_genre = paintings_by_genre.paintings_by_genre;

mkdir([addr_features,'..\pca_by_genre\']);
for i = 1:length(genres)
    for j = 1:length(genres)
        if(i < j)
            s1 = genres{i};
            s2 = genres{j};
            fid1 = paintings_by_genre(s1);
            fid2 = paintings_by_genre(s2);
            
            % Store the categories of the corresponding paintings
            grp = cell(length(fid1) + length(fid2), 1);
            
            % RGB histograms of the first genre
            rgbhds1 = zeros(length(fid1), 24);
            for m=1:length(fid1)
                % Load features
                rgbhd = load([addr_features, fid1{m}, '_rgb_hist24d.mat']);
                rgbhd = rgbhd.rgb_hist;

                % Concatenate the RGB histograms for PCA input
                rgbhds1(m,:) = rgbhd(:)';

                grp{m} = s1;
            end
            tmp = length(rgbhds1);
            
            % RGB histograms of the second genre
            rgbhds2 = zeros(length(fid2), 24);
            for m=1:length(fid2)
                % Load features
                rgbhd = load([addr_features, fid2{m}, '_rgb_hist24d.mat']);
                rgbhd = rgbhd.rgb_hist;

                % Concatenate the RGB histograms for PCA input
                rgbhds2(m,:) = rgbhd(:)';

                grp{m+tmp} = s2;
            end

            obs = [rgbhds1;rgbhds2];
            % cef(matrix): Columns represent eigenvectors
            % ltt(column vector): Eigenvalues in decreasing order
            [cef, scr, ltt] = pca(obs);

            egn = size(ltt, 1);
            % The threshhold determines the dimension of transformed dataset
            g = zeros(egn,1);
            g(1) = ltt(1);
            for k = 2:egn
                g(k) = g(k-1)+ltt(k);
            end
            L = 0;
            for L = 1:egn
                if(g(L)/g(egn) >= 0.95)
                    break;
                end
            end

            % Transform original dataset to feature space
            w = cef(:,1:L);
            fs_obs = obs * w;
            
            save([addr_features,'..\pca_by_genre\',s1,'_',s2,'_pca.mat'],'fs_obs','grp');
        end
    end
end

%------------- END OF CODE --------------