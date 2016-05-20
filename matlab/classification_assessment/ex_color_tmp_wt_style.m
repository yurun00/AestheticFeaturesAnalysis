% DESCRIPTION: The extracted color temperature and weight features of all 
% paintings in global variable 'paintings_by_style' are used as the input 
% of the classifiers. Then it assesses the performance of multiple 
% classifiers.
%
% Other m-files required: cl_knn.m,cl_nb.m,cl_svm.m,cl_tree.m
% Subfunctions: none
% MAT-files required: ..\..\data\global_var\paintings_by_style.mat
%   ..\..\data\features\color_tmp_wt\pca_by_style\*_pca.mat

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\data\global_var\';
addr_obs_grp = '..\..\data\features\color_tmp_wt\obs_grp_style\';
addr_rst = '..\..\data\results\';

paintings_by_style = load([addr_glb, 'paintings_by_style.mat']);
paintings_by_style = paintings_by_style.paintings_by_style;
% paintings = paintings_by_style.values;
% paintings = [paintings{:}];
styles = paintings_by_style.keys;

if(~exist([addr_rst, 'style\'],'dir'))
    mkdir([addr_rst, 'style\']);
end

f1s = zeros(length(styles), length(styles));
for i = 1:length(styles)
    for j = 1:length(styles)
        if(i < j)
            s1 = styles{i};
            s2 = styles{j};
            
            color_pca = load([addr_obs_grp,s1,'_',s2,'_obs_grp.mat']);
            grp = color_pca.grp;
            color_pca = color_pca.fs_obs;
            
%             % Naive Bayes
%             f1s(i,j) = cl_nb(color_pca,grp,s1,s2);

            % K-Nearest Neighbor
            f1s(i,j) = cl_knn(color_pca,grp,10,s1,s2);
            
%             % Support Vector Machine
%             f1s(i,j) = cl_svm(color_pca,grp,'rbf',s1,s2);

%             % Classification Tree
%             f1s(i,j) = cl_tree(color_pca,grp,s1,s2);
        end
    end
end
save([addr_rst,'style\color_tmp_wt_f1_measure.mat'],'f1s');

%------------- END OF CODE --------------