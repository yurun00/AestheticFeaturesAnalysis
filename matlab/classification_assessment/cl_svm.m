function [ F1 ] = cl_svm( obs, grp, kf, s1, s2 )

% Support Vector Machine
Mdl = fitcsvm(obs,grp,'KernelFunction',kf,'ClassNames',{s1,s2});
CVMdl = crossval(Mdl);

plabels = kfoldPredict(CVMdl);
F1 = mf1(grp,plabels);

end

