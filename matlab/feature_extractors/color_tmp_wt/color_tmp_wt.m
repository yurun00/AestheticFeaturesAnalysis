function [temperature, weight] = color_tmp_wt( img)
% COLOR_TMP_WT - Calculate the color temperature and weight of the RGB 
% image.
%
% Syntax: [TEMPERATURE, WEIGHT] = COLOR_TMP_WT( IMG );
%
% Inputs:
%   img    - The RGB image
%
% Outputs:
%   temperature     - The visual temperature feature of the image 
%       This is a five dimensional vector with the first element represents
%       the glocal visual temperature feature and the others represent 
%       local features of the segmented image regions.
%   weight          - The visual weight feature of the image 
%       This is a five dimensional vector with the first element represents
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
% lab_img = rgb2lab(img);
% cform = makecform('lab2lch');
% lch_img = applycform(lab_img, cform);
lch_img = colorspace('RGB->LCH',img);

% Get the L, C, H vectors
L = lch_img(:, :, 1); % Lightness image.
% C = lch_img(:, :, 2); % Chroma (Saturation) image.
H = lch_img(:, :, 3); % Hue image.
% seg_img = lch_img;
% seg_img(:,:,1) = 100;
% seg_img(:,:,2) = 100;% sqrt(2)*128;
% seg_img(:,:,3) = ((H >= 0) + (H < 120) - 1) * 60 + ...
%     ((H >= 120) + (H < 240) - 1) * 180 + ...
%     ((H >= 240) + (H < 360) - 1) * 300;

% Four local regions
seg_img = zeros(size(H)) + ((H >= 45) + (H < 135) - 1) * 90 + ...
    ((H >= 135) + (H < 225) - 1) * 180 + ...
    ((H >= 225) + (H < 315) - 1) * 270;

% Show the segmented image
% cform = makecform('lch2lab');
% seg_img = applycform(seg_img, cform);
% imshow(lab2rgb(seg_img));

global_tmp = arrayfun(@hue_tmp, H);
seg1_tmp = global_tmp; seg1_tmp(seg_img ~= 0) = 0;
seg2_tmp = global_tmp; seg2_tmp(seg_img ~= 90) = 0;
seg3_tmp = global_tmp; seg3_tmp(seg_img ~= 180) = 0;
seg4_tmp = global_tmp; seg4_tmp(seg_img ~= 270) = 0;

temperature = zeros(5,1);
temperature(1) = sum(sum(global_tmp))/numel(global_tmp);
if(sum(sum(seg_img == 0)) == 0)
    temperature(2) = 0;
else
    temperature(2) = sum(sum(seg1_tmp))/sum(sum(seg_img == 0));
end
if(sum(sum(seg_img == 90)) == 0)
    temperature(3) = 0;
else
    temperature(3) = sum(sum(seg2_tmp))/sum(sum(seg_img == 90));
end
if(sum(sum(seg_img == 180)) == 0)
    temperature(4) = 0;
else
    temperature(4) = sum(sum(seg3_tmp))/sum(sum(seg_img == 180));
end
if(sum(sum(seg_img == 270)) == 0)
    temperature(5) = 0;
else
    temperature(5) = sum(sum(seg4_tmp))/sum(sum(seg_img == 270));
end

global_wt = arrayfun(@col_wt, H, L);
seg1_wt = global_wt; seg1_wt(seg_img ~= 0) = 0;
seg2_wt = global_wt; seg2_wt(seg_img ~= 90) = 0;
seg3_wt = global_wt; seg3_wt(seg_img ~= 180) = 0;
seg4_wt = global_wt; seg4_wt(seg_img ~= 270) = 0;
weight = zeros(5,1);
weight(1) = sum(sum(global_wt))/numel(global_wt);
if(sum(sum(seg_img == 0)) == 0)
    weight(2) = 0;
else
    weight(2) = sum(sum(seg1_wt))/sum(sum(seg_img == 0));
end
if(sum(sum(seg_img == 90)) == 0)
    weight(3) = 0;
else
    weight(3) = sum(sum(seg2_wt))/sum(sum(seg_img == 90));
end
if(sum(sum(seg_img == 180)) == 0)
    weight(4) = 0;
else
    weight(4) = sum(sum(seg3_wt))/sum(sum(seg_img == 180));
end
if(sum(sum(seg_img == 270)) == 0)
    weight(5) = 0;
else
    weight(5) = sum(sum(seg4_wt))/sum(sum(seg_img == 270));
end

%------------- END OF CODE --------------
end