clear all
close all
format longg;
filepath='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/res2016/';
filepathNeda='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/';
year='11';
itr='3acc';
%% scale
file=[filepath,itr,'20',year,'a_scl11'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_scl11=datacell{1,2};
acc_day=datacell{1,3};% the time just once
%%%%%%%%%%%%%%%
file=[filepath,itr,'20',year,'a_scl22'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_scl22=datacell{1,2};
%%%%%%%%%%%%%%%
file=[filepath,itr,'20',year,'a_scl33'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_scl33=datacell{1,2};
%%%%%%%%%%%%%%%
file=[filepath,itr,'20',year,'b_scl11'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_scl11=datacell{1,2};
%%%%%%%%%%%%%%%
file=[filepath,itr,'20',year,'b_scl22'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_scl22=datacell{1,2};
%%%%%%%%%%%%%%%
file=[filepath,itr,'20',year,'b_scl33'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_scl33=datacell{1,2};
%% scale off diagonal
%A
file=[filepath,itr,'20',year,'a_ALPHA'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_ALPHA=datacell{1,2};
%%%%%%%%%%%%%%%
file=[filepath,itr,'20',year,'a_ZETA'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_ZETA=datacell{1,2};
%%%%%%%%%%%%%%%
file=[filepath,itr,'20',year,'a_BETA'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_BETA=datacell{1,2};
%%%%%%%%%%%%%%%
file=[filepath,itr,'20',year,'a_EPS'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_EPS=datacell{1,2};
%%%%%%%%%%%%%%%
file=[filepath,itr,'20',year,'a_GAMMA'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_GAMMA=datacell{1,2};
%%%%%%%%%%%%%%%
file=[filepath,itr,'20',year,'a_DELTA'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_DELTA=datacell{1,2};
%B
file=[filepath,itr,'20',year,'b_ALPHA'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_ALPHA=datacell{1,2};
%%%%%%%%%%%%%%%
file=[filepath,itr,'20',year,'b_ZETA'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_ZETA=datacell{1,2};
%%%%%%%%%%%%%%%
file=[filepath,itr,'20',year,'b_BETA'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_BETA=datacell{1,2};
%%%%%%%%%%%%%%%
file=[filepath,itr,'20',year,'b_EPS'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_EPS=datacell{1,2};
%%%%%%%%%%%%%%%
file=[filepath,itr,'20',year,'b_GAMMA'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_GAMMA=datacell{1,2};
%%%%%%%%%%%%%%%
file=[filepath,itr,'20',year,'b_DELTA'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_DELTA=datacell{1,2};
%% bias
file=[filepath,itr,'20',year,'aDbias'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_dbias=datacell{1,2};
%%%%%%%%%%%%%%%
file=[filepath,itr,'20',year,'aYbias'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_ybias=datacell{1,2};
%%%%%%%%%%%%%%%
file=[filepath,itr,'20',year,'aXbias'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_xbias=datacell{1,2};
%%%%%%%%%%%%%%%
file=[filepath,itr,'20',year,'bDbias'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_dbias=datacell{1,2};
%%%%%%%%%%%%%%%
file=[filepath,itr,'20',year,'bYbias'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_ybias=datacell{1,2};
%%%%%%%%%%%%%%%
file=[filepath,itr,'20',year,'bXbias'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
accb_xbias=datacell{1,2};
%% scale plots
%B = rmoutliers(acca_scl11(:,2));
% acca_scl22(44,:)=[];
% acca_scl22(1,:)=[];
figure
plot(datetime(acc_day(:,4)),(acca_scl11(:,2)),'.r','MarkerSize',10)
hold on
plot(datetime(acc_day(:,4)),(acca_scl22(:,2)),'.b','MarkerSize',10)
hold on
plot(datetime(acc_day(:,4)),(acca_scl33(:,2)),'.g','MarkerSize',10)

acca_scl22(44,:)=[];
acca_scl22(1,:)=[];

%legend('along-track','cross-track','radial');
legend('11','22','33');
title ([itr,' GRACE A scale factor']);
grid on
saveas(gcf,[filepathNeda,'plots/20',year,'/',itr,'_scale',year,'A'],'png')
figure
plot(datetime(acc_day(:,4)),(accb_scl11(:,2)),'.r','MarkerSize',10)
hold on
plot(datetime(acc_day(:,4)),(accb_scl22(:,2)),'.b','MarkerSize',10)
hold on
plot(datetime(acc_day(:,4)),(accb_scl33(:,2)),'.g','MarkerSize',10)
legend('11','22','33');
title ([itr,' GRACE B scale factor']);
grid on
saveas(gcf,[filepathNeda,'plots/20',year,'/',itr,'_scale',year,'B'],'png')
%% scale off diagonal plots
% A
figure
plot(datetime(acc_day(:,4)),(acca_ALPHA(:,2)),'.r','MarkerSize',10)
hold on
plot(datetime(acc_day(:,4)),(acca_BETA(:,2)), '.b','MarkerSize',10)
hold on
plot(datetime(acc_day(:,4)),(acca_GAMMA(:,2)),'.g','MarkerSize',10)
ylabel('[rad]');
legend('$\alpha$','$\beta$','$\gamma$','Interpreter','latex');
title ([itr,' GRACE A sheer elements']);
grid on
saveas(gcf,[filepathNeda,'plots/20',year,'/',itr,'_sheer',year,'A'],'png')
figure
plot(datetime(acc_day(:,4)),(acca_ZETA(:,2)), '.r','MarkerSize',10)
hold on
plot(datetime(acc_day(:,4)),(acca_EPS(:,2)),  '.b','MarkerSize',10)
hold on
plot(datetime(acc_day(:,4)),(acca_DELTA(:,2)),'.g','MarkerSize',10)
ylabel('[rad]');
legend('$\zeta$','$\epsilon$','$\delta$','Interpreter','latex');
title ([itr,' GRACE A rotational elements']);
grid on
saveas(gcf,[filepathNeda,'plots/20',year,'/',itr,'_rotation',year,'A'],'png')
% B
figure
plot(datetime(acc_day(:,4)),(accb_ALPHA(:,2)),'.r','MarkerSize',10)
hold on
plot(datetime(acc_day(:,4)),(accb_BETA(:,2)), '.b','MarkerSize',10)
hold on
plot(datetime(acc_day(:,4)),(accb_GAMMA(:,2)),'.g','MarkerSize',10)
ylabel('[rad]');
legend('$\alpha$','$\beta$','$\gamma$','Interpreter','latex');
title ([itr,' GRACE B sheer elements']);
grid on
saveas(gcf,[filepathNeda,'plots/20',year,'/',itr,'_sheer',year,'B'],'png')
figure
plot(datetime(acc_day(:,4)),(accb_ZETA(:,2)), '.r','MarkerSize',10)
hold on
plot(datetime(acc_day(:,4)),(accb_EPS(:,2)),  '.b','MarkerSize',10)
hold on
plot(datetime(acc_day(:,4)),(accb_DELTA(:,2)),'.g','MarkerSize',10)
ylabel('[rad]');
legend('$\zeta$','$\epsilon$','$\delta$','Interpreter','latex');
title ([itr,' GRACE B rotational elements']);
grid on
saveas(gcf,[filepathNeda,'plots/20',year,'/',itr,'_rotation',year,'B'],'png')
%% bias plots
% A
figure
subplot(4,1,1)
plot(datetime(acc_day(:,4)),(acca_dbias(1:4:end,2)),'.r','MarkerSize',10)
ylabel('$p3$','Interpreter','latex');
hold on
plot(datetime(acc_day(:,4)),(acca_ybias(1:4:end,2)),'.b','MarkerSize',10)
ylabel('$p3$','Interpreter','latex');
hold on
plot(datetime(acc_day(:,4)),(acca_xbias(1:4:end,2)),'.g','MarkerSize',10)
ylabel('$p3$','Interpreter','latex');
title ([itr,' GRACE A bias']);
grid on
%figure
subplot(4,1,2)
plot(datetime(acc_day(:,4)),(acca_dbias(2:4:end,2)),'.r','MarkerSize',10)
ylabel('$p2$','Interpreter','latex');
hold on
plot(datetime(acc_day(:,4)),(acca_ybias(2:4:end,2)),'.b','MarkerSize',10)
ylabel('$p2$','Interpreter','latex');
hold on
plot(datetime(acc_day(:,4)),(acca_xbias(2:4:end,2)),'.g','MarkerSize',10)
ylabel('$p2$','Interpreter','latex');
grid on
%figure
subplot(4,1,3)
plot(datetime(acc_day(:,4)),(acca_dbias(3:4:end,2)),'.r','MarkerSize',10)
ylabel('$p1$','Interpreter','latex');
hold on
plot(datetime(acc_day(:,4)),(acca_ybias(3:4:end,2)),'.b','MarkerSize',10)
ylabel('$p1$','Interpreter','latex');
hold on
plot(datetime(acc_day(:,4)),(acca_xbias(3:4:end,2)),'.g','MarkerSize',10)
ylabel('$p1$','Interpreter','latex');
grid on
%figure
subplot(4,1,4)
plot(datetime(acc_day(:,4)),(acca_dbias(4:4:end,2)),'.r','MarkerSize',10)
ylabel('$p0[m/s^2]$','Interpreter','latex');
hold on
plot(datetime(acc_day(:,4)),(acca_ybias(4:4:end,2)),'.b','MarkerSize',10)
ylabel('$p0[m/s^2]$','Interpreter','latex');
hold on
plot(datetime(acc_day(:,4)),(acca_xbias(4:4:end,2)),'.g','MarkerSize',10)
ylabel('$p0[m/s^2]$','Interpreter','latex');
legend('D','Y','X');
grid on
saveas(gcf,[filepathNeda,'plots/20',year,'/',itr,'_bias',year,'A'],'png')
% B
figure
subplot(4,1,1)
plot(datetime(acc_day(:,4)),(accb_dbias(1:4:end,2)),'.r','MarkerSize',10)
ylabel('$p3$','Interpreter','latex');
hold on
plot(datetime(acc_day(:,4)),(accb_ybias(1:4:end,2)),'.b','MarkerSize',10)
ylabel('$p3$','Interpreter','latex');
hold on
plot(datetime(acc_day(:,4)),(accb_xbias(1:4:end,2)),'.g','MarkerSize',10)
ylabel('$p3$','Interpreter','latex');
title ([itr,' GRACE B bias']);
grid on
%
subplot(4,1,2)
plot(datetime(acc_day(:,4)),(accb_dbias(2:4:end,2)),'.r','MarkerSize',10)
ylabel('$p2$','Interpreter','latex');
hold on
plot(datetime(acc_day(:,4)),(accb_ybias(2:4:end,2)),'.b','MarkerSize',10)
ylabel('$p2$','Interpreter','latex');
hold on
plot(datetime(acc_day(:,4)),(accb_xbias(2:4:end,2)),'.g','MarkerSize',10)
ylabel('$p2$','Interpreter','latex');
grid on
%
subplot(4,1,3)
plot(datetime(acc_day(:,4)),(accb_dbias(3:4:end,2)),'.r','MarkerSize',10)
ylabel('$p1$','Interpreter','latex');
hold on
plot(datetime(acc_day(:,4)),(accb_ybias(3:4:end,2)),'.b','MarkerSize',10)
ylabel('$p1$','Interpreter','latex');
hold on
plot(datetime(acc_day(:,4)),(accb_xbias(3:4:end,2)),'.g','MarkerSize',10)
ylabel('$p1$','Interpreter','latex');
grid on
%
subplot(4,1,4)
plot(datetime(acc_day(:,4)),(accb_dbias(4:4:end,2)),'.r','MarkerSize',10)
ylabel('$p0[m/s^2]$','Interpreter','latex');
hold on
plot(datetime(acc_day(:,4)),(accb_ybias(4:4:end,2)),'.b','MarkerSize',10)
ylabel('$p0[m/s^2]$','Interpreter','latex');
hold on
plot(datetime(acc_day(:,4)),(accb_xbias(4:4:end,2)),'.g','MarkerSize',10)
ylabel('$p0[m/s^2]$','Interpreter','latex');
legend('D','Y','X');
grid on
saveas(gcf,[filepathNeda,'plots/20',year,'/',itr,'_bias',year,'B'],'png')






