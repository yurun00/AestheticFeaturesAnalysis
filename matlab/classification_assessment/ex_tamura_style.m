% DESCRIPTION: This file uses the extracted tamura feature histograms of 
% all paintings in global variable 'paintings_by_style' as the input of
% classifiers. Then it assesses the performance of multiple classifiers and
% the efficiency of this feature in classification by style.
%
% Other m-files required: cl_knn.m,cl_nb.m,cl_svm.m,cl_tree.m
% Subfunctions: none
% MAT-files required: ..\..\data\global_var\paintings_by_style.mat
%   ..\..\data\features\tamura\pca_by_style\*_pca.mat

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\data\global_var\';
addr_pca = '..\..\data\features\tamura\pca_by_style\';
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
            
            tamura_pca = load([addr_pca,s1,'_',s2,'_pca.mat']);
            grp = tamura_pca.grp;
            tamura_pca = tamura_pca.fs_obs;
            
%             % Naive Bayes
%             f1s(i,j) = cl_nb(tamura_pca,grp,s1,s2);

            % K-Nearest Neighbor
            f1s(i,j) = cl_knn(tamura_pca,grp,10,s1,s2);
            
%             % Support Vector Machine
%             f1s(i,j) = cl_svm(tamura_pca,grp,'rbf',s1,s2);

%             % Classification Tree
%             f1s(i,j) = cl_tree(tamura_pca,grp,s1,s2);
        end
    end
end
save([addr_rst,'style\tamura_f1_measure.mat'],'f1s');

%------------- END OF CODE --------------