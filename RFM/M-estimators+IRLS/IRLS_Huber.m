function [x,Aff,W]=IRLS_Huber(x,y,W,iter)
w=W;
for i=1:iter
    [x,W,Aff]=HuberWLS(x,y,W,2);
    if max(max(abs(w-W)))<0.0001
        break;
    end
    w=W;
end