function Fcon=contrast(graypic)
% 2-D matrix to 1-D vector
x=graypic(:);
% The fourth moment about the mean
mu4=mean((x-mean(x)).^4);
% The variance
sigma2=var(x,1);
% Measure of polarization
alpha4=mu4/(sigma2^2);
% The standard deviation
sigma=std(x,1);
% The contrast
Fcon=sigma/(alpha4^(1/4));