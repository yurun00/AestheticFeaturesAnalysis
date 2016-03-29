function [Fcon, Pcon]=contrast(graypic)
% Global contrast
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

% Per-pixel contrast in 13*13 windows
[m,n]=size(graypic);
Pcon = zeros(m,n);
sz = 13;
for i = 1+(sz-1)/2:m-(sz-1)/2
    for j = 1+(sz-1)/2:n-(sz-1)/2
        % 2-D matrix to 1-D vector
        x = graypic(i-(sz-1)/2:i+(sz-1)/2,j-(sz-1)/2:j+(sz-1)/2);
        x = x(:);
        % The fourth moment about the mean
        mu4 = mean((x-mean(x)).^4);
        % The variance
        sigma2 = var(x,1);
        % Measure of polarization
        alpha4 = mu4/(sigma2^2);
        % The standard deviation
        sigma = std(x,1);
        % The contrast
        Pcon(i,j) = sigma/(alpha4^(1/4));
    end
end
