function plotResults(RMSE, Precision, Recall, Fscore, Time, nTest)

n=[10:10:90];
name= {'Huber+IRLS', 'Cauchy+IRLS', 'GemanMcClure+IRLS', 'Welsch+IRLS','tukey+IRLS', 'RANSAC',    'RRANSAC', 'the proposed method' };
marker= { 'x', 's',      'd',      '^',            '>',        'v',      '*','o'};
color= {'r',   'g',      [1,0.5,0],'m',            'c',       'y',      [1,0.5,1],'k'};
markerfacecolor=  {'r','g',[1,0.5,0],'m',          'c',        'y',      'n','k'};
lx='Outlier rate(%)';

%% plot Precision
RES=[];
for i=1:8
    res=mean(Precision{1,i},2)*100;
    RES=[RES;res'];
end

figure
box('on');
hold('all');
ly='Average precision(%)';
yrange= [0 100];
p= zeros(1,length(name));
for i= 1:length(name)
    
    p(i)= plot(n,RES(i,:),'marker',marker{i},...
        'color',color{i},...
        'markerfacecolor',markerfacecolor{i},...
        'displayname',name{i}, ...
        'LineWidth',3,'MarkerSize',8);
    
end
ylim(yrange);
xlim(n([1 end]));
set(gca,'xtick',n);
xlabel(lx,'FontSize',17,'Fontname', 'Times New Roman');
ylabel(ly,'FontSize',17,'Fontname', 'Times New Roman');
handle=legend(p,3);
set(gca,'position',[0.14 0.14 0.84 0.84]);
set(gca,'FontSize',16,'Fontname','times new roman');

%% plot Recall
RES=[];
for i=1:8
    res=mean(Recall{1,i},2)*100;
    RES=[RES;res'];
end

figure
box('on');
hold('all');
ly='Average recall(%)';
yrange= [0 100];
p= zeros(1,length(name));
for i= 1:length(name)
    
    p(i)= plot(n,RES(i,:),'marker',marker{i},...
        'color',color{i},...
        'markerfacecolor',markerfacecolor{i},...
        'displayname',name{i}, ...
        'LineWidth',3,'MarkerSize',8);
    
end
ylim(yrange);
xlim(n([1 end]));
set(gca,'xtick',n);
xlabel(lx,'FontSize',17,'Fontname', 'Times New Roman');
ylabel(ly,'FontSize',17,'Fontname', 'Times New Roman');
set(gca,'position',[0.14 0.14 0.84 0.84]);
set(gca,'FontSize',16,'Fontname','times new roman');

%% plot F-score
RES=[];
for i=1:8
    res=mean(Fscore{1,i},2)*100;
    RES=[RES;res'];
end

figure
box('on');
hold('all');
ly='Average Fscore(%)';
yrange= [0 100];
p= zeros(1,length(name));
for i= 1:length(name)
    
    p(i)= plot(n,RES(i,:),'marker',marker{i},...
        'color',color{i},...
        'markerfacecolor',markerfacecolor{i},...
        'displayname',name{i}, ...
        'LineWidth',3,'MarkerSize',8);
    
end
ylim(yrange);
xlim(n([1 end]));
set(gca,'xtick',n);
xlabel(lx,'FontSize',17,'Fontname', 'Times New Roman');
ylabel(ly,'FontSize',17,'Fontname', 'Times New Roman');
set(gca,'position',[0.14 0.14 0.84 0.84]);
set(gca,'FontSize',16,'Fontname','times new roman');

%% plot RMSE
RES=[];
for i=1:8
    res=mean(RMSE{1,i},2);
    RES=[RES;res'];
end

figure;
box('on');
hold('all');
ly='Average RMSE(pixels)';
yrange= [1.5 4];
p= zeros(1,length(name));
for i= 1:length(name)
    
    p(i)= plot(n,RES(i,:),'marker',marker{i},...
        'color',color{i},...
        'markerfacecolor',markerfacecolor{i},...
        'displayname',name{i}, ...
        'LineWidth',3,'MarkerSize',8);
    
end
ylim(yrange);
xlim(n([1 end]));
set(gca,'xtick',n);
xlabel(lx,'FontSize',17,'Fontname', 'Times New Roman');
ylabel(ly,'FontSize',17,'Fontname', 'Times New Roman');
set(gca,'position',[0.14 0.14 0.84 0.84]);
set(gca,'FontSize',16,'Fontname','times new roman');

%% plot Success rate
% RES=[];
% for i=1:8
%     res=sum(RMSE{1,i}<4,2);
%     res=(res./nTest)*100;
%     RES=[RES;res'];
% end
% 
% figure;
% box('on');
% hold('all');
% ly='Average success rate(%)';
% yrange= [0 100];
% p= zeros(1,length(name));
% for i= 1:length(name)
%     
%     p(i)= plot(n,RES(i,:),'marker',marker{i},...
%         'color',color{i},...
%         'markerfacecolor',markerfacecolor{i},...
%         'displayname',name{i}, ...
%         'LineWidth',3,'MarkerSize',8);
%     
% end
% ylim(yrange);
% xlim(n([1 end]));
% set(gca,'xtick',n);
% xlabel(lx,'FontSize',17,'Fontname', 'Times New Roman');
% ylabel(ly,'FontSize',17,'Fontname', 'Times New Roman');
% set(gca,'position',[0.14 0.14 0.84 0.84]);
% set(gca,'FontSize',16,'Fontname','times new roman');


RES=[];
for i=1:8
    res=mean(Time{1,i},2);
    RES=[RES;res'];
end

figure;
box('on');
hold('all');
ly='Average time(s)';
yrange= [0 4];
p= zeros(1,length(name));
for i= 1:length(name)
    p(i)= plot(n,RES(i,:),'marker',marker{i},...
        'color',color{i},...
        'markerfacecolor',markerfacecolor{i},...
        'displayname',name{i}, ...
        'LineWidth',3,'MarkerSize',8);

end
ylim(yrange);
xlim(n([1 end]));
set(gca,'xtick',n);
xlabel(lx,'FontSize',17,'Fontname', 'Times New Roman');
ylabel(ly,'FontSize',17,'Fontname', 'Times New Roman');
set(gca,'position',[0.14 0.14 0.84 0.84]);
set(gca,'FontSize',16,'Fontname','times new roman');
handle=legend(p,1);