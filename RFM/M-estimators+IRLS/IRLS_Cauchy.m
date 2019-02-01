function [x,Aff,W]=IRLS_Cauchy(x,y,W,iter)
w=W;
for i=1:iter
    [x,W,Aff]=CauchyWLS(x,y,W,5);
    if max(max(abs(w-W)))<0.0001
        break;
    end
    w=W;
end