% DESCRIPTION: - One line description of what the function or script performs (H1 line)
% Optional file header info (to give more details about the function than in the H1 line)
% Optional file header info (to give more details about the function than in the H1 line)
% Optional file header info (to give more details about the function than in the H1 line)
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
% See also: OTHER_FUNCTION_NAME1,  OTHER_FUNCTION_NAME2

% Author: Run Yu, undergraduate, computer science
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn
% Website: none
% Created: 00/00/0000; Last revision: 00/00/0000

%------------- BEGIN CODE --------------

clear all; clc;

addr = '..\..\..\data\features\rgb_hist\genre\';
ls = 'landscape';
ptt = 'portrait';
fs_grp_in = load(strcat(addr,'_pca\',ls,'_',ptt,'_pca_feature_space_obs.mat'));
fs_in = fs_grp_in.fs_obs;
grp_in = fs_grp_in.grp;

d = pdist(fs_in);
Z = linkage(d,'ward','euclidean');
c = cluster(Z,'maxclust',2);
crosstab(c,grp_in);

%------------- END OF CODE --------------


