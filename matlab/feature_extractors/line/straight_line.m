function line_features = straight_line( gimg )
% STRAIGHT_LINE - Find straight lines in intensity image with canny edge 
% detector and the hough transform. The function takes an intensity image I
% as its input, and returns the 4*1 vector of line features include hough
% ratio, mean length of lines, standard deviation of the lengths, maximum
% length of lines.
%
% Syntax: LINES = STRAIGHT_LINE( GRAY_IMAGE )
%
% Inputs:
%   gimg    - The intensity image.
%
% Outputs:
%   line_features   - The 4*1 vector of line features include hough ratio, 
%       mean length of lines, standard deviation of the lengths, maximum
%       length of lines.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author: Run Yu
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn 
% Created: 04/10/2016; Last revision: 04/10/2016

%------------- BEGIN CODE --------------

BW= edge(gimg,'canny',[0,0.5]);
BW = bwmorph(BW,'dilate');
BW = bwmorph(BW,'thin');

[H,T,R] = hough(BW,'RhoResolution',5,'ThetaResolution',5);

% f1 = figure(1);
% imshow(BW);
% 
% f2= figure(2);
% imshow(H,[],'XData',T,'YData',R,...
%             'InitialMagnification','fit');
% xlabel('\theta'), ylabel('\rho');
% axis on, axis normal, hold on;

P  = houghpeaks(H,9999,'threshold',ceil(0.2*max(H(:))));

% x = T(P(:,2)); y = R(P(:,1));
% plot(x,y,'s','color','white');

% Find lines and plot them
lines = houghlines(BW,T,R,P,'FillGap',3,'MinLength',10);
       
distance = zeros(1,size(lines,2));
slope = zeros(1,size(lines,2));
hough_ratio = 0;
mean_length = 0;
std_length = 0;
% std_slope = 0;
if (~isempty(fieldnames(lines)))
%     figure(1);
%     hold on;
    for k = 1:length(lines)
%         xy = [lines(k).point1; lines(k).point2];
%         plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red'); 
        distance(1,k) = norm(lines(k).point1 - lines(k).point2);
        slope(1,k) = abs(lines(k).theta/90);   
    end
    hough_ratio = sum(distance)/sum(sum(BW));
    mean_length = mean(distance)/sum(sum(BW));
    std_length = std(distance);
%     std_slope = std(slope);
end
line_features = zeros(4,1);
line_features(1) = hough_ratio;
line_features(2) = mean_length;
line_features(3) = std_length;
line_features(4) = max(distance);
% line_features(5) = std_slope;


%------------- END OF CODE --------------
end

