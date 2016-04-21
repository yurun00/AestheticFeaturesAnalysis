% DESCRIPTION: The extracted color temperature and weight features of all 
% paintings are compared by styles with mean and standard deviation.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: ..\..\data\global_var\paintings_by_style.mat
%   ..\..\data\features\color_tmp_wt\features_style\*_color_tmp_wt.mat
%   ..\..\data\results\style\color_tmp_wt_f1_measure.mat

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\data\global_var\';
addr_fts = '..\..\data\features\color_tmp_wt\';
addr_rst = '..\..\data\results\';

paintings_by_style = load([addr_glb, 'paintings_by_style.mat']);
paintings_by_style = paintings_by_style.paintings_by_style;
% paintings = paintings_by_style.values;
% paintings = [paintings{:}];
styles = paintings_by_style.keys;
g1 = styles{6};
g2 = styles{7};
fids1 = paintings_by_style(g1);
fids2 = paintings_by_style(g2);
ctw1 = [];
ctw2 = [];
for i = 1:length(fids1)
    load([addr_fts,'features_style\',fids1{i},'_color_tmp_wt.mat']);
    ctw1 = [ctw1;tmp',wt'];
end
for i = 1:length(fids2) 
    load([addr_fts,'features_style\',fids2{i},'_color_tmp_wt.mat']);
    ctw2 = [ctw2;tmp',wt'];
end
f1 = figure(1);
set(f1, 'Position',  [100,100,1200,500]);

m1 = mean(ctw1);
s1 = std(ctw1);
p1 = plot([m1',s1']);
p1(1).LineWidth = 2;
p1(1).Color = [1,0,0];
p1(2).LineWidth = 2;
p1(2).Color = [0.6,0,0];
hold on;

m2 = mean(ctw2);
s2 = std(ctw2);
p2 = plot([m2',s2']);
p2(1).LineWidth = 2;
p2(1).Color = [0,0,1];
p2(2).LineWidth = 2;
p2(2).Color = [0,0,0.6];
hold off;

title('mean and standard deviation');
legend(['mean',g1],['standard deviation ',g1],['mean',g2],['standard deviation ',g2]);
xlabel('color temperature and weight');
ax = gca;
ax.XTickLabel = {'glb', 'red', 'yellow', 'green', 'blue'};
% m2 = mean(ctw2);
% s2 = std(ctw2);
% subplot(1,2,2);
% bar([m2',s2']);
% title(['mean and standard deviation of the',g2,'style']);
% legend('mean','standard deviation');
% xlabel('color temperature and weight');
% ax = gca;
% ax.XTickLabel = {'wt glb', 'red', 'yellow', 'green', 'blue'};

%------------- END OF CODE --------------