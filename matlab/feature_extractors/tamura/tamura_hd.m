function [norm_hd_crs, norm_hd_con, norm_hd_dir] = tamura_hd( Pcrs, Pcon, Pdir )
% TAMURA_HD - Compute the tamura feature histograms from the per-pixel
% tamura texture features. Each of the per-pixel feature value is divided
% into several intervals.
%
% The per-pixel coarseness value consists of 2,4,8,16. 
%
% The per-pixel contrast value ranges from 0 to 125 (the maximum value in 
% all images) and is divided into 8 intervals from 0 to 128. 
%
% The per-pixel directionality value ranges from 0 to PI and is divided 
% into 8 intervals.
% 
% Three histograms are returned, each of which represents one of the 
% coarseness, contrast or directionality histogram of the image.
%
% Syntax: [CRS, CON, DIR] = TAMURA_HD( PCRS, PCON, PDIR );
%
% Inputs:
%   Pcrs - Per-pixel value of coarseness. 
%   Pcon - Per-pixel value of contrast.
%   Pdir - Per-pixel value of directionality.
%
% Outputs:
%   norm_hist_crs - Normalized coarseness histogram vector.
%   norm_hist_con - Normalized contrast histogram vector.
%   norm_hist_dir - Normalized directionality histogram vector.
%
% Other m-files required: histnd.m
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author: Run Yu
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn 
% Created: 03/29/2016; Last revision: 03/29/2016

%------------- BEGIN CODE --------------

% Use 'histnd' to compute the histogram
% [Pcrs(~isnan(Pcrs)) Pcon(~isnan(Pcon)) Pdir(~isnan(Pdir))],
[hd_crs,~] = histcounts(Pcrs, [-inf 3 6 12 inf]);
[hd_con,~] = histcounts(Pcon, [-inf 1 2 4 8 16 32 64 inf]);
[hd_dir,~] = histcounts(Pdir, [-inf 1 2 3 4 5 6 7 inf]/8*pi);

% Nomalize the HSV histograms 
norm_hd_crs = hd_crs ./numel(Pcrs);
norm_hd_con = hd_con ./numel(Pcon);
norm_hd_dir = hd_dir ./numel(Pdir);

end

%------------- END OF CODE --------------

