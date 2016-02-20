function [] = hsv_4DPlot( rgb_img )
%HSV_4D Summary of this function goes here
%   Detailed explanation goes here
%   function 'histnd' defined in the folder '..\rgb_extractor'
cla

if (ndims(rgb_img) == 2)
    disp('dim is 2');
    rgb_img = repmat(rgb_img, [1, 1, 3]);
end

rgb_img = double(rgb_img/255);
hsv_img = rgb2hsv(rgb_img);
H = hsv_img(:, :, 1); % Hue image.
S = hsv_img(:, :, 2); % Saturation image.
V = hsv_img(:, :, 3); % Value (intensity) image.
H = H(:); S = S(:); V = V(:);

HSV_hist = histnd(...
        [H(~isnan(H)) S(~isnan(S)) V(~isnan(V))], ...
        [-inf 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 inf]/24, ...
        [-inf 1 2 3 4 5 6 7 inf]/8, ...
        [-inf 1 2 3 4 5 6 7 inf]/8);
HSV_hist = HSV_hist(1:24, 1:8, 1:8);

norm_HSV_hist = HSV_hist ./ numel(H);

tmp = [];
tmp_C = [];

% convert hsc to xyz coordinates
for j = 1:8
    for k = 1:8
        prev_theta = -inf;
        for i=1:24
            theta = floor(i/2)/12*2*pi;
            x = ((j-1+j)/2)/8*cos(theta);
            y = ((j-1+j)/2)/8*sin(theta);
            z = ((k-1+k)/2)/8;
            if(prev_theta == theta)
                tmp(size(tmp,1),4) = tmp(size(tmp,1),4) + norm_HSV_hist(i,j,k);
            elseif(prev_theta ~= theta && i == 24)
                tmp(size(tmp,1)-11,4) = tmp(size(tmp,1)-11,4) + norm_HSV_hist(i,j,k); 
            else 
                tmp = [tmp;x,y,z,norm_HSV_hist(i,j,k)];
                tmp_C = [tmp_C;floor(i/2)/12, ((j-1+j)/2)/8, ((k-1+k)/2)/8];
            end
            prev_theta = theta;
        end
    end
end

X = tmp(:,1); Y = tmp(:,2); Z = tmp(:,3); S = tmp(:,4)*4000;
S(find(S <= 0)) = 1e-10;
C = hsv2rgb(tmp_C);
scatter3(X, Y, Z, S, C, 'filled');    % draw the scatter plot
ax = gca;
%view(40,35);
%ax.XLabel.String = 'R';
ax.XLim = [-1,1];
%ax.YLabel.String = 'G';
ax.YLim = [-1,1];
ax.ZLabel.String = 'V';
ax.ZLim = [0,1];

line_x = [0 0];
line_y = [0 0];
line_z = [0 1];
line(line_x, line_y, line_z, 'Color', 'k', 'LineWidth', 2);

line_x = [0 1];
line_y = [0 0];
line_z = [1 1];
line(line_x, line_y, line_z, 'Color', 'r', 'LineWidth', 2);

line_x = [0 1/2];
line_y = [0 sqrt(3)/2];
line_z = [1 1];
line(line_x, line_y, line_z, 'Color', 'y', 'LineWidth', 2);

line_x = [0 -1/2];
line_y = [0 sqrt(3)/2];
line_z = [1 1];
line(line_x, line_y, line_z, 'Color', 'g', 'LineWidth', 2);

line_x = [0 -1];
line_y = [0 0];
line_z = [1 1];
line(line_x, line_y, line_z, 'Color', 'c', 'LineWidth', 2);

line_x = [0 -1/2];
line_y = [0 -sqrt(3)/2];
line_z = [1 1];
line(line_x, line_y, line_z, 'Color', 'b', 'LineWidth', 2);

line_x = [0 1/2];
line_y = [0 -sqrt(3)/2];
line_z = [1 1];
line(line_x, line_y, line_z, 'Color', 'm', 'LineWidth', 2);

hold on;
r=1;
theta=-pi:0.01:pi;
x=r*cos(theta);
y=r*sin(theta);
plot3(x,y,ones(1,numel(x)),'Color','k', 'LineWidth', 2);

camproj('perspective');
rotate3d on;

end

