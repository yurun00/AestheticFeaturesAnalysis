function h = scatter3_rgb(norm_rgbhist)
% SCATTER3_RGB - Plot a 3D image with X, Y, Z axes as R, G, B weight and 
% returns the scatter series object. 
% Use h to modify properties of the scatter series after it is created. 
% The size of the circle shows the amount of pixels of the original image 
% which fall in the corresponding interval. 
% The color of the circle shows the R, G, B mixed color of the 
% corresponding interval. 
%
% Syntax:  H = SCATTER3_RGB(NORM_RGBHIST)
%
% Inputs:
%   norm_rgbhist - A 512*1 vector 
%       Normalized RGB Histogram, 
%
% Outputs:
%    h - The scatter series object.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author: Run Yu
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn 
% Created: 01/22/2016; Last revision: 02/26/2016

%------------- BEGIN CODE --------------

%Generate the X, Y, Z coordinates in order(X changes the most fast)
RGB_axes = [16 48 80 112 144 176 208 240];
[Y, X, Z] = meshgrid(RGB_axes, RGB_axes, RGB_axes);
X = X(:); Y = Y(:); Z = Z(:); 

%Adjust the radius of the circle
S = norm_rgbhist * 10000;
S(find(S <= 0)) = 1e-10;

%Normalize the color values
C = [X,Y,Z]/255;

%Draw the 3D rgb histogram
h = scatter3(X, Y, Z, S, C, 'filled');
ax = gca;
ax.XLabel.String = 'R';
ax.XAxis.Color = 'r';
ax.XLim = [0,256];
ax.YLabel.String = 'G';
ax.YAxis.Color = 'g';
ax.YLim = [0,256];
ax.ZLabel.String = 'B';
ax.ZAxis.Color = 'b';
ax.ZLim = [0,256];

%Draw the reference lines
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

%Project with perspective camera and add rotation operation 
camproj('perspective');
rotate3d on;
view(-40,40);

end

%------------- END OF CODE --------------



