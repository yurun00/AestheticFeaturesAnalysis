function [temperature, weight] = color_tmp_wt( img)
% COLOR_TMP_WT - Calculate the color temperature and weight of the RGB image.
%
% Syntax: [TEMPERATURE, WEIGHT] = COLOR_TMP_WT( IMG );
%
% Inputs:
%   img    - The RGB image
%
% Outputs:
%   temperature     - The visual temperature feature of the image 
%       This is a four dimensional vector with the first element represents
%       the glocal visual temperature feature and the others represent 
%       local features of the segmented image regions.
%   weight          - The visual weight feature of the image 
%       This is a four dimensional vector with the first element represents
%       the glocal visual wieght feature and the others represent local 
%       features of the segmented image regions.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author: Run Yu
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn 
% Created: 03/28/2016; Last revision: 03/28/2016

%------------- BEGIN CODE --------------

% Clear axes
cla;

% Check the dimension of the input image
if (ndims(img) == 2)
    disp('dim is 2');
    img = repmat(img, [1, 1, 3]);
end

% -----Segment the image-----
% Convert RGB to LCH
lab_img = rgb2lab(img);
cform = makecform('lab2lch');
lch_img = applycform(lab_img, cform);

% Get the L, C, H vectors
L = lch_img(:, :, 1); % Lightness image.
C = lch_img(:, :, 2); % Chroma (Saturation) image.
H = lch_img(:, :, 3); % Hue image.
seg_img = lch_img;
seg_img(:,:,1) = 100;
seg_img(:,:,2) = sqrt(2)*128;
seg_img(:,:,3) = zeros(size(H)) + ((H >= 45) + (H < 135) - 1) * 90 + ...
    ((H >= 135) + (H < 225) - 1) * 270 + ...
    ((H >= 225) + (H < 315) - 1) * 270;
% seg_img(:,:,3) = ((H >= 0) + (H < 120) - 1) * 60 + ...
%     ((H >= 120) + (H < 240) - 1) * 180 + ...
%     ((H >= 240) + (H < 360) - 1) * 300;
cform = makecform('lch2lab');
seg_img = applycform(seg_img, cform);
imshow(lab2rgb(seg_img));


temperature = 0;
weight = 0;

%------------- END OF CODE --------------
end

