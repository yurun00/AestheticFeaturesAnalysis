% DESCRIPTION: The extracted tamura histogram features of all paintings are 
% compared by styles with mean and standard deviation.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: ..\..\data\global_var\paintings_by_style.mat
%   ..\..\data\features\tamura\features_style\*_hsv_hist24d.mat
%   ..\..\data\results\style\hsvhd_f1_measure.mat

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\data\global_var\';
addr_fts = '..\..\data\features\tamura\';
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
tm1 = [];
tm2 = [];
for i = 1:length(fids1)
    load([addr_fts,'features_style\',fids1{i},'_tamura_hd.mat']);
    tm1 = [tm1;hd_con,hd_crs,hd_dir];
end
for i = 1:length(fids2)
    load([addr_fts,'features_style\',fids2{i},'_tamura_hd.mat']);
    tm2 = [tm2;hd_con,hd_crs,hd_dir];
end
f1 = figure(1);
set(f1, 'Position',  [100,100,1200,500]);

m1 = mean(tm1);
s1 = std(tm1);
m2 = mean(tm2);
s2 = std(tm2);

subplot(1,3,1);
p1 = plot([m1(1:8)',s1(1:8)',m2(1:8)',s2(1:8)']);
p1(1).LineWidth = 2;
p1(1).Color = [1,0,0];
p1(2).LineWidth = 2;
p1(2).Color = [0.6,1,1];
p1(3).LineWidth = 2;
p1(3).Color = [0,0,1];
p1(4).LineWidth = 2;
p1(4).Color = [1,1,0.6];

title('mean and standard deviation of contrast');
legend(['mean',g1],['standard deviation ',g1],['mean',g2],['standard deviation ',g2]);
xlabel('contrast');
ax = gca;
ax.XTick = 0:7;

subplot(1,3,2);
p2 = plot([m1(9:12)',s1(9:12)',m2(9:12)',s2(9:12)']);
p2(1).LineWidth = 2;
p2(1).Color = [1,0,0];
p2(2).LineWidth = 2;
p2(2).Color = [0.6,1,1];
p2(3).LineWidth = 2;
p2(3).Color = [0,0,1];
p2(4).LineWidth = 2;
p2(4).Color = [1,1,0.6];

title('mean and standard deviation of coarseness');
legend(['mean',g1],['standard deviation ',g1],['mean',g2],['standard deviation ',g2]);
xlabel('coarseness');
ax = gca;
ax.XTick = 0:3;

subplot(1,3,3);
p3 = plot([m1(13:20)',s1(13:20)',m2(13:20)',s2(13:20)']);
p3(1).LineWidth = 2;
p3(1).Color = [1,0,0];
p3(2).LineWidth = 2;
p3(2).Color = [0.6,1,1];
p3(3).LineWidth = 2;
p3(3).Color = [0,0,1];
p3(4).LineWidth = 2;
p3(4).Color = [1,1,0.6];

title('mean and standard deviation of directionality');
legend(['mean',g1],['standard deviation ',g1],['mean',g2],['standard deviation ',g2]);
xlabel('directionality');
ax = gca;
ax.XTick = 0:7;

%------------- END OF CODE --------------