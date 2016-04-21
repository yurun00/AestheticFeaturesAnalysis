% DESCRIPTION: The extracted classeme features of all paintings in global 
% variable 'paintings_by_genre' as the input of classifiers. Then it
% assesses the performance of multiple classifiers.
%
% Other m-files required: cl_knn.m,cl_nb.m,cl_svm.m,cl_tree.m
% Subfunctions: none
% MAT-files required: ..\..\data\global_var\paintings_by_genre.mat
%   ..\..\data\features\classeme\obs_grp_genre\*_obs_grp.mat

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\data\global_var\';
addr_pca = '..\..\data\features\classeme\pca_by_genre\';
addr_ftr = '..\..\data\features\classeme\obs_grp_genre\';
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
            
            classemes = load([addr_ftr,s1,'_',s2,'_obs_grp.mat']);
            grp = classemes.grp;
            classemes = classemes.fs_obs;
            
%             % Naive Bayes
%             f1s(i,j) = cl_nb(classemes,grp,s1,s2);

            % K-Nearest Neighbor
            f1s(i,j) = cl_knn(classemes,grp,10,s1,s2);
            
%             % Support Vector Machine
%             f1s(i,j) = cl_svm(classemes,grp,'rbf',s1,s2);

%             % Classification Tree
%             f1s(i,j) = cl_tree(classemes,grp,s1,s2);
        end
    end
end
save([addr_rst,'genre\classemes_f1_measure.mat'],'f1s');

%------------- END OF CODE --------------