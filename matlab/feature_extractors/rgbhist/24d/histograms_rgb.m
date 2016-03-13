function [norm_hist_R, norm_hist_G, norm_hist_B] = histograms_rgb( img )
% HISTOGRAMS_RGB - Compute the RGB histograms of images. Each of the R,G,B
% values are divided into 8 intervals. Return the 3 histograms, each of 
% which represents one of the red, green or blue component histograms.
%
% Syntax: [NORM_HIST_R, NORM_HIST_G, NORM_HIST_B] = HISTOGRAMS_RGB( IMG );
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

% Author: Run Yu
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn 
% Created: 03/12/2016; Last revision: 03/13/2016

%------------- BEGIN CODE --------------

% Clear axes
cla;

% Check the dimension of the input image
if (ndims(img) == 2)
    disp('dim is 2');
    img = repmat(img, [1, 1, 3]);
end

% Get the R, G, B vectors
R = img(:,:,1); G = img(:,:,2); B = img(:,:,3);
R = R(:); G = G(:); B = B(:);

% % Calculate the RGB histograms
% hist_R = zeros(256,1);
% hist_G = zeros(256,1);
% hist_B = zeros(256,1);
% for i = 1:256
%     hist_R(i) = numel(find(R == i-1));
%     hist_G(i) = numel(find(G == i-1));
%     hist_B(i) = numel(find(B == i-1));
% end

% Use 'histnd' to compute the RGB histogram
RGB_hist = histnd(...
        [R(~isnan(R)) G(~isnan(G)) B(~isnan(B))], ...
        [-inf 32 64 96 128 160 192 224 inf], ...
        [-inf 32 64 96 128 160 192 224 inf], ...
        [-inf 32 64 96 128 160 192 224 inf]);
RGB_hist = RGB_hist(1:8, 1:8, 1:8);

% Calculate RGB histograms seperately
hist_R = zeros(8,1);
hist_G = zeros(8,1);
hist_B = zeros(8,1);
for i = 1:8
    r = RGB_hist(i,:,:);
    hist_R(i) = sum(r(:));
    g = RGB_hist(:,i,:);
    hist_G(i) = sum(g(:));
    b = RGB_hist(:,:,i);
    hist_B(i) = sum(b(:));
end

% Nomalize the RGB histograms 
norm_hist_R = hist_R ./numel(R);
norm_hist_G = hist_G ./numel(G);
norm_hist_B = hist_B ./numel(B);

% % Calculate mean values for intervals of the length 32
% L = 32;
% nh_r = zeros(8,1);
% mx_r = max(norm_hist_R);
% nh_g = zeros(8,1);
% mx_g = max(norm_hist_G);
% nh_b = zeros(8,1);
% mx_b = max(norm_hist_B);
% for i = 1:8
%     nh_r(i) = sum(norm_hist_R((i - 1) * L + 1:i * L)) / (L * mx_r);
%     nh_g(i) = sum(norm_hist_G((i - 1) * L + 1:i * L)) / (L * mx_g);
%     nh_b(i) = sum(norm_hist_B((i - 1) * L + 1:i * L)) / (L * mx_b);
% end
% norm_hist_R = nh_r;
% norm_hist_G = nh_g;
% norm_hist_B = nh_b;

end

%------------- END OF CODE --------------

