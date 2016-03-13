% graypic为待处理的灰度图片，2^kmax为最大窗口
function Fcrs=coarseness(graypic)

kmax=4;
[m,n]=size(graypic);
best=zeros(m,n)-99999;
Sbest=zeros(m,n);

for k=1:kmax
       
    for i=1+2^k:m+1-2^k
        for j=1+2^k:n+1-2^k

                      
            XA=graypic(i-2^(k-1):i+2^(k-1)-1,j-2^k:j-1);
            XB=graypic(i-2^(k-1):i+2^(k-1)-1,j:j+2^k-1);
            XAB=abs(sum(sum(XA-XB)));

            YA=graypic(i-2^k:i-1,j-2^(k-1):j+2^(k-1)-1);
            YB=graypic(i:i+2^k-1,j-2^(k-1):j+2^(k-1)-1);
            YAB=abs(sum(sum(YA-YB)));
            
            maxtotal=(XAB>YAB)*XAB+(XAB<YAB)*YAB;
            maxtotal=maxtotal/2^(2*k);
                    
            if  best(i,j)<maxtotal
                best(i,j)=maxtotal;
                Sbest(i,j)=2^k;
            end

        end 
    end       
end

 Fcrs=mean2(Sbest);
