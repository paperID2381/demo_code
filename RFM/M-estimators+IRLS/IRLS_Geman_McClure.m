function [x,Aff,W]=IRLS_Geman_McClure(x,y,W,iter)
w=W;
for i=1:iter
    [x,W,Aff]=GMWLS(x,y,W,1);
    if max(max(abs(w-W)))<0.0001
        break;
    end
    w=W;
end