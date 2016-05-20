% DESCRIPTION: The extracted straight line features of all paintings are 
% compared by styles with mean and standard deviation.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: ..\..\data\global_var\paintings_by_style.mat
%   ..\..\data\features\edge\features_style\*_pca.mat
%   ..\..\data\results\style\edge_f1_measure.mat

%------------- BliIN CODE --------------

clear; clc;

addr_glb = '..\..\data\global_var\';
addr_fts = '..\..\data\features\line\';
addr_rst = '..\..\data\results\';

paintings_by_style = load([addr_glb, 'paintings_by_style.mat']);
paintings_by_style = paintings_by_style.paintings_by_style;
% paintings = paintings_by_style.values;
% paintings = [paintings{:}];
styles = paintings_by_style.keys;
g1 = styles{6};
g2 = styles{8};
fids1 = paintings_by_style(g1);
fids2 = paintings_by_style(g2);
li1 = [];
li2 = [];
for i = 1:length(fids1)
    load([addr_fts,'features_style\',fids1{i},'_lines.mat']);
    li1 = [li1;lines'];
end
for i = 1:length(fids2) 
    load([addr_fts,'features_style\',fids2{i},'_lines.mat']);
    li2 = [li2;lines'];
end
f1 = figure(1);
set(f1, 'Position',  [100,100,400,300]);

m1 = mean(li1);
s1 = std(li1);
m2 = mean(li2);
s2 = std(li2);

p1 = plot([m1(1:4)',m2(1:4)']);
p1(1).LineWidth = 2;
p1(1).Color = [1,0,0];
p1(2).LineWidth = 2;
p1(2).Color = [0,0,1];

title('mean of the straight line features');
legend(['mean',g1],['mean',g2]);
xlabel('straight line features');
ax = gca;
ax.XTick = 1:4;
ax.XTickLabel = {'hough ratio','long ratio','mean length','std length'};

%------------- END OF CODE --------------