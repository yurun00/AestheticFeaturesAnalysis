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
set(f1, 'Position',  [100,100,400,300]);

m1 = mean(eg1);
m2 = mean(eg2);

p1 = plot([m1',m2']);
p1(1).LineWidth = 2;
p1(1).Color = [1,0,0];
p1(2).LineWidth = 2;
p1(2).Color = [0,0,1];

title('mean of the edge pixel ratios');
legend(['mean',g1],['mean',g2]);
xlabel('Thresholds of Canny detector');
ax = gca;
ax.XTick = 1:4;
ax.XTickLabel = {'0.2','0.3','0.4','0.6'};

%------------- END OF CODE --------------