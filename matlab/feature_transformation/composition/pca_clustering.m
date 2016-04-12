% DESCRIPTION: This file applies clustering analysis on the dataset of 
% composition features transformed by PCA of two styles. 
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
% Created: 03/29/2016; Last revision: 03/29/2016

%------------- BEGIN CODE --------------

clear; clc;

addr_pca = '..\..\..\data\features\composition\pca_by_style\';
addr_glb = '..\..\..\data\global_var\';
styles = load([addr_glb, 'all_styles.mat']);
styles = styles.all_styles;

mce = zeros(length(styles), length(styles));
for i = 1:length(styles)
    for j = 1:length(styles)
        if(i < j)
            s1 = styles{i};
            s2 = styles{j};
            addr_file = [addr_pca,s1,'_',s2,'_pca.mat'];
            % Load observations in the feature space and group variable
            fs_grp_in = load(addr_file);
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
save([addr_pca,'_mce_pca_clustering.mat'],'mce');

%------------- END OF CODE --------------


