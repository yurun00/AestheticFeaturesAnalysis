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
g1 = styles{6};
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
set(f1, 'Position',  [100,100,1200,400]);

m1 = mean(hh1);
s1 = std(hh1);
m2 = mean(hh2);
s2 = std(hh2);

subplot(1,3,1);
p1 = bar([m1(1:8)',m2(1:8)'],1.6);
p1(1).FaceColor = [1,0,0];
p1(2).FaceColor = [0,1,0];

title('mean of Hue');
legend(['mean',g1],['mean',g2]);
xlabel('hue');
ax = gca;
ax.XTick = 0:7;

subplot(1,3,2);
p2 = bar([m1(9:16)',m2(9:16)'],1.6);
p2(1).FaceColor = [1,0,0];
p2(2).FaceColor = [0,1,0];

title('mean of saturation');
legend(['mean',g1],['mean',g2]);
xlabel('saturation');
ax = gca;
ax.XTick = 0:7;

subplot(1,3,3);
p3 = bar([m1(17:24)',m2(17:24)'],1.6);
p3(1).FaceColor = [1,0,0];
p3(2).FaceColor = [0,1,0];

title('mean of value');
legend(['mean',g1],['mean',g2]);
xlabel('value');
ax = gca;
ax.XTick = 0:7;

%------------- END OF CODE --------------