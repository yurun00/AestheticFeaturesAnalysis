function F1 = mf1( grp, plabels )
% mf1 - Compute the f1 score of classification result |plabels|. The
% ground-truth labels of observations are stored in |grp|.
%
% Syntax: F1 = MF1( LB1, LB );
%
% Inputs:
%   grp     - The labels of corresponding observations. If there are m 
%           observations, then |grp| is a m*1 cell.
%   plabels - Classification result. If there are m observations, then 
%           |plabels| is a m*1 cell.
%
% Outputs:
%   F1      - The f1 score of the classification result.

%------------- BEGIN CODE --------------

cm = confusionmat(grp,plabels);
P = cm(1,1)/(cm(1,1)+cm(2,1));
R = cm(1,1)/(cm(1,1)+cm(1,2));
F1 = 2*P*R/(P+R);
end

%------------- END OF CODE --------------

