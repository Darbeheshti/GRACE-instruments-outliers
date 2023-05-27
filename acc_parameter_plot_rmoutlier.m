clear all
close all
format longg;
year='11';
filepath=['/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/res20/aiub_out/res20',year,'/'];
filepathNeda='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/';
itr='3par';
stepname='FinM';%d0 or FinM
%% scale
file=[filepath,stepname,itr,year,'a_scl11'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_scl11=datacell{1,2}(:,2);
acc_day=datacell{1,3}(:,4);% the time just once
% %%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'a_scl22'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_scl22=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'a_scl33'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_scl33=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'b_scl11'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_scl11=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'b_scl22'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_scl22=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'b_scl33'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_scl33=datacell{1,2}(:,2);
%% scale off diagonal
%A
file=[filepath,stepname,itr,year,'a_ALPHA'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_ALPHA=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'a_ZETA'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_ZETA=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'a_BETA'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_BETA=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'a_EPS'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_EPS=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'a_GAMMA'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_GAMMA=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'a_DELTA'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_DELTA=datacell{1,2}(:,2);
%B
file=[filepath,stepname,itr,year,'b_ALPHA'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_ALPHA=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'b_ZETA'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_ZETA=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'b_BETA'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_BETA=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'b_EPS'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_EPS=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'b_GAMMA'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_GAMMA=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'b_DELTA'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_DELTA=datacell{1,2}(:,2);
%% bias
file=[filepath,stepname,itr,year,'aDbias'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_dbias=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'aYbias'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_ybias=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'aXbias'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_xbias=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'bDbias'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_dbias=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'bYbias'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_ybias=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'bXbias'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_xbias=datacell{1,2}(:,2);
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%outlier detection
TF= isoutlier(acca_scl22,'mean');
%% scale diagonal plots
% A
figure
plot(datetime(acc_day(~TF)),(acca_scl11(~TF)),'.r','MarkerSize',10)
hold on
plot(datetime(acc_day(~TF)),(acca_scl22(~TF)),'.b','MarkerSize',10)
hold on
plot(datetime(acc_day(~TF)),(acca_scl33(~TF)),'.g','MarkerSize',10)
legend('along-track','cross-track','radial');
%legend('11','22','33');
title ([stepname,itr,' GRACE A scale factor']);
grid on
saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'_scale_rmout',year,'A'],'png')
%
% figure
% plot(datetime(acc_day(~TF)),(acca_scl11(~TF)),'.r','MarkerSize',10)
% hold on
% plot(datetime(acc_day(~TF)),(acca_scl33(~TF)),'.g','MarkerSize',10)
% legend('along-track','radial');
% %legend('11','33');
% title ([stepname,itr,' GRACE A scale factor']);
% grid on
% saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'_sscalermout',year,'A'],'png')
% B
figure
plot(datetime(acc_day(~TF)),(accb_scl11(~TF)),'.r','MarkerSize',10)
hold on
plot(datetime(acc_day(~TF)),(accb_scl22(~TF)),'.b','MarkerSize',10)
hold on
plot(datetime(acc_day(~TF)),(accb_scl33(~TF)),'.g','MarkerSize',10)
legend('along-track','cross-track','radial');
title ([stepname,itr,' GRACE B scale factor']);
grid on
saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'_scale_rmout',year,'B'],'png')
%
% figure
% plot(datetime(acc_day(~TF)),(accb_scl11(~TF)),'.r','MarkerSize',10)
% hold on
% plot(datetime(acc_day(~TF)),(accb_scl33(~TF)),'.g','MarkerSize',10)
% legend('along-track','radial');
% title ([stepname,itr,' GRACE B scale factor']);
% grid on
% saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'_sscale_rmout',year,'B'],'png')
%% scale off diagonal plots
% % A
figure
plot(datetime(acc_day(~TF)),(acca_ALPHA(~TF)),'.r','MarkerSize',10)
hold on
plot(datetime(acc_day(~TF)),(acca_BETA(~TF)), '.b','MarkerSize',10)
hold on
plot(datetime(acc_day(~TF)),(acca_GAMMA(~TF)),'.g','MarkerSize',10)
ylabel('[rad]');
legend('$\alpha$','$\beta$','$\gamma$','Interpreter','latex');
title ([stepname,itr,' GRACE A sheer elements']);
grid on
saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'_sheerrmout',year,'A'],'png')
figure
plot(datetime(acc_day(~TF)),(acca_ZETA(~TF)), '.r','MarkerSize',10)
hold on
plot(datetime(acc_day(~TF)),(acca_EPS(~TF)),  '.b','MarkerSize',10)
hold on
plot(datetime(acc_day(~TF)),(acca_DELTA(~TF)),'.g','MarkerSize',10)
ylabel('[rad]');
legend('$\zeta$','$\epsilon$','$\delta$','Interpreter','latex');
title ([stepname,itr,' GRACE A rotational elements']);
grid on
saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'_rotationrmout',year,'A'],'png')
%B
figure
plot(datetime(acc_day(~TF)),(accb_ALPHA(~TF)),'.r','MarkerSize',10)
hold on
plot(datetime(acc_day(~TF)),(accb_BETA(~TF)), '.b','MarkerSize',10)
hold on
plot(datetime(acc_day(~TF)),(accb_GAMMA(~TF)),'.g','MarkerSize',10)
ylabel('[rad]');
legend('$\alpha$','$\beta$','$\gamma$','Interpreter','latex');
title ([stepname,itr,' GRACE B sheer elements']);
grid on
saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'_sheerrmout',year,'B'],'png')
figure
plot(datetime(acc_day(~TF)),(accb_ZETA(~TF)), '.r','MarkerSize',10)
hold on
plot(datetime(acc_day(~TF)),(accb_EPS(~TF)),  '.b','MarkerSize',10)
hold on
plot(datetime(acc_day(~TF)),(accb_DELTA(~TF)),'.g','MarkerSize',10)
ylabel('[rad]');
legend('$\zeta$','$\epsilon$','$\delta$','Interpreter','latex');
title ([stepname,itr,' GRACE B rotational elements']);
grid on
saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'_rotationrmout',year,'B'],'png')





