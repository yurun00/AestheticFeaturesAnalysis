function weight = col_wt( hue, lum )

hue = hue/180*pi;
fh = -0.0258 * hue^3 + 0.2736 * hue^2 -0.6844 * hue + 0.75;
% fh = -0.0143 * hue^3 + 0.2026 * hue^2 -0.6013 * hue + 0.6667;
fl = 1.021 * exp(-1.936*lum);
a = 0.5;
b = 0.5;
weight = a*fh + b*fl;

end

