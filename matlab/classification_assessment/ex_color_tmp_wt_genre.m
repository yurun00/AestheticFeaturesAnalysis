% DESCRIPTION: The extracted color temperature and weight features of all 
% paintings in global variable 'paintings_by_genre' are used as the input 
% of the classifiers. Then it assesses the performance of multiple 
% classifiers.
%
% Other m-files required: cl_knn.m,cl_nb.m,cl_svm.m,cl_tree.m
% Subfunctions: none
% MAT-files required: ..\..\data\global_var\paintings_by_genre.mat
%   ..\..\data\features\color_tmp_wt\pca_by_genre\*_pca.mat

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\data\global_var\';
addr_pca = '..\..\data\features\color_tmp_wt\pca_by_genre\';
addr_rst = '..\..\data\results\';

paintings_by_genre = load([addr_glb, 'paintings_by_genre.mat']);
paintings_by_genre = paintings_by_genre.paintings_by_genre;
% paintings = paintings_by_genre.values;
% paintings = [paintings{:}];
genres = paintings_by_genre.keys;

if(~exist([addr_rst, 'genre\'],'dir'))
    mkdir([addr_rst, 'genre\']);
end

f1s = zeros(length(genres), length(genres));
for i = 1:length(genres)
    for j = 1:length(genres)
        if(i < j)
            s1 = genres{i};
            s2 = genres{j};
            
            color_pca = load([addr_pca,s1,'_',s2,'_pca.mat']);
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
save([addr_rst,'genre\color_tmp_wt_f1_measure.mat'],'f1s');

%------------- END OF CODE --------------