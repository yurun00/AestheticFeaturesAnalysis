% DESCRIPTION: This file uses the extracted HSV histogram features of 
% all paintings in global variable 'paintings_by_style' as the input of
% classifiers. Then it assesses the performance of multiple classifiers and
% the efficiency of this feature in classification by style.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author: Run Yu
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn 
% Created: 03/23/2016; Last revision: 03/23/2016

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\data\global_var\';
addr_pca = '..\..\data\features\hsv_hist\pca_by_style\';
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
            
            hsvhd_pca = load([addr_pca,s1,'_',s2,'_pca.mat']);
            grp = hsvhd_pca.grp;
            hsvhd_pca = hsvhd_pca.fs_obs;
            
%             % Naive Bayes
%             f1s(i,j) = cl_nb(hsvhd_pca,grp,s1,s2);

            % K-Nearest Neighbor
            f1s(i,j) = cl_knn(hsvhd_pca,grp,10,s1,s2);
            
%             % Support Vector Machine
%             f1s(i,j) = cl_svm(hsvhd_pca,grp,'rbf',s1,s2);

%             % Classification Tree
%             f1s(i,j) = cl_tree(hsvhd_pca,grp,s1,s2);
        end
    end
end
save([addr_rst,'style\hsvhd_f1_measure.mat'],'f1s');

%------------- END OF CODE --------------