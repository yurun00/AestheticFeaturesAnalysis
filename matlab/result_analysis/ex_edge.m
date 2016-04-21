% DESCRIPTION: The extracted edge pixel ratio features of all paintings are 
% compared by styles with mean and standard deviation.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: ..\..\data\global_var\paintings_by_style.mat
%   ..\..\data\features\edge\features_style\*_pca.mat
%   ..\..\data\results\style\edge_f1_measure.mat

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\data\global_var\';
addr_fts = '..\..\data\features\edge\';
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
eg1 = [];
eg2 = [];
for i = 1:length(fids1)
    load([addr_fts,'features_style\',fids1{i},'_edge_ratio.mat']);
    eg1 = [eg1;ratios'];
end
for i = 1:length(fids2) 
    load([addr_fts,'features_style\',fids2{i},'_edge_ratio.mat']);
    eg2 = [eg2;ratios'];
end
f1 = figure(1);
set(f1, 'Position',  [100,100,600,500]);

m1 = mean(eg1);
s1 = std(eg1);
m2 = mean(eg2);
s2 = std(eg2);

p1 = plot([m1',s1',m2',s2']);
p1(1).LineWidth = 2;
p1(1).Color = [1,0,0];
p1(2).LineWidth = 2;
p1(2).Color = [0.6,1,1];
p1(3).LineWidth = 2;
p1(3).Color = [0,0,1];
p1(4).LineWidth = 2;
p1(4).Color = [1,1,0.6];

title('mean and standard deviation of edge pixel ratios');
legend(['mean',g1],['standard deviation ',g1],['mean',g2],['standard deviation ',g2]);
xlabel('edge pixel ratios');
ax = gca;
ax.XTick;

%------------- END OF CODE --------------