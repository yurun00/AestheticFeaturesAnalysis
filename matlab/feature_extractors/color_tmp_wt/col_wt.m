function weight = col_wt( hue, lum )

fh = -0.0258 * hue^3 + 0.2736 * hue^2 -0.6844 * hue + 0.75;
fl = 1.021 * e^(-1.936*lum);
a = 0.5;
b = 0.5;
weight = a*fh + b*fl;

end

