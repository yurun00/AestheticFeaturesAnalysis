%graypicΪ������ĻҶ�ͼƬ
function Fcon=contrast(graypic)
%��ά����һά��
x=graypic(:);
%�Ľ׾�
M4=mean((x-mean(x)).^4);
%����
delta2=var(x,1);
%���
alfa4=M4/(delta2^2);
%��׼��
delta=std(x,1);
%�Աȶ�
Fcon=delta/(alfa4^(1/4));