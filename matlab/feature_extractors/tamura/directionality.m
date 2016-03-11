function [Fdir,sita]=newdirectionality(graypic)
[h w]=size(graypic); %两个方向的卷积矩阵 
GradientH=[-1 0 1 -1 0 1 -1 0 1];
GradientV=[ 1 1 1
0 0 0
-1 -1 -1];
%卷积，取有效结果矩阵
MHconv=conv2(graypic,GradientH);
MH=MHconv(3:h,3:w);
MVconv=conv2(graypic,GradientV);
MV=MVconv(3:h,3:w);
%向量模
MG=(abs(MH)+abs(MV))./2;
%有效矩阵大小
validH=h-2;
validW=w-2;
%各像素点的方向
sita=atan(MV./(MH+1e-6))+(pi/2);
n=16;%角度分割数目
t=12;%梯度阈值
templat=MG>=t;%阈值满足要求
Nsita=zeros(1,n);%存储指定区域像素点个数
for k=1:n
    %if sita~=pi/2
     tempmat=(sita>=(2*k-3)*pi/2/n).*(sita<(2*k-1)*pi/2/n).*templat;%需要限定角度范围
     Nsita(k)=sum(sum(tempmat));%指定范围内像素点个数
    %end
end
HD=Nsita/sum(Nsita(:));%各个角度范围像素点比例
%假设每幅图片只有一个方向峰值，为计算方便简化了原著
[maxvalue,FIp]=max(HD);
Fdir=0;
for k=1:n
Fdir=Fdir+(k-FIp)^2*HD(k);%公式与原著有改动
end