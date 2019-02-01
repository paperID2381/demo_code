function [rmse, precision, recall, fscore]=Evaluation(x_,x, noise, gt, npt, N)

e=x_-x;
if isnan(x_(1,1))
    rmse=4;
end

E=sqrt(sum(e.^2));
inliers=find(E<noise*2);
[precision, recall,~] = evaluate(gt, inliers,N);
if precision==0
    fscore=0;
else
    fscore=2*precision*recall/(precision+recall);
end

if size(e,1)==2
    rmsex=sqrt((sum(e(1,1:npt).^2))/npt);
    rmsey=sqrt((sum(e(2,1:npt).^2))/npt);
    rmse=sqrt(rmsex^2+rmsey^2);
elseif size(e,1)==3
    rmsex=sqrt((sum(e(1,1:npt).^2))/npt);
    rmsey=sqrt((sum(e(2,1:npt).^2))/npt);
    rmsez=sqrt((sum(e(3,1:npt).^2))/npt);
    rmse=sqrt(rmsex^2+rmsey^2+rmsez.^2);
end

if rmse>2*noise
    rmse=2*noise;
end