% RADARPLOT spiderweb or radar plot
% radarPlot(P) Make a spiderweb or radar plot using the columns of P as datapoints.
%  P is the dataset. The plot will contain M dimensions(or spiderweb stems)
%  and N datapoints (which is also the number of columns in P). Returns the
%  axes handle
%
% radarPlot(P, ..., lineProperties) specifies additional line properties to be
% applied to the datapoint lines in the radar plot
%
% h = radarPlot(...) returns the handles to the line objects.
function varargout = radarPlot( P, varargin )

%%% Get the number of dimensions and points
[M, N] = size(P);

%%% Plot the axes
% Radial offset per axis
th = (2*pi/M)*(ones(2,1)*(M:-1:1));
% Axis start and end
r = [0;1]*P';
polar(th,r);

end