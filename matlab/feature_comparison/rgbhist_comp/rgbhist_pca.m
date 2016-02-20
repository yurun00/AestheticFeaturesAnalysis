%DESCRIPTION:
%
% Syntax:  [output1,output2] = function_name(input1,input2,input3)
%
% Inputs:
%    input1 - Description
%    input2 - Description
%    input3 - Description
%
% Outputs:
%    output1 - Description
%    output2 - Description
%
% Example: 
%    Line 1 of example
%    Line 2 of example
%    Line 3 of example
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
% Created: 01/28/2016; Last revision: 01/31/2016

%------------- BEGIN CODE --------------

clear all; clc;

add_ls_ftr = '..\..\..\data\features\rgb_hist\genre\landscape\';
add_ptt_ftr = '..\..\..\data\features\rgb_hist\genre\portrait\';
rgbhist_mat_ls = dir(fullfile(add_ls_ftr,'*.mat'));
rgbhist_mat_ptt = dir(fullfile(add_ptt_ftr,'*.mat'));

%test data
%[123 109 62 104 57 37 44 100 16 28 138 105 159 75 88 164 169 167 149 167]
%[76 70 55 71 55 48 50 66 41 43 82 68 88 58 64 88 89 88 84 88]

%RGB histogram matrix of landscape images
rgbhist_ls = zeros(length(rgbhist_mat_ls), 512);
for i=1:length(rgbhist_mat_ls)
        name_len = strfind(rgbhist_mat_ls(i).name,'.mat')-1;
        
        %Load rgbhist
        rgbhist_in = load(strcat(add_ls_ftr,rgbhist_mat_ls(i).name));
        rgbhist_in = rgbhist_in.rgbhist;
        
        %Concatenate the rgbhist for PCA input
        rgbhist_ls(i,:) = rgbhist_in';
end
% error('rgbhist_exed');

%cef(matrix): Columns represent eigenvectors
%ltt(column vector): Eigenvalues in decreasing order
% cef = pca(rgbhist_ls);
[cef, scr, ltt] = myPCA(rgbhist_ls);
% error('pca_exed');

% %The threshhold determines the dimension of transformed dataset
% g = zeros(512,1);
% g(1) = ltt(1);
% for j = 2:512
%     g(j) = g(j-1)+ltt(j);
% end
% l = 0;
% for l = 1:512
%     if(g(l)/g(512) >= 0.95)
%         break;
%     end
% end
% 
% %Transform original dataset to feature space(512 dimension to L dimension)
% w = cef(:,1:l);
% fs_rgbhist_ls = rgbhist_ls * w;

%------------- END OF CODE --------------