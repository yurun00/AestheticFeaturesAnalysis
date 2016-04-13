function [norm_hist_H, norm_hist_S, norm_hist_V] = histograms_hsv( img )
% HISTOGRAMS_HSV - Compute the HSV histograms of images. Each of the H,S,V
% values are divided into 8 intervals. Return 3 histograms, each of 
% which represents one of the hue, saturation or value component histograms
%
% Syntax: [NORM_HIST_H, NORM_HIST_S, NORM_HIST_V] = HISTOGRAMS_HSV( IMG );
%
% Inputs:
%   img - Return of the function 'imread'.
%
% Outputs:
%   norm_hist_R - Normalized red histogram vector.
%   norm_hist_G - Normalized green histogram vector.
%   norm_hist_B - Normalized blue histogram vector.
%
% Other m-files required: histnd.m
% Subfunctions: none
% MAT-files required: none
%
% See also: none

%------------- BEGIN CODE --------------

% Clear axes
cla;

% Check the dimension of the input image
if (ndims(img) == 2)
    disp('dim is 2');
    img = repmat(img, [1, 1, 3]);
end

hsv_img = rgb2hsv(img);
% Get the H, S, V vectors
H = hsv_img(:, :, 1); % Hue image.
S = hsv_img(:, :, 2); % Saturation image.
V = hsv_img(:, :, 3); % Value (intensity) image.
H = H(:); S = S(:); V = V(:);

% Use 'histnd' to compute the HSV histogram
HSV_hist = histnd(...
        [H(~isnan(H)) S(~isnan(S)) V(~isnan(V))], ...
        [-inf 1 2 3 4 5 6 7 inf]/8, ...
        [-inf 1 2 3 4 5 6 7 inf]/8, ...
        [-inf 1 2 3 4 5 6 7 inf]/8);
HSV_hist = HSV_hist(1:8, 1:8, 1:8);

% Calculate HSV histograms seperately
hist_H = zeros(8,1);
hist_S = zeros(8,1);
hist_V = zeros(8,1);
for i = 1:8
    h = HSV_hist(i,:,:);
    hist_H(i) = sum(h(:));
    s = HSV_hist(:,i,:);
    hist_S(i) = sum(s(:));
    v = HSV_hist(:,:,i);
    hist_V(i) = sum(v(:));
end

% Nomalize the HSV histograms 
norm_hist_H = hist_H ./numel(H);
norm_hist_S = hist_S ./numel(S);
norm_hist_V = hist_V ./numel(V);

end

%------------- END OF CODE --------------

