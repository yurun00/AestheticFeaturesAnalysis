% DESCRIPTION: The extracted HSV histogram features of all paintings are 
% compared by styles with mean and standard deviation.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: ..\..\data\global_var\paintings_by_style.mat
%   ..\..\data\features\hsv_hist\features_style\*_hsv_hist24d.mat
%   ..\..\data\results\style\hsvhd_f1_measure.mat

%------------- BEGIN CODE --------------

clear; clc;

addr_glb = '..\..\data\global_var\';
addr_fts = '..\..\data\features\hsv_hist\';
addr_rst = '..\..\data\results\';

paintings_by_style = load([addr_glb, 'paintings_by_style.mat']);
paintings_by_style = paintings_by_style.paintings_by_style;
% paintings = paintings_by_style.values;
% paintings = [paintings{:}];
styles = paintings_by_style.keys;
g1 = styles{3};
g2 = styles{7};
fids1 = paintings_by_style(g1);
fids2 = paintings_by_style(g2);
hh1 = [];
hh2 = [];
for i = 1:length(fids1)
    load([addr_fts,'features_style\',fids1{i},'_hsv_hist24d.mat']);
    hh1 = [hh1;hsv_hist(:,1)',hsv_hist(:,2)',hsv_hist(:,3)'];
end
for i = 1:length(fids2) 
    load([addr_fts,'features_style\',fids2{i},'_hsv_hist24d.mat']);
    hh2 = [hh2;hsv_hist(:,1)',hsv_hist(:,2)',hsv_hist(:,3)'];
end
f1 = figure(1);
set(f1, 'Position',  [100,100,1200,500]);

m1 = mean(hh1);
s1 = std(hh1);
m2 = mean(hh2);
s2 = std(hh2);

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

title('mean and standard deviation of hue');
legend(['mean',g1],['standard deviation ',g1],['mean',g2],['standard deviation ',g2]);
xlabel('hue');
ax = gca;
ax.XTick = 0:7;

subplot(1,3,2);
p2 = plot([m1(9:16)',s1(9:16)',m2(9:16)',s2(9:16)']);
p2(1).LineWidth = 2;
p2(1).Color = [1,0,0];
p2(2).LineWidth = 2;
p2(2).Color = [0.6,1,1];
p2(3).LineWidth = 2;
p2(3).Color = [0,0,1];
p2(4).LineWidth = 2;
p2(4).Color = [1,1,0.6];

title('mean and standard deviation of saturation');
legend(['mean',g1],['standard deviation ',g1],['mean',g2],['standard deviation ',g2]);
xlabel('saturation');
ax = gca;
ax.XTick = 0:7;

subplot(1,3,3);
p3 = plot([m1(17:24)',s1(17:24)',m2(17:24)',s2(17:24)']);
p3(1).LineWidth = 2;
p3(1).Color = [1,0,0];
p3(2).LineWidth = 2;
p3(2).Color = [0.6,1,1];
p3(3).LineWidth = 2;
p3(3).Color = [0,0,1];
p3(4).LineWidth = 2;
p3(4).Color = [1,1,0.6];

title('mean and standard deviation of value');
legend(['mean',g1],['standard deviation ',g1],['mean',g2],['standard deviation ',g2]);
xlabel('value');
ax = gca;
ax.XTick = 0:7;

%------------- END OF CODE --------------