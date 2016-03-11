%graypic为待处理的灰度图片
function Fcon=contrast(graypic)
%二维向量一维化
x=graypic(:);
%四阶矩
M4=mean((x-mean(x)).^4);
%方差
delta2=var(x,1);
%峰度
alfa4=M4/(delta2^2);
%标准差
delta=std(x,1);
%对比度
Fcon=delta/(alfa4^(1/4));