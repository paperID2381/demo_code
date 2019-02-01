function [X1,W,Aff]=TukeyWLS(X1,X2,W,u)

n=size(X1,2);
nrows_M=2*n;
ncols_M=6;
M=zeros(nrows_M,ncols_M);
B=zeros(nrows_M,1);
for i=1:n
    x1=X2(1,i);
    y1=X2(2,i);
    x2=X1(1,i);
    y2=X1(2,i);
    w1=W(1,i);
    w2=W(2,i);

    M_=[w1*x2, w1*y2, w1*1, 0, 0, 0;
        0, 0, 0, w2*x2, w2*y2, w2*1];
    
    b=[w1*x1;w2*y1];
    row_ini=i*2-1;
    row_end=i*2;
        
    M(row_ini:row_end,:)=M_;
    B(row_ini:row_end,1)=b;
end

Aff=inv(M'*M)*(M'*B);
X1=[Aff(1:2)';Aff(4:5)']*X1+repmat([Aff(3);Aff(6)],1,size(X1,2));
e=[Aff(1:2)';Aff(4:5)']*X1+repmat([Aff(3);Aff(6)],1,size(X1,2))-X2;
E=sqrt(e(1,:).^2+e(2,:).^2);
kRob=median(E);
kRob=u*kRob;

% w(w>kRob)=0;
w=(1-(E./kRob).^2).^2;
w(1-(E./kRob).^2<0)=0;
W=[w;w];

