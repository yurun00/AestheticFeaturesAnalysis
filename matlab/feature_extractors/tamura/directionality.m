function [Fdir,sita,HD] = directionality(graypic)
% DIRECTIONALITY - Compute the directionality of the gray-level image
%
% Syntax: [F, P] = CONTRAST( GIMG );
%
% Inputs:
%   graypic     - The gray-level image. 
%
% Outputs:
%   Fdir        - The directionality of the image.
%   sita        - The directionality of each pixel.
%   HD          - The directionality histogram.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

%------------- BEGIN CODE --------------

[h,w] = size(graypic); %两个方向的卷积矩阵 
GradientH = [-1 0 1;-1 0 1;-1 0 1];
GradientV = [1 1 1;0 0 0;-1 -1 -1];
% GradientH=[1 0 -1;1 0 -1;1 0 -1];
% GradientV=[-1 -1 -1;0 0 0;1 1 1];
%卷积，取有效结果矩阵
deltaH = conv2(graypic, GradientH, 'valid');
deltaV = conv2(graypic, GradientV, 'valid');
%向量模
deltaG = (abs(deltaH)+abs(deltaV))./2;
%有效矩阵大小
validH = h-2;
validW = w-2;
%各像素点的方向
sita = atan(deltaV./(deltaH+1e-6))+(pi/2);
n = 16;%角度分割数目
t = 12;%梯度阈值
tmplat = (deltaG >= t);%阈值满足要求
Nsita = zeros(1,n);%存储指定区域像素点个数
for k=1:n
    %if sita~=pi/2
     tmpmat = (sita >= (2*k-3)*pi/(2*n)) .* (sita < (2*k-1)*pi/(2*n)) .* tmplat;%需要限定角度范围
     Nsita(k) = sum(sum(tmpmat));%指定范围内像素点个数
    %end
end
HD = Nsita/sum(Nsita(:));%各个角度范围像素点比例
%假设每幅图片只有一个方向峰值，为计算方便简化了原著
[maxvalue,Pip]=max(HD);
tmp = 1:n;
Fdir = sum(sum((tmp-Pip).^2 .* HD)); %公式与原著有改动
end

%------------- END CODE --------------