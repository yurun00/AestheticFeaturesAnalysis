function [ F1 ] = cl_knn( obs, grp, k , s1, s2 )

% K-Nearest Neighbor
Mdl = fitcknn(obs,grp,'NumNeighbors',k,'ClassNames',{s1,s2});
CVMdl = crossval(Mdl);
% loss = kfoldLoss(CVMdl);

plabels = kfoldPredict(CVMdl);
F1 = mf1(grp,plabels);

end