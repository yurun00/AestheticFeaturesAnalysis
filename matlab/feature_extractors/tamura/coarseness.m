function Fcrs=coarseness(graypic)
% |graypic| is the gray-level image. 2^kmax is the maximum size of the
% window
kmax=4;
[m,n]=size(graypic);
Emaxima=zeros(m,n)-99999;
Sbest=zeros(m,n);
t = 0.9;

for k=1:kmax
    for i=1+2^k:m+1-2^k
        for j=1+2^k:n+1-2^k          
            Eh_u=graypic(i-2^(k-1):i+2^(k-1)-1,j-2^k:j-1);
            Eh_d=graypic(i-2^(k-1):i+2^(k-1)-1,j:j+2^k-1);
            Eh=abs(sum(sum(Eh_u-Eh_d)));

            Ev_l=graypic(i-2^k:i-1,j-2^(k-1):j+2^(k-1)-1);
            Ev_r=graypic(i:i+2^k-1,j-2^(k-1):j+2^(k-1)-1);
            Ev=abs(sum(sum(Ev_l-Ev_r)));
            
            Emax=max(Eh,Ev);
            Emax=Emax/2^(2*k);
                    
            if(t*Emaxima(i,j) < Emax)
                Emaxima(i,j)=Emax;
                Sbest(i,j)=2^k;
            end
        end 
    end       
end
 Fcrs=mean2(Sbest);
