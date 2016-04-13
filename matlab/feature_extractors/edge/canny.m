function [bimg, threshs, ratio] = canny( gimg, thresh)
% CANNY - Find edges in intensity image with canny edge detector. The 
% function takes an intensity image I as its input, and returns a binary 
% image |bimg| of the same size as I, with 1's where the function finds 
% edges in I and 0's elsewhere, a 1x2 vector |threshs| to store the real 
% thresholds, a float value |ratio| to store the number of pixels that are 
% labeled as an edge relative to the total number of pixels in the 
% intensity image.
%
% Syntax: [BIMG, THRESHS, RATIO] = CANNY( GIMG, THRESH );
%
% Inputs:
%   gimg    - The intensity image.
%   thresh  - The threshold(s) of canny edge detector.
%
% Outputs:
%   bimg    - Binary image with 1's where the function finds edges and 0's 
%           elsewhere
%   threshs - The real thresholds used by the detector.
%   ratio   - Normalized blue histogram vector.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

%------------- BEGIN CODE --------------

[bimg, threshs] = edge(gimg, 'canny', thresh);
ratio = sum(bimg(:))/numel(bimg);
end

%------------- END OF CODE --------------

