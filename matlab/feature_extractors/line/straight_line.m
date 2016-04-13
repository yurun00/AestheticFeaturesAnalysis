function line_features = straight_line( gimg )
% STRAIGHT_LINE - Find straight lines in intensity image with canny edge 
% detector and the hough transform. The function takes an intensity image I
% as its input, and returns the 5x1 vector in which each float number 
% indicates hough ratio, long ratio, mean length, standard deviation of
% lengths and maximum length all the detected straight lines.
%
% Syntax: LINES = STRAIGHT_LINE( GRAY_IMAGE )
%
% Inputs:
%   gimg    - The intensity image.
%
% Outputs:
%   line_features   - The 4*1 vector of line features include hough ratio, 
%           long ratio, mean length of lines, standard deviation of the 
%           lengths, maximum length of lines.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

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
long_ratio = 0;
mean_length = 0;
std_length = 0;
if (~isempty(fieldnames(lines)))
%     figure(1);
%     hold on;
    for k = 1:length(lines)
%         xy = [lines(k).point1; lines(k).point2];
%         plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red'); 
        distance(1,k) = norm(lines(k).point1 - lines(k).point2);
        slope(1,k) = abs(lines(k).theta/90);   
    end
    area = size(BW,1)*size(BW,2);
    hough_ratio = sum(distance)/area;
    long_ratio = sum(sum(distance > 70))/size(distance,2);
    distance = distance./max(size(BW,1),size(BW,2));
    mean_length = mean(distance);
    std_length = std(distance);
end
line_features = zeros(5,1);
line_features(1) = hough_ratio;
line_features(2) = long_ratio;
line_features(3) = mean_length;
line_features(4) = std_length;
line_features(5) = max(distance);


%------------- END OF CODE --------------
end

