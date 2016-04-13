function [Fcrs, Sbest] = coarseness(graypic)
% COARSENESS - Compute the coarseness of the gray-level image
%
% Syntax: [F, S] = COARSENESS( GIMG );
%
% Inputs:
%   graypic     - The gray-level image. 
%
% Outputs:
%   Fcrs        - The coarseness of the image.
%   Sbest       - The coarseness of each pixel's neighborhood.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

%------------- BEGIN CODE --------------

% 2^kmax is the maximum size of the window
kmax=4;
[m,n]=size(graypic);
Emaxima=zeros(m,n)-99999;
% Best sizes of windows for pixels
Sbest=zeros(m,n);
t = 0.9;

for k=1:kmax
    % Average values over neighborhoods
    A = zeros(m,n);
    for i = 1+2^(k-1):m+1-2^(k-1)
        for j = 1+2^(k-1):n+1-2^(k-1)
            A(i,j) = sum(sum(graypic(i-2^(k-1):i+2^(k-1)-1, ...
                j-2^(k-1):j+2^(k-1)-1)));
            A(i,j) = A(i,j)/2^(2*k);
        end
    end
    for i = 1+2^k:m+1-2^k
        for j = 1+2^k:n+1-2^k          
            Eh = abs(A(i+2^(k-1),j)-A(i-2^(k-1),j));
            Ev = abs(A(i,j+2^(k-1))-A(i,j-2^(k-1)));
            Emax=max(Eh,Ev);
                    
            if(t*Emaxima(i,j) < Emax)
                Emaxima(i,j)=Emax;
                Sbest(i,j)=2^k;
            end
        end 
    end 
%     for i=1+2^k:m+1-2^k
%         for j=1+2^k:n+1-2^k  
%             Ev_u=graypic(i-2^(k-1):i+2^(k-1)-1,j:j+2^k-1);
%             Ev_d=graypic(i-2^(k-1):i+2^(k-1)-1,j-2^k:j-1);
%             Ev=abs(sum(sum(Ev_u-Ev_d)));
% 
%             Eh_l=graypic(i-2^k:i-1,j-2^(k-1):j+2^(k-1)-1);
%             Eh_r=graypic(i:i+2^k-1,j-2^(k-1):j+2^(k-1)-1);
%             Eh=abs(sum(sum(Eh_l-Eh_r)));
%             
%             Emax=max(Eh,Ev);
%             Emax=Emax/2^(2*k);
%                     
%             if(t*Emaxima(i,j) < Emax)
%                 Emaxima(i,j)=Emax;
%                 Sbest(i,j)=2^k;
%             end
%         end 
%     end       
end
Fcrs=mean2(Sbest);
end

%------------- END CODE --------------
