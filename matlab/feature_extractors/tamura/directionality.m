function [Fdir,sita]=newdirectionality(graypic)
[h w]=size(graypic); %��������ľ������ 
GradientH=[-1 0 1 -1 0 1 -1 0 1];
GradientV=[ 1 1 1
0 0 0
-1 -1 -1];
%�����ȡ��Ч�������
MHconv=conv2(graypic,GradientH);
MH=MHconv(3:h,3:w);
MVconv=conv2(graypic,GradientV);
MV=MVconv(3:h,3:w);
%����ģ
MG=(abs(MH)+abs(MV))./2;
%��Ч�����С
validH=h-2;
validW=w-2;
%�����ص�ķ���
sita=atan(MV./(MH+1e-6))+(pi/2);
n=16;%�Ƕȷָ���Ŀ
t=12;%�ݶ���ֵ
templat=MG>=t;%��ֵ����Ҫ��
Nsita=zeros(1,n);%�洢ָ���������ص����
for k=1:n
    %if sita~=pi/2
     tempmat=(sita>=(2*k-3)*pi/2/n).*(sita<(2*k-1)*pi/2/n).*templat;%��Ҫ�޶��Ƕȷ�Χ
     Nsita(k)=sum(sum(tempmat));%ָ����Χ�����ص����
    %end
end
HD=Nsita/sum(Nsita(:));%�����Ƕȷ�Χ���ص����
%����ÿ��ͼƬֻ��һ�������ֵ��Ϊ���㷽�����ԭ��
[maxvalue,FIp]=max(HD);
Fdir=0;
for k=1:n
Fdir=Fdir+(k-FIp)^2*HD(k);%��ʽ��ԭ���иĶ�
end