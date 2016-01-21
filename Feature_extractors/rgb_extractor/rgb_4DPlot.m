function [] = rgb_4DPlot( img )
%RGB_4D Summary of this function goes here
%   Detailed explanation goes here
cla

if (ndims(img) == 2)
    disp('dim is 2');
    img = repmat(img, [1, 1, 3]);
end

R = img(:,:,1); G = img(:,:,2); B = img(:,:,3);
R = R(:); G = G(:); B = B(:);

RGB_hist = histnd(...
        [R(~isnan(R)) G(~isnan(G)) B(~isnan(B))], ...
        [-inf 32 64 96 128 160 192 224 inf], ...
        [-inf 32 64 96 128 160 192 224 inf], ...
        [-inf 32 64 96 128 160 192 224 inf]);
RGB_hist = RGB_hist(1:8, 1:8, 1:8);

norm_RGB_hist = RGB_hist ./ numel(R);
norm_RGB_hist = norm_RGB_hist(:);

RGB_axes = [16 48 80 112 144 176 208 240];
[Y, X, Z] = meshgrid(RGB_axes, RGB_axes, RGB_axes);
X = X(:); Y = Y(:); Z = Z(:); 
S = norm_RGB_hist*10000;
S(find(S <= 0)) = 1e-10;
C = [X,Y,Z]/256;
scatter3(X, Y, Z, S, C, 'filled');    % draw the scatter plot
ax = gca;
%view(40,35);
ax.XLabel.String = 'R';
ax.XAxis.Color = 'r';
ax.XLim = [0,256];
ax.YLabel.String = 'G';
ax.YAxis.Color = 'g';
ax.YLim = [0,256];
ax.ZLabel.String = 'B';
ax.ZAxis.Color = 'b';
ax.ZLim = [0,256];

line_x = [0 1 1 0 0 0 1 1]*256;
line_y = [0 0 1 1 0 0 0 0]*256;
line_z = [1 1 1 1 1 0 0 1]*256;
line(line_x, line_y, line_z, 'Color', 'k', 'LineWidth', 2);

line_x = [1 1 1]*256;
line_y = [0 1 1]*256;
line_z = [0 0 1]*256;
line(line_x, line_y, line_z, 'Color', 'k', 'LineWidth', 2);

line_x = [0 0 0]*256;
line_y = [0 1 1]*256;
line_z = [0 0 1]*256;
line(line_x, line_y, line_z, 'Color', 'k', 'LineWidth', 2);

line_x = [1 0]*256;
line_y = [1 1]*256;
line_z = [0 0]*256;
line(line_x, line_y, line_z, 'Color', 'k', 'LineWidth', 2);

camproj('perspective');
rotate3d on;

end

