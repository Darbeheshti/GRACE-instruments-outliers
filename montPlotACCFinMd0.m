clear all
close all
format longg;
year='07';
filepath=['/storage/research/aiub_u_camp/NEDA/OUT/'];
filepathNeda='/storage/research/aiub_u_camp/NEDA/OUT/';
itr='rl03b';
stepname='d0';
d0_format='%s%s%s%s%s%f%f%f%f%s%s%s%s%s';
%% scale
file=[filepath,stepname,itr,year,'a_scl11'];
FID=fopen(file);
datacell = textscan(FID, d0_format, 'CollectOutput', 1);
fclose(FID);
d0acca_scl11=datacell{1,2}(:,2);
acc_day=datacell{1,3}(:,4);% the time just once
% %%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'a_scl22'];
FID=fopen(file);
datacell = textscan(FID, d0_format, 'CollectOutput', 1);
fclose(FID);
d0acca_scl22=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'a_scl33'];
FID=fopen(file);
datacell = textscan(FID, d0_format, 'CollectOutput', 1);
fclose(FID);
d0acca_scl33=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'b_scl11'];
FID=fopen(file);
datacell = textscan(FID, d0_format, 'CollectOutput', 1);
fclose(FID);
d0accb_scl11=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'b_scl22'];
FID=fopen(file);
datacell = textscan(FID, d0_format, 'CollectOutput', 1);
fclose(FID);
d0accb_scl22=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'b_scl33'];
FID=fopen(file);
datacell = textscan(FID,d0_format, 'CollectOutput', 1);
fclose(FID);
d0accb_scl33=datacell{1,2}(:,2);
%% scale %%%%%%%%%%%%%%%
stepname='FinM';
FinM_format='%s%s%s%s%f%f%f%f%s%s%s%s%s';
%
file=[filepath,stepname,itr,year,'a_scl11'];
FID=fopen(file);
datacell = textscan(FID,FinM_format, 'CollectOutput', 1);
fclose(FID);
FinMacca_scl11=datacell{1,2}(:,2);
acc_day=datacell{1,3}(:,4);% the time just once
% %%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'a_scl22'];
FID=fopen(file);
datacell = textscan(FID, FinM_format, 'CollectOutput', 1);
fclose(FID);
FinMacca_scl22=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'a_scl33'];
FID=fopen(file);
datacell = textscan(FID, FinM_format, 'CollectOutput', 1);
fclose(FID);
FinMacca_scl33=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'b_scl11'];
FID=fopen(file);
datacell = textscan(FID, FinM_format, 'CollectOutput', 1);
fclose(FID);
FinMaccb_scl11=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'b_scl22'];
FID=fopen(file);
datacell = textscan(FID,FinM_format, 'CollectOutput', 1);
fclose(FID);
FinMaccb_scl22=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'b_scl33'];
FID=fopen(file);
datacell = textscan(FID,FinM_format, 'CollectOutput', 1);
fclose(FID);
FinMaccb_scl33=datacell{1,2}(:,2);
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%scale plots
%A
dbig=1;
dend=length(acc_day);
yliml=-5;
ylimu=5;
%
figure
subplot(3,1,1)
plot(datetime(acc_day(dbig:dend)),(d0acca_scl11(dbig:dend)),'.g','MarkerSize',10)
hold on
plot(datetime(acc_day(dbig:dend)),(FinMacca_scl11(dbig:dend)),'.r','MarkerSize',10)
ylim([yliml ylimu])
title ([itr,' GRACE A along-track']);
grid on
legend('KRR apriori','KRR final');
subplot(3,1,2)
plot(datetime(acc_day(dbig:dend)),(d0acca_scl22(dbig:dend)),'.g','MarkerSize',10)
hold on
plot(datetime(acc_day(dbig:dend)),(FinMacca_scl22(dbig:dend)),'.r','MarkerSize',10)
ylim([yliml ylimu])
title (['GRACE A cross-track']);
grid on
subplot(3,1,3)
plot(datetime(acc_day(dbig:dend)),(d0acca_scl33(dbig:dend)),'.g','MarkerSize',10)
hold on
plot(datetime(acc_day(dbig:dend)),(FinMacca_scl33(dbig:dend)),'.r','MarkerSize',10)
ylim([yliml ylimu])
title (['GRACE A radial']);
grid on
saveas(gcf,[filepathNeda,'plots/20',year,'/',itr,'_scaled0finm',year,'A'],'png')
%B
figure
subplot(3,1,1)
plot(datetime(acc_day(dbig:dend)),(d0accb_scl11(dbig:dend)),'.g','MarkerSize',10)
ylim([yliml ylimu])
hold on
plot(datetime(acc_day(dbig:dend)),(FinMaccb_scl11(dbig:dend)),'.r','MarkerSize',10)
ylim([yliml ylimu])
title ([itr,' GRACE B along-track']);
grid on
legend('KRR apriori','KRR final');
subplot(3,1,2)
plot(datetime(acc_day(dbig:dend)),(d0accb_scl22(dbig:dend)),'.g','MarkerSize',10)
ylim([yliml ylimu])
hold on
plot(datetime(acc_day(dbig:dend)),(FinMaccb_scl22(dbig:dend)),'.r','MarkerSize',10)
title (['GRACE B cross-track']);
grid on
subplot(3,1,3)
plot(datetime(acc_day(dbig:dend)),(d0accb_scl33(dbig:dend)),'.g','MarkerSize',10)
ylim([yliml ylimu])
hold on
plot(datetime(acc_day(dbig:dend)),(FinMaccb_scl33(dbig:dend)),'.r','MarkerSize',10)
ylim([yliml ylimu])
title (['GRACE B radial']);
grid on
saveas(gcf,[filepathNeda,'plots/20',year,'/',itr,'_scaled0finm',year,'B'],'png')
 
 
% hold on
% plot(datetime(acc_day(dbig:dend)),(acca_scl33(dbig:dend)),'.g','MarkerSize',10)
% %ylim([-1 2])
% legend('along-track','cross-track','radial');
% %legend('11','22','33');
% title ([stepname,itr,' GRACE A scale factor']);
% grid on
% saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'_scale',year,'A'],'png')
% %B
% figure
% plot(datetime(acc_day(dbig:dend)),(accb_scl11(dbig:dend)),'.r','MarkerSize',10)
% hold on
% plot(datetime(acc_day(dbig:dend)),(accb_scl22(dbig:dend)),'.b','MarkerSize',10)
% hold on
% plot(datetime(acc_day(dbig:dend)),(accb_scl33(dbig:dend)),'.g','MarkerSize',10)
% %ylim([-2 2])
% legend('along-track','cross-track','radial');
% title ([stepname,itr,' GRACE B scale factor']);
% grid on
% saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'_scale',year,'B'],'png')
