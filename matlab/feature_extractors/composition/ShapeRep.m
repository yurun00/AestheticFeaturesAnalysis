function[eccentricity, rectratio] = ShapeRep(ShapeImg, center)
%Shape image is a binary image with the area of shape represented by 1,
%other area represented by 0
height = size(ShapeImg, 1);
width = size(ShapeImg, 2);
N = sum(sum(ShapeImg));
gy = center(1,1);
gx = center(1,2);
cxx = 0;
cyy = 0;
cxy = 0;
cyx = 0;
for i = 1:height
    for j = 1:width
        cxx = cxx+(j-gx).^2*ShapeImg(i,j);
        cxy = cxy+(j-gx)*(i-gy)*ShapeImg(i,j);
        cyx = cyx+(i-gy)*(j-gx)*ShapeImg(i,j);
        cyy = cyy+(i-gy).^2*ShapeImg(i,j);
    end
end
cxx = cxx/N;
cxy = cxy/N;
cyx = cyx/N;
cyy = cyy/N;
r1 = 0.5*(cxx+cyy+sqrt((cxx+cyy).^2-4*(cxx*cyy-cxy.^2)));
r2 = 0.5*(cxx+cyy-sqrt((cxx+cyy).^2-4*(cxx*cyy-cxy.^2)));
eccentricity = r2/r1;
[x,y]= find(ShapeImg==1);
c = minBoundingBox([x';y']);
% figure;
% hold off,  plot(x,y,'.')
% hold on,   plot(c(1,[1:end 1]),c(2,[1:end 1]),'r');
% axis equal
rectratio = length(y)/(norm(c(:,1)-c(:,2))*norm(c(:,2)-c(:,3)));
% [indy]= find(y>gy);
% [indx]= find(x>gx);
% sasym(1,1) = length(indy)/length(y);
% sasym(1,2) = length(indx)/length(x);
% radius = max(sqrt((y-gy).*(y-gy)+ (x-gx).*(x-gx)));
% cirratio = length(y)/(pi*(radius.^2));