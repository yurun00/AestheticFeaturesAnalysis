% DESCRIPTION:This file is used to extract principle components from the
% rgb histograms classified by genres. Then it saves the transformed
% observations in feature space to '.mat' files for clustering analysis.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author: Run Yu, undergraduate, computer science
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn
% Website: none
% Created: 01/28/2016; Last revision: 02/25/2016

%------------- BEGIN CODE --------------

clear all; clc;

addr_genre = '..\..\..\data\features\rgb_hist\genre\';
addr_glb = '..\..\..\data\global_var\';
genres = load([addr_glb, 'genres.mat']);
genres = genres.genres;

for i = 1:length(genres)
    for j = 1:length(genres)
        if(i < j)
            g1 = genres{i};
            g2 = genres{j};
            addr_g1_ftr = strcat(addr_genre,g1,'\');
            addr_g2_ftr = strcat(addr_genre,g2,'\');
            rgbhist_mat_g1 = dir(fullfile(addr_g1_ftr,'*.mat'));
            rgbhist_mat_g2 = dir(fullfile(addr_g2_ftr,'*.mat'));
            
            % Store the category of corresponding painting's histogram
            grp = cell(length(rgbhist_mat_g1) + length(rgbhist_mat_g2), 1);
            addi = 0;
            
            % RGB histogram matrix of landscape images
            rgbhist_g1 = zeros(length(rgbhist_mat_g1), 512);
            for m=1:length(rgbhist_mat_g1)
                %Load rgbhist
                rgbhist_in = load(strcat(addr_g1_ftr,rgbhist_mat_g1(m).name));
                rgbhist_in = rgbhist_in.rgbhist;

                %Concatenate the rgbhist for PCA input
                rgbhist_g1(m,:) = rgbhist_in';

                grp{m+addi} = g1;
            end
            addi = addi + length(rgbhist_mat_g1);
            
            %RGB histogram matrix of portrait images
            rgbhist_g2 = zeros(length(rgbhist_mat_g2), 512);
            for m=1:length(rgbhist_mat_g2)
                %Load rgbhist
                rgbhist_in = load(strcat(addr_g2_ftr,rgbhist_mat_g2(m).name));
                rgbhist_in = rgbhist_in.rgbhist;

                %Concatenate the rgbhist for PCA input
                rgbhist_g2(m,:) = rgbhist_in';

                grp{m+addi} = g2;
            end

            obs = [rgbhist_g1;rgbhist_g2];
            % cef(matrix): Columns represent eigenvectors
            % ltt(column vector): Eigenvalues in decreasing order
            [cef, scr, ltt] = pca(obs);

            % The threshhold determines the dimension of transformed dataset
            g = zeros(512,1);
            g(1) = ltt(1);
            for k = 2:512
                g(k) = g(k-1)+ltt(k);
            end
            l = 0;
            for l = 1:512
                if(g(l)/g(512) >= 0.95)
                    break;
                end
            end

            % Transform original dataset to feature space(512 dimension to L dimension)
            w = cef(:,1:l);
            fs_obs = obs * w;
            
            save(strcat(addr_genre,'_pca\',g1,'_',g2,'_pca_feature_space_obs.mat'),'fs_obs','grp');
        end
    end
end





%------------- END OF CODE --------------