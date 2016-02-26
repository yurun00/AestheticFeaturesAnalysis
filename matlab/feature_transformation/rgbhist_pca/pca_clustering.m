% DESCRIPTION: This file applies clustering analysis on the dataset of rgb 
% histograms transformed by PCA in two genres. 
% The misclassification error is used as the metric to describe the 
% diversity between two genres. 
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
% Created: 02/24/2016; Last revision: 02/26/2016

%------------- BEGIN CODE --------------

clear; clc;

addr_genre = '..\..\..\data\features\rgb_hist\genre\';
addr_glb = '..\..\..\data\global_var\';
genres = load([addr_glb, 'genres.mat']);
genres = genres.genres;

mce = zeros(length(genres), length(genres));
for i = 1:length(genres)
    for j = 1:length(genres)
        if(i < j)
            g1 = genres{i};
            g2 = genres{j};
            
            % Load observations in the feature space and group variable
            fs_grp_in = load([addr_genre,'_pca\',g1,'_',g2,'_pca_feature_space_obs.mat']);
            fs_obs_in = fs_grp_in.fs_obs;
            grp_in = fs_grp_in.grp;
            
            % Hierarchical clustering
            Z = linkage(fs_obs_in,'ward','euclidean');
            c = cluster(Z,'maxclust',2);

            ct = crosstab(c, grp_in);
            mce(i,j) = min(ct(1,1) + ct(2,2),ct(1,2) + ct(2,1))/sum(ct(:));
        end
    end
end

%------------- END OF CODE --------------


