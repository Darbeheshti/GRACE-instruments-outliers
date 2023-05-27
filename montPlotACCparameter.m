clear all
close all
format longg;
year='07';
filepath=['/storage/research/aiub_u_camp/NEDA/OUT/'];
filepathNeda='/storage/research/aiub_u_camp/NEDA/OUT/';
itr='rl03r';
stepname='FinM';
FinM_format='%s%s%s%s%f%f%f%f%s%s%s%s%s';
%% scale
file=[filepath,stepname,itr,year,'a_scl11'];
FID=fopen(file);
datacell = textscan(FID, FinM_format, 'CollectOutput', 1);
fclose(FID);
acca_scl11=datacell{1,2}(:,2);
acc_day=datacell{1,3}(:,4);% the time just once
% %%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'a_scl22'];
FID=fopen(file);
datacell = textscan(FID, FinM_format, 'CollectOutput', 1);
fclose(FID);
acca_scl22=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'a_scl33'];
FID=fopen(file);
datacell = textscan(FID, FinM_format, 'CollectOutput', 1);
fclose(FID);
acca_scl33=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'b_scl11'];
FID=fopen(file);
datacell = textscan(FID,FinM_format, 'CollectOutput', 1);
fclose(FID);
accb_scl11=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'b_scl22'];
FID=fopen(file);
datacell = textscan(FID, FinM_format, 'CollectOutput', 1);
fclose(FID);
accb_scl22=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'b_scl33'];
FID=fopen(file);
datacell = textscan(FID,FinM_format, 'CollectOutput', 1);
fclose(FID);
accb_scl33=datacell{1,2}(:,2);
%% scale off diagonal
% %A
% file=[filepath,stepname,itr,year,'a_ALPHA'];
% FID=fopen(file);
% datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
% fclose(FID);
% acca_ALPHA=datacell{1,2}(:,2);
% %%%%%%%%%%%%%%%
% file=[filepath,stepname,itr,year,'a_ZETA'];
% FID=fopen(file);
% datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
% fclose(FID);
% acca_ZETA=datacell{1,2}(:,2);
% %%%%%%%%%%%%%%%
% file=[filepath,stepname,itr,year,'a_BETA'];
% FID=fopen(file);
% datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
% fclose(FID);
% acca_BETA=datacell{1,2}(:,2);
% %%%%%%%%%%%%%%%
% file=[filepath,stepname,itr,year,'a_EPS'];
% FID=fopen(file);
% datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
% fclose(FID);
% acca_EPS=datacell{1,2}(:,2);
% %%%%%%%%%%%%%%%
% file=[filepath,stepname,itr,year,'a_GAMMA'];
% FID=fopen(file);
% datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
% fclose(FID);
% acca_GAMMA=datacell{1,2}(:,2);
% %%%%%%%%%%%%%%%
% file=[filepath,stepname,itr,year,'a_DELTA'];
% FID=fopen(file);
% datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
% fclose(FID);
% acca_DELTA=datacell{1,2}(:,2);
% %B
% file=[filepath,stepname,itr,year,'b_ALPHA'];
% FID=fopen(file);
% datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
% fclose(FID);
% accb_ALPHA=datacell{1,2}(:,2);
% %%%%%%%%%%%%%%%
% file=[filepath,stepname,itr,year,'b_ZETA'];
% FID=fopen(file);
% datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
% fclose(FID);
% accb_ZETA=datacell{1,2}(:,2);
% %%%%%%%%%%%%%%%
% file=[filepath,stepname,itr,year,'b_BETA'];
% FID=fopen(file);
% datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
% fclose(FID);
% accb_BETA=datacell{1,2}(:,2);
% %%%%%%%%%%%%%%%
% file=[filepath,stepname,itr,year,'b_EPS'];
% FID=fopen(file);
% datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
% fclose(FID);
% accb_EPS=datacell{1,2}(:,2);
% %%%%%%%%%%%%%%%
% file=[filepath,stepname,itr,year,'b_GAMMA'];
% FID=fopen(file);
% datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
% fclose(FID);
% accb_GAMMA=datacell{1,2}(:,2);
% %%%%%%%%%%%%%%%
% file=[filepath,stepname,itr,year,'b_DELTA'];
% FID=fopen(file);
% datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
% fclose(FID);
% accb_DELTA=datacell{1,2}(:,2);
%% bias
% file=[filepath,stepname,itr,year,'aDbias'];
% FID=fopen(file);
% datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
% fclose(FID);
% acca_dbias=datacell{1,2}(:,2);
% %%%%%%%%%%%%%%%
% file=[filepath,stepname,itr,year,'aYbias'];
% FID=fopen(file);
% datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
% fclose(FID);
% acca_ybias=datacell{1,2}(:,2);
% %%%%%%%%%%%%%%%
% file=[filepath,stepname,itr,year,'aXbias'];
% FID=fopen(file);
% datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
% fclose(FID);
% acca_xbias=datacell{1,2}(:,2);
% %%%%%%%%%%%%%%%
% file=[filepath,stepname,itr,year,'bDbias'];
% FID=fopen(file);
% datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
% fclose(FID);
% accb_dbias=datacell{1,2}(:,2);
% %%%%%%%%%%%%%%%
% file=[filepath,stepname,itr,year,'bYbias'];
% FID=fopen(file);
% datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
% fclose(FID);
% accb_ybias=datacell{1,2}(:,2);
% %%%%%%%%%%%%%%%
% file=[filepath,stepname,itr,year,'bXbias'];
% FID=fopen(file);
% datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
% fclose(FID);
% accb_xbias=datacell{1,2}(:,2);
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%scale plots
%A
dbig=1;
dend=length(acc_day);%114
yliml=-5;
ylimu=5;
figure
plot(datetime(acc_day(dbig:dend)),(acca_scl11(dbig:dend)),'.r','MarkerSize',10)
hold on
plot(datetime(acc_day(dbig:dend)),(acca_scl22(dbig:dend)),'.b','MarkerSize',10)
hold on
plot(datetime(acc_day(dbig:dend)),(acca_scl33(dbig:dend)),'.g','MarkerSize',10)
ylim([yliml ylimu])
legend('along-track','cross-track','radial');
%legend('11','22','33');
title ([stepname,itr,' GRACE A scale factor']);
grid on
saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'_scale',year,'A'],'png')
%B
figure
plot(datetime(acc_day(dbig:dend)),(accb_scl11(dbig:dend)),'.r','MarkerSize',10)
hold on
plot(datetime(acc_day(dbig:dend)),(accb_scl22(dbig:dend)),'.b','MarkerSize',10)
hold on
plot(datetime(acc_day(dbig:dend)),(accb_scl33(dbig:dend)),'.g','MarkerSize',10)
ylim([yliml ylimu])
legend('along-track','cross-track','radial');
title ([stepname,itr,' GRACE B scale factor']);
grid on
saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'_scale',year,'B'],'png')
%% scale off diagonal plots
% A
% figure
% plot(datetime(acc_day),(acca_ALPHA),'.r','MarkerSize',10)
% hold on
% plot(datetime(acc_day),(acca_BETA), '.b','MarkerSize',10)
% hold on
% plot(datetime(acc_day),(acca_GAMMA),'.g','MarkerSize',10)
% ylabel('[rad]');
% legend('$\alpha$','$\beta$','$\gamma$','Interpreter','latex');
% ylim([-1 1])
% title ([stepname,itr,' GRACE A sheer elements']);
% grid on
% saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'_sheer',year,'A'],'png')
% figure
% plot(datetime(acc_day),(acca_ZETA), '.r','MarkerSize',10)
% hold on
% plot(datetime(acc_day),(acca_EPS),  '.b','MarkerSize',10)
% hold on
% plot(datetime(acc_day),(acca_DELTA),'.g','MarkerSize',10)
% ylabel('[rad]');
% legend('$\zeta$','$\epsilon$','$\delta$','Interpreter','latex');
% ylim([-1 1])
% title ([stepname,itr,' GRACE A rotational elements']);
% grid on
% saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'_rotation',year,'A'],'png')
% % B
% figure
% plot(datetime(acc_day),(accb_ALPHA),'.r','MarkerSize',10)
% hold on
% plot(datetime(acc_day),(accb_BETA), '.b','MarkerSize',10)
% hold on
% plot(datetime(acc_day),(accb_GAMMA),'.g','MarkerSize',10)
% ylabel('[rad]');
% legend('$\alpha$','$\beta$','$\gamma$','Interpreter','latex');
% ylim([-1 1])
% title ([stepname,itr,' GRACE B sheer elements']);
% grid on
% saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'_sheer',year,'B'],'png')
% figure
% plot(datetime(acc_day),(accb_ZETA), '.r','MarkerSize',10)
% hold on
% plot(datetime(acc_day),(accb_EPS),  '.b','MarkerSize',10)
% hold on
% plot(datetime(acc_day),(accb_DELTA),'.g','MarkerSize',10)
% ylabel('[rad]');
% legend('$\zeta$','$\epsilon$','$\delta$','Interpreter','latex');
% ylim([-1 1])
% title ([stepname,itr,' GRACE B rotational elements']);
% grid on
% saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'_rotation',year,'B'],'png')
%% bias plots
% A
% figure
% subplot(4,1,1)
% plot(datetime(acc_day),(acca_dbias(1:4:end)),'.r','MarkerSize',10)
% ylabel('$p3$','Interpreter','latex');
% hold on
% plot(datetime(acc_day),(acca_ybias(1:4:end)),'.b','MarkerSize',10)
% ylabel('$p3$','Interpreter','latex');
% hold on
% plot(datetime(acc_day),(acca_xbias(1:4:end)),'.g','MarkerSize',10)
% ylabel('$p3$','Interpreter','latex');
% title ([stepname,itr,' GRACE A bias']);
% grid on
% ylim([-10^(-7) 10^(-7)])
% %figure
% subplot(4,1,2)
% plot(datetime(acc_day),(acca_dbias(2:4:end)),'.r','MarkerSize',10)
% ylabel('$p2$','Interpreter','latex');
% hold on
% plot(datetime(acc_day),(acca_ybias(2:4:end)),'.b','MarkerSize',10)
% ylabel('$p2$','Interpreter','latex');
% hold on
% plot(datetime(acc_day),(acca_xbias(2:4:end)),'.g','MarkerSize',10)
% ylabel('$p2$','Interpreter','latex');
% grid on
% ylim([-10^(-6) 10^(-6)])
% %figure
% subplot(4,1,3)
% plot(datetime(acc_day),(acca_dbias(3:4:end)),'.r','MarkerSize',10)
% ylabel('$p1$','Interpreter','latex');
% hold on
% plot(datetime(acc_day),(acca_ybias(3:4:end)),'.b','MarkerSize',10)
% ylabel('$p1$','Interpreter','latex');
% hold on
% plot(datetime(acc_day),(acca_xbias(3:4:end)),'.g','MarkerSize',10)
% ylabel('$p1$','Interpreter','latex');
% grid on
% ylim([-10^(-6) 10^(-6)])
%figure
% subplot(4,1,4)
% plot(datetime(acc_day),(acca_dbias(4:4:end)),'.r','MarkerSize',10)
% ylabel('$p0[m/s^2]$','Interpreter','latex');
% hold on
% plot(datetime(acc_day),(acca_ybias(4:4:end)),'.b','MarkerSize',10)
% ylabel('$p0[m/s^2]$','Interpreter','latex');
% hold on
% plot(datetime(acc_day),(acca_xbias(4:4:end)),'.g','MarkerSize',10)
% ylabel('$p0[m/s^2]$','Interpreter','latex');
% legend('D','Y','X');
% grid on
% ylim([-10^(-6) 10^(-6)])
% saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'_bias',year,'A'],'png')
% % B
% figure
% subplot(4,1,1)
% plot(datetime(acc_day),(accb_dbias(1:4:end)),'.r','MarkerSize',10)
% ylabel('$p3$','Interpreter','latex');
% hold on
% plot(datetime(acc_day),(accb_ybias(1:4:end)),'.b','MarkerSize',10)
% ylabel('$p3$','Interpreter','latex');
% hold on
% plot(datetime(acc_day),(accb_xbias(1:4:end)),'.g','MarkerSize',10)
% ylabel('$p3$','Interpreter','latex');
% title ([stepname,itr,' GRACE B bias']);
% grid on
% ylim([-10^(-7) 10^(-7)])
%
% subplot(4,1,2)
% plot(datetime(acc_day),(accb_dbias(2:4:end)),'.r','MarkerSize',10)
% ylabel('$p2$','Interpreter','latex');
% hold on
% plot(datetime(acc_day),(accb_ybias(2:4:end)),'.b','MarkerSize',10)
% ylabel('$p2$','Interpreter','latex');
% hold on
% plot(datetime(acc_day),(accb_xbias(2:4:end)),'.g','MarkerSize',10)
% ylabel('$p2$','Interpreter','latex');
% grid on
% ylim([-10^(-6) 10^(-6)])
% %
% subplot(4,1,3)
% plot(datetime(acc_day),(accb_dbias(3:4:end)),'.r','MarkerSize',10)
% ylabel('$p1$','Interpreter','latex');
% hold on
% plot(datetime(acc_day),(accb_ybias(3:4:end)),'.b','MarkerSize',10)
% ylabel('$p1$','Interpreter','latex');
% hold on
% plot(datetime(acc_day),(accb_xbias(3:4:end)),'.g','MarkerSize',10)
% ylabel('$p1$','Interpreter','latex');
% grid on
% ylim([-10^(-6) 10^(-6)])
% %
% subplot(4,1,4)
% plot(datetime(acc_day),(accb_dbias(4:4:end)),'.r','MarkerSize',10)
% ylabel('$p0[m/s^2]$','Interpreter','latex');
% hold on
% plot(datetime(acc_day),(accb_ybias(4:4:end)),'.b','MarkerSize',10)
% ylabel('$p0[m/s^2]$','Interpreter','latex');
% hold on
% plot(datetime(acc_day),(accb_xbias(4:4:end)),'.g','MarkerSize',10)
% ylabel('$p0[m/s^2]$','Interpreter','latex');
% legend('D','Y','X');
% grid on
% ylim([-10^(-6) 10^(-6)])
% saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'_bias',year,'B'],'png')
