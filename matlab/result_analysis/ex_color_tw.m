% DESCRIPTION: The extracted color temperature and weight features of all 
% paintings are compared by genres with mean and standard deviation.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: ..\..\data\global_var\paintings_by_genre.mat
%   ..\..\data\features\color_tw\features_genre\*_color_tw.mat
%   ..\..\data\results\genre\color_tw_f1_measure.mat

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\data\global_var\';
addr_fts = '..\..\data\features\color_tw\';
addr_rst = '..\..\data\results\';

paintings_by_genre = load([addr_glb, 'paintings_by_genre.mat']);
paintings_by_genre = paintings_by_genre.paintings_by_genre;
% paintings = paintings_by_genre.values;
% paintings = [paintings{:}];
genres = paintings_by_genre.keys;
g1 = genres{2};
g2 = genres{5};
fids1 = paintings_by_genre(g1);
fids2 = paintings_by_genre(g2);
ctw1 = [];
ctw2 = [];
for i = 1:length(fids1)
    load([addr_fts,'features_genre\',fids1{i},'_color_tw.mat']);
    ctw1 = [ctw1;gbcolor,lccolor];
end
for i = 1:length(fids2) 
    load([addr_fts,'features_genre\',fids2{i},'_color_tw.mat']);
    ctw2 = [ctw2;gbcolor,lccolor];
end
f1 = figure(1);
set(f1, 'Position',  [100,100,800,300]);

m1 = mean(ctw1);
m2 = mean(ctw2);
p1 = bar([m1',m2'],1.6);
p1(1).FaceColor = [1,0,0];
p1(2).FaceColor = [0,1,0];

title('mean of color perception features');
legend(['mean',g1],['mean',g2]);
xlabel('color perception features');
ax = gca;
ax.XTick = 1:18;
ax.XTickLabel = {'glb-tmp', 'wt', 'dif-hue', 'lum', 'sat', 'tmp', 'wt', ...
    'lc-tmp1', 'tmp2', 'tmp3', 'wt1', 'wt2', 'wt3', ...
    'dif-hue', 'lum', 'sat', 'tmp', 'wt'};
% m2 = mean(ctw2);
% s2 = std(ctw2);
% subplot(1,2,2);
% bar([m2',s2']);
% title(['mean and standard deviation of the',g2,'genre']);
% legend('mean','standard deviation');
% xlabel('color temperature and weight');
% ax = gca;
% ax.XTickLabel = {'wt glb', 'red', 'yellow', 'green', 'blue'};

%------------- END OF CODE --------------