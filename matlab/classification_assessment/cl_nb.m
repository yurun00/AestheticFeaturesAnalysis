function [ F1 ] = cl_nb( obs, grp, s1, s2 )

% Naive Bayes
Mdl = fitcnb(obs,grp,'ClassName',{s1,s2});
CVMdl = crossval(Mdl);

plabels = kfoldPredict(CVMdl);
F1 = mf1(grp,plabels);

end

