function F1 = cl_tree( obs, grp, s1, s2 )
% cl_tree - Compute the f1 score of the desicion tree classifier on the 
% observations and groups. This task is a binary classification task with 
% labels |s1| and |s2|.
%
% Syntax: F1 = CL_TREE( OBS, BRP, S1, S2 );
%
% Inputs:
%   obs     - The observations matrix. If there are m observations with n 
%           features, then |obs| is a m*n matrix.
%   grp     - The labels of corresponding observations. If there are m 
%           observations, then |grp| is a m*1 cell.
%   s1      - String vector represents the first category of observations.
%   s2      - String vector represents the second category of observations.
%
% Outputs:
%   F1      - The f1 score of the classification result.

%------------- BEGIN CODE --------------

% Classification Tree
Mdl = fitctree(obs,grp,'ClassNames',{s1,s2});
CVMdl = crossval(Mdl);

plabels = kfoldPredict(CVMdl);
F1 = mf1(grp,plabels);
end

%------------- END OF CODE --------------

