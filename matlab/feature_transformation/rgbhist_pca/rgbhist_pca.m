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

addr = '..\..\..\data\features\rgb_hist\genre\';
genre_files = dir(addr);
genres = {genre_files(5:end).name};

for g1 = genres{1:end}
    for g2 = genres{1:end}

    end
end

ls = 'landscape';
ptt = 'portrait';
addr_ls_ftr = strcat(addr,ls,'\');
addr_ptt_ftr = strcat(addr,ptt,'\');
rgbhist_mat_ls = dir(fullfile(addr_ls_ftr,'*.mat'));
rgbhist_mat_ptt = dir(fullfile(addr_ptt_ftr,'*.mat'));

% test data
% [123 109 62 104 57 37 44 100 16 28 138 105 159 75 88 164 169 167 149 167]
% [76 70 55 71 55 48 50 66 41 43 82 68 88 58 64 88 89 88 84 88]

% Store the category of corresponding painting's histogram
grp = cell(length(rgbhist_mat_ls) + length(rgbhist_mat_ptt), 1);
addi = 0;

% RGB histogram matrix of landscape images
rgbhist_ls = zeros(length(rgbhist_mat_ls), 512);
for i=1:length(rgbhist_mat_ls)
        name_len = strfind(rgbhist_mat_ls(i).name,'.mat')-1;
        
        %Load rgbhist
        rgbhist_in = load(strcat(addr_ls_ftr,rgbhist_mat_ls(i).name));
        rgbhist_in = rgbhist_in.rgbhist;
        
        %Concatenate the rgbhist for PCA input
        rgbhist_ls(i,:) = rgbhist_in';
        
        grp{i+addi} = 'landscape';
end
addi = addi + length(rgbhist_mat_ls);

%RGB histogram matrix of portrait images
rgbhist_ptt = zeros(length(rgbhist_mat_ptt), 512);
for i=1:length(rgbhist_mat_ptt)
        name_len = strfind(rgbhist_mat_ptt(i).name,'.mat')-1;
        
        %Load rgbhist
        rgbhist_in = load(strcat(addr_ptt_ftr,rgbhist_mat_ptt(i).name));
        rgbhist_in = rgbhist_in.rgbhist;
        
        %Concatenate the rgbhist for PCA input
        rgbhist_ptt(i,:) = rgbhist_in';
        
        grp{i+addi} = 'portrait';
end
addi = addi + length(rgbhist_mat_ptt);

obs = [rgbhist_ls;rgbhist_ptt];

% cef(matrix): Columns represent eigenvectors
% ltt(column vector): Eigenvalues in decreasing order
[cef, scr, ltt] = pca(obs);

% The threshhold determines the dimension of transformed dataset
g = zeros(512,1);
g(1) = ltt(1);
for j = 2:512
    g(j) = g(j-1)+ltt(j);
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

save(strcat(addr,'_pca\',ls,'_',ptt,'_pca_feature_space_obs.mat'),'fs_obs','grp');

%------------- END OF CODE --------------