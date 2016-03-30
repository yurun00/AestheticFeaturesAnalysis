% % blue red green yellow
% x = [270,0,180,90]*pi/180;
% y = [0.9,0.75,0.5,0.25];
% p = polyfit(x,y,3);

% % black gray white
% x = [0;0.5;1];
% y = [1;0.5;0];
% f1 = fit(x,y,'exp1');

% % black blue red gray green yellow white
% % blue red green yellow
% x = [270,0,180,90]*pi/180;
% y = [5/6,2/3,1/3,1/6];
% p = polyfit(x,y,3);
% % p = [-0.0143 0.2026 -0.6013 0.6667]
% 
% % black gray white
% x = [0;0.5;1];
% y = [1;0.5;0];
% f1 = fit(x,y,'exp1');

hue = 0:359;
lum = 0:100;
wt = zeros(36000,3);
i = 1;
for hue = 0:359
    for lum = 0:100
        rad = hue/180*pi;
        wt(i,1) = cos(rad)*lum;
        wt(i,2) = sin(rad)*lum;
        wt(i,3) = col_wt(hue,lum);
        i = i+1;
    end
end
plot3(wt(:,1),wt(:,2),wt(:,3));
rotate3d on;