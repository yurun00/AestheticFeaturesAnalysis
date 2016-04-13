function weight = col_wt( hue, lum )
% col_wt - Extract the color weight feature from hue and luminance
% components of the image in LCH colorspace.
%
% Syntax: WEIGHT = COL_WT( H, L );
%
% Inputs:
%   hue     - Hue value of the pixel in a LCH colorspace image.
%   lum     - luminance value of the pixel in a LCH colorspace image.
%
% Outputs:
%   weight  - The weight of the hue and luminance.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

%------------- BEGIN CODE --------------

hue = hue/180*pi;
% Assume hue values [270,0,180,90]*pi/180 mean colors 
% ['blue','red','green','yellow'] and the corresponding weights are 
% [0.9,0.75,0.5,0.25], the coefficients are computed with polyfit(x,y,3).
fh = -0.0258 * hue^3 + 0.2736 * hue^2 -0.6844 * hue + 0.75;

% Assume hue values [270,0,180,90]*pi/180 mean colors 
% ['blue','red','green','yellow'] and the corresponding weights are 
% [5/6,2/3,1/3,1/6], the coefficients are computed with polyfit(x,y,3).
% fh = -0.0143 * hue^3 + 0.2026 * hue^2 -0.6013 * hue + 0.6667;

% Assume lum values [0;0.5;1] mean luminance intensity 
% ['black';'gray';'white'] and the corresponding weights are 
% [1;0.5;0], the coefficients are computed with fit(x,y,'exp1').
fl = 1.021 * exp(-1.936*lum);

a = 0.5;
b = 0.5;
weight = a*fh + b*fl;
end

%------------- END OF CODE --------------
