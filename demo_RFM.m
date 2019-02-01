clc;clear;close all
addpath(genpath('RFM'));
addpath common
npt=50;                     % inlier number
noise=2;                    %  noise level
nTest=50;                   % 50 independent tests (1000 in our paper)

RMSE=cell(1,8);            % RMSE result
Precision=cell(1,8);       % precision result
Recall=cell(1,8);          % recall result
Fscore=cell(1,8);          % F-score result
Time=cell(1,8);          % time result

gt=zeros(1,npt);           % ground truth inliers ID
gt(1,1:npt)=1:npt;

p=0.2;                     % parameters
alpha=1.45;
mu=3e-6;
iter=100;
max_mu=1e10;
stop=1e-5;

for k=1:9
    inlierRate=1-k/10;     % inlier rate from 90% to 10%
    Noutlier=round(npt/inlierRate)-npt;   % number of outliers
    str=['the outlier rate =' num2str(k*10) '%'];
    disp(str);
    for i=1:nTest
        x= [xrand(1,npt+Noutlier,[-500 500]); xrand(1,npt+Noutlier,[-500 500])];    % randomly generate n feature points in image I1
        angle=xrand(1,1,[-pi/2,pi/2]);                                              % randomly generate rotation angle
        R=[cos(angle), -sin(angle); sin(angle), cos(angle)];                        % construct the 2¡Á2 rotation matrix R
        s1=xrand(1,1,[0.7,1.3]);                                                    % randomly generate scale parameters
        s2=xrand(1,1,[0.7,1.3]);
        R(1,:)=R(1,:)*s1;
        R(2,:)=R(2,:)*s2;
        t=mean(x,2);                                                                % randomly generate translation vector t
        y=R*x(:,1:npt)+repmat(t,1,npt);                                             % obtain the ground truth correspondences in image I2
        ymin=min(y(:));
        ymax=max(y(:));
        
        if Noutlier~=0                                                              % add random errors to generate outluers
            youtlier = [xrand(1,Noutlier,[ymin/2 ymax/2]); xrand(1,Noutlier,[ymin/2 ymax/2])];
            y = [y, youtlier];
        end
        n=xrand(2,npt+Noutlier,[-noise,noise]);                % add noise
        y=y+n;
        
        W=ones(2,size(x,2));
        t1=clock;
        [x_,~,~]=IRLS_Huber(y,x,W,50);                    % Huber+IRLS method
        t2=clock;
        time=etime(t2,t1);
        [rmse, precision, recall, fscore]=Evaluation(x_,x, noise, gt,npt, npt+Noutlier);
        RMSE{1,1}(k,i)=rmse;
        Precision{1,1}(k,i)=precision;
        Recall{1,1}(k,i)=recall;
        Fscore{1,1}(k,i)=fscore;
        Time{1,1}(k,i)=time;
        
        t1=clock;
        [x_,~,~]=IRLS_Cauchy(y,x,W,50);        % Cauchy+IRLS method
        t2=clock;
        time=etime(t2,t1);
        [rmse, precision, recall, fscore]=Evaluation(x_,x, noise, gt,npt, npt+Noutlier);
        RMSE{1,2}(k,i)=rmse;
        Precision{1,2}(k,i)=precision;
        Recall{1,2}(k,i)=recall;
        Fscore{1,2}(k,i)=fscore;
        Time{1,2}(k,i)=time;
        
        t1=clock;
        [x_,~,~]=IRLS_Geman_McClure(y,x,W,50);      % Geman_McClure+IRLS method
        t2=clock;
        time=etime(t2,t1);
        [rmse, precision, recall, fscore]=Evaluation(x_,x, noise, gt,npt, npt+Noutlier);
        RMSE{1,3}(k,i)=rmse;
        Precision{1,3}(k,i)=precision;
        Recall{1,3}(k,i)=recall;
        Fscore{1,3}(k,i)=fscore;
        Time{1,3}(k,i)=time;
        
        t1=clock;
        [x_,~,~]=IRLS_Welsch(y,x,W,50);             % Welsch+IRLS method
        t2=clock;
        time=etime(t2,t1);
        [rmse, precision, recall, fscore]=Evaluation(x_,x, noise, gt,npt, npt+Noutlier);
        RMSE{1,4}(k,i)=rmse;
        Precision{1,4}(k,i)=precision;
        Recall{1,4}(k,i)=recall;
        Fscore{1,4}(k,i)=fscore;
        Time{1,4}(k,i)=time;
        
        t1=clock;
        [x_,~,~]=IRLS_tukey(y,x,W,50);       % tukey+IRLS method
        t2=clock;
        time=etime(t2,t1);
        [rmse, precision, recall, fscore]=Evaluation(x_,x, noise, gt,npt, npt+Noutlier);
        RMSE{1,5}(k,i)=rmse;
        Precision{1,5}(k,i)=precision;
        Recall{1,5}(k,i)=recall;
        Fscore{1,5}(k,i)=fscore;
        Time{1,5}(k,i)=time;
        
        t1=clock;
        [Hransac, inlier_ransac] = ransacfithomography(y,x, 0.001);  % RANSAC method
        xtemp=Hransac*[y;ones(1,size(x,2))];
        u=xtemp(1,:)./xtemp(3,:);
        v=xtemp(2,:)./xtemp(3,:);
        x_=[u;v];
        t2=clock;
        time=etime(t2,t1);
        [rmse, precision, recall, fscore]=Evaluation(x_,x, noise, gt,npt, npt+Noutlier);
        RMSE{1,6}(k,i)=rmse;
        Precision{1,6}(k,i)=precision;
        Recall{1,6}(k,i)=recall;
        Fscore{1,6}(k,i)=fscore;
        Time{1,6}(k,i)=time;
        
        t1=clock;
        [Hrransac, inlier_rransac] = rransacfithomography(y,x, 0.001);          % RRANSAC method
        xtemp=Hrransac*[y;ones(1,size(x,2))];
        u=xtemp(1,:)./xtemp(3,:);
        v=xtemp(2,:)./xtemp(3,:);
        x_=[u;v];
        t2=clock;
        time=etime(t2,t1);
        [rmse, precision, recall, fscore]=Evaluation(x_,x, noise, gt,npt, npt+Noutlier);
        RMSE{1,7}(k,i)=rmse;
        Precision{1,7}(k,i)=precision;
        Recall{1,7}(k,i)=recall;
        Fscore{1,7}(k,i)=fscore;
        Time{1,7}(k,i)=time;

        t1=clock;
        [x_,Aff]=WlqRFM(y,x,p,mu,iter,max_mu,alpha,stop);          %the proposed weighted lp estimator
        t2=clock;
        time=etime(t2,t1);
        [rmse, precision, recall, fscore]=Evaluation(x_,x, noise, gt,npt, npt+Noutlier);
        RMSE{1,8}(k,i)=rmse;
        Precision{1,8}(k,i)=precision;
        Recall{1,8}(k,i)=recall;
        Fscore{1,8}(k,i)=fscore;
        Time{1,8}(k,i)=time;
    end
end

plotResults(RMSE, Precision, Recall, Fscore, Time, nTest);



