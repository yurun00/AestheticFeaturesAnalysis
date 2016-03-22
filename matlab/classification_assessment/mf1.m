function [ F1 ] = mf1( grp, plabels )

cm = confusionmat(grp,plabels);
P = cm(1,1)/(cm(1,1)+cm(2,1));
R = cm(1,1)/(cm(1,1)+cm(1,2));
F1 = 2*P*R/(P+R);

end

