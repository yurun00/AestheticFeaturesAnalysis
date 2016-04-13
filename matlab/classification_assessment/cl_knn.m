function F1 = cl_knn( obs, grp, k , s1, s2 )
% cl_knn - Compute the f1 score of the KNN classifier on the observations 
% and groups. This task is a binary classification task with labels |s1| 
% and |s2|.
%
% Syntax: F1 = CL_KNN( OBS, BRP, K, S1, S2 );
%
% Inputs:
%   obs     - The observations matrix. If there are m observations with n 
%           features, then |obs| is a m*n matrix.
%   grp     - The labels of corresponding observations. If there are m 
%           observations, then |grp| is a m*1 cell.
%   k       - The parameter of the KNN classifier.
%   s1      - String vector represents the first category of observations.
%   s2      - String vector represents the second category of observations.
%
% Outputs:
%   F1      - The f1 score of the classification result.

%------------- BEGIN CODE --------------

% K-Nearest Neighbor
Mdl = fitcknn(obs,grp,'NumNeighbors',k,'ClassNames',{s1,s2});
CVMdl = crossval(Mdl);

% loss = kfoldLoss(CVMdl);
plabels = kfoldPredict(CVMdl);
F1 = mf1(grp,plabels);
end

%------------- END OF CODE --------------