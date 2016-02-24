function norm_RGB_hist = histogram_rgb( img )
%HISTOGRAM_RGB - Compute the RGB histogram of an image. Each of the R,G,B
%values are divided into 8 intervals. Return the 4D representation of the
%histogram with RGB indicates the 3D position, and circle size indicates 
%the amount of pixels fall in a certain interval.
%
% Syntax: [NORM_RGB_HIST,SCATTER_INPUT] = HISTOGRAM_RGB( IMG );
%
% Inputs:
%   img - Return of the function 'imread'.
%
% Outputs:
%   norm_RGB_hist - Normalized RGB Histogram vector.
%
% Other m-files required: histnd.m
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author: Run Yu
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn 
% Created: 01/20/2016; Last revision: 01/22/2016

%------------- BEGIN CODE --------------
cla
%Check the dimension of the input image
if (ndims(img) == 2)
    disp('dim is 2');
    img = repmat(img, [1, 1, 3]);
end

%Get the R, G, B vectors
R = img(:,:,1); G = img(:,:,2); B = img(:,:,3);
R = R(:); G = G(:); B = B(:);

%Use 'histnd' to compute the RGB histogram
RGB_hist = histnd(...
        [R(~isnan(R)) G(~isnan(G)) B(~isnan(B))], ...
        [-inf 32 64 96 128 160 192 224 inf], ...
        [-inf 32 64 96 128 160 192 224 inf], ...
        [-inf 32 64 96 128 160 192 224 inf]);
RGB_hist = RGB_hist(1:8, 1:8, 1:8);

%Nomalize the RGB histogram and transform it to a vector
norm_RGB_hist = RGB_hist ./ numel(R);
norm_RGB_hist = norm_RGB_hist(:);

end

%------------- END OF CODE --------------

