% DESCRIPTION: The clustering analysis is applied on the dataset of edge
% pixel ratio features transformed by PCA in two styles. 
% The misclassification error is used as the metric to describe the 
% diversity between two styles. 
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: ..\..\..\data\features\edge\pca_by_style\*_pca.mat
%   ..\..\..\data\global_var\all_styles.mat
%
% See also: none

%------------- BEGIN CODE --------------

clear; clc;

addr_pca = '..\..\..\data\features\edge\pca_by_style\';
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


