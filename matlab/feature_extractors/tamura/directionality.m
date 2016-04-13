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

[h,w] = size(graypic); %��������ľ������ 
GradientH = [-1 0 1;-1 0 1;-1 0 1];
GradientV = [1 1 1;0 0 0;-1 -1 -1];
% GradientH=[1 0 -1;1 0 -1;1 0 -1];
% GradientV=[-1 -1 -1;0 0 0;1 1 1];
%�����ȡ��Ч�������
deltaH = conv2(graypic, GradientH, 'valid');
deltaV = conv2(graypic, GradientV, 'valid');
%����ģ
deltaG = (abs(deltaH)+abs(deltaV))./2;
%��Ч�����С
validH = h-2;
validW = w-2;
%�����ص�ķ���
sita = atan(deltaV./(deltaH+1e-6))+(pi/2);
n = 16;%�Ƕȷָ���Ŀ
t = 12;%�ݶ���ֵ
tmplat = (deltaG >= t);%��ֵ����Ҫ��
Nsita = zeros(1,n);%�洢ָ���������ص����
for k=1:n
    %if sita~=pi/2
     tmpmat = (sita >= (2*k-3)*pi/(2*n)) .* (sita < (2*k-1)*pi/(2*n)) .* tmplat;%��Ҫ�޶��Ƕȷ�Χ
     Nsita(k) = sum(sum(tmpmat));%ָ����Χ�����ص����
    %end
end
HD = Nsita/sum(Nsita(:));%�����Ƕȷ�Χ���ص����
%����ÿ��ͼƬֻ��һ�������ֵ��Ϊ���㷽�����ԭ��
[maxvalue,Pip]=max(HD);
tmp = 1:n;
Fdir = sum(sum((tmp-Pip).^2 .* HD)); %��ʽ��ԭ���иĶ�
end

%------------- END CODE --------------