% DESCRIPTION: The extracted composition features of all paintings are 
% compared by styles with mean and standard deviation.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: ..\..\data\global_var\paintings_by_style.mat
%   ..\..\data\features\composition\features_style\*_pca.mat
%   ..\..\data\results\style\comp_f1_measure.mat

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\data\global_var\';
addr_fts = '..\..\data\features\composition\';
addr_rst = '..\..\data\results\';

paintings_by_style = load([addr_glb, 'paintings_by_style.mat']);
paintings_by_style = paintings_by_style.paintings_by_style;
% paintings = paintings_by_style.values;
% paintings = [paintings{:}];
styles = paintings_by_style.keys;
g1 = styles{1};
g2 = styles{7};
fids1 = paintings_by_style(g1);
fids2 = paintings_by_style(g2);
cp1 = [];
cp2 = [];
for i = 1:length(fids1)
    load([addr_fts,'features_style\',fids1{i},'_comp.mat']);
    cp1 = [cp1;comp];
end
for i = 1:length(fids2) 
    load([addr_fts,'features_style\',fids2{i},'_comp.mat']);
    cp2 = [cp2;comp];
end
f1 = figure(1);
set(f1, 'Position',  [100,100,1200,500]);

m1 = mean(cp1);
s1 = std(cp1);
m2 = mean(cp2);
s2 = std(cp2);

subplot(1,2,1);
p1 = plot([m1(1:6)',s1(1:6)',m2(1:6)',s2(1:6)']);
p1(1).LineWidth = 2;
p1(1).Color = [1,0,0];
p1(2).LineWidth = 2;
p1(2).Color = [0.6,1,1];
p1(3).LineWidth = 2;
p1(3).Color = [0,0,1];
p1(4).LineWidth = 2;
p1(4).Color = [1,1,0.6];

title('mean and standard deviation of shapes');
legend(['mean',g1],['standard deviation ',g1],['mean',g2],['standard deviation ',g2]);
xlabel('shapes');
ax = gca;
ax.XTickLabel = {'format','sa_cv','sa_ecc','sa_re','focus','focus'};

subplot(1,2,2);
p2 = plot([m1(7:15)',s1(7:15)',m2(7:15)',s2(7:15)']);
p2(1).LineWidth = 2;
p2(1).Color = [1,0,0];
p2(2).LineWidth = 2;
p2(2).Color = [0.6,1,1];
p2(3).LineWidth = 2;
p2(3).Color = [0,0,1];
p2(4).LineWidth = 2;
p2(4).Color = [1,1,0.6];

title('mean and standard deviation of rule of thirds');
legend(['mean',g1],['standard deviation ',g1],['mean',g2],['standard deviation ',g2]);
xlabel('rule of thirds');
ax = gca;
ax.XTick = 1:9;

%------------- END OF CODE --------------