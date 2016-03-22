function [F1 ] = cl_tree( obs, grp, s1, s2 )

% Classification Tree
Mdl = fitctree(obs,grp,'ClassNames',{s1,s2});
CVMdl = crossval(Mdl);

plabels = kfoldPredict(CVMdl);
F1 = mf1(grp,plabels);

end

