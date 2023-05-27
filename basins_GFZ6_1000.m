%% Plotting for AIUB range rate residuals
%
% Written by Neda Darbeheshti, AIUB, 2020-03.
%%
clear all
close all

format longg;
ae=0.6378137000E+07;
filepath='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/';
year='18';
month='11';
 apriori1='gsGOCO05S';
 %apriori2='ssGOCO05S_trend';
 apriori2='s33GOCO05S';
%apriori1='gsGOCO05S_trendAIUB53915';
%apriori2='ssGOCO05S_trendAIUB53915';
%apriori3='ssGOCO05S_trendAIUB53915';
%% plot degree variances and gravity in spatial domain
%reference for comparison
lmaxf=90;
n_back = ((lmaxf+1)^2 + lmaxf+1)/2;

ggm05s = importGravityField('GGM05S.gfc');
ggm05s = ggm05s(1:n_back,:); % cut to desired length

ggm1 = importGravityField([filepath,'GRAV',apriori1,'_',year,month],13,4198);
ggm1= ggm1(1:n_back,:); % cut to desired length

ggm2 = importGravityField([filepath,'GRAV',apriori2,'_',year,month],13,4198);
ggm2= ggm2(1:n_back,:); % cut to desired length

d_vec = ggm05s;
d_vec(:,3:4) = ggm05s(:,3:4)-ggm1(:,3:4);


subplot(1,2,1);
dv_geoidn(d_vec,lmaxf,ae);
hold on

d_vec(:,3:4) = ggm05s(:,3:4)-ggm2(:,3:4);
dv_geoidn(d_vec,lmaxf,ae);
legend('30 fixed sessions','variable sessions')
title('referenced to GGM05S.gfc')

subplot(1,2,2);
dv_geoidn(ggm1,lmaxf,ae);
hold on
dv_geoidn(ggm2,lmaxf,ae);
legend('30 fixed sessions','variable sessions')
title([' year ',year,' month ',month])

dvs= dv_geoidn_no_plot(ggm1,lmaxf);
filename = ['KBR1B_2005-05-',ds,'_X_MDC-',version,'.asc'];
    fid = fopen(filename,'wt');
figure
semilogy(2:lmaxf,dvs(1:end),'.-','LineWidth',2,'MarkerSize',20)

%filepath='/Users/neda/Documents/COSTG/DATA/EGSIEM/AIUB/';
%AIUB_0605 = importGravityField([filepath,'AIUB_0605.gfc'],13,4198);
%AIUB_0605= AIUB_0605(1:n_back,:); % cut to desired length
%d_vec(:,3:4) = ggm05s(:,3:4)-AIUB_0605(:,3:4);
%subplot(3,1,3);
%hold on
%dv_geoidn(AIUB_0605,lmaxf,ae);
% hold on
% dv_geoidn(ggm1,lmaxf,ae);
% 
% hold on
% dv_geoidn(ggm2,lmaxf,ae);


% %saveas(gcf,[filepath,'/plots/','kres_',itr,apriori,'_',year,ds],'jpg')

%ggm05s = importGravityField([filepath,'ITSG-Grace2018_n96_2006-05.gfc'],13,4198);
%load([filepath,'ITSG_200605.mat'])









