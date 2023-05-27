clear all
close all
format longg;
year='14';
filepath=['/storage/research/aiub_u_camp/NEDA/OUT/'];
filepathNeda='/storage/research/aiub_u_camp/NEDA/OUT/';
itr='rl03b';
stepname='d0'; %just d0 here
%% A
file=[filepath,stepname,itr,year,'a_Radial'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%f%f%f%f%s%s%s', 'CollectOutput', 1);
fclose(FID);
a_Radial =datacell{1,2}(:,2);
mday  =datacell{1,3}(:,2);% the time just once
mtime =datacell{1,3}(:,3);% the time just once
% % %%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'a_Along'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%f%f%f%f%s%s%s', 'CollectOutput', 1);
fclose(FID);
a_Along =datacell{1,2}(:,2);
% % %%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'a_Out'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%f%f%f%f%s%s%s', 'CollectOutput', 1);
fclose(FID);
a_Out =datacell{1,2}(:,2);
%% B
file=[filepath,stepname,itr,year,'b_Radial'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%f%f%f%f%s%s%s', 'CollectOutput', 1);
fclose(FID);
b_Radial =datacell{1,2}(:,2);
% % %%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'b_Along'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%f%f%f%f%s%s%s', 'CollectOutput', 1);
fclose(FID);
b_Along =datacell{1,2}(:,2);
% % %%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'b_Out'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%f%f%f%f%s%s%s', 'CollectOutput', 1);
fclose(FID);
b_Out =datacell{1,2}(:,2);
% %%  %%%%%%%%%%%%%%%%%%%%%%%%plots
msize=5;
yliml=3*10^(-8);
% A
figure
subplot(3,1,1)
plot(datetime(mday ),a_Along,'.r','MarkerSize',msize)
ylabel('$Along[m/s^2]$','Interpreter','latex');
title ([stepname,itr,' GRACE A piecewise ACC 20',year]);
ylim([-yliml yliml])
subplot(3,1,2)
plot(datetime(mday ),a_Out,'.b','MarkerSize',msize)
ylim([-yliml yliml])
ylabel('$Cross[m/s^2]$','Interpreter','latex');
subplot(3,1,3)
plot(datetime(mday ),a_Radial,'.g','MarkerSize',msize)
ylim([-yliml yliml])
ylabel('$Radial[m/s^2]$','Interpreter','latex');
saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'_piecewise',year,'A'],'png')
% B
figure
subplot(3,1,1)
plot(datetime(mday ),b_Along,'.r','MarkerSize',msize)
title ([stepname,itr,' GRACE B piecewise ACC 20',year]);
ylabel('$Along[m/s^2]$','Interpreter','latex');
ylim([-yliml yliml])
subplot(3,1,2)
plot(datetime(mday),b_Out,'.b','MarkerSize',msize)
ylim([-yliml yliml])
ylabel('$Cross[m/s^2]$','Interpreter','latex');
subplot(3,1,3)
plot(datetime(mday ),b_Radial,'.g','MarkerSize',msize)
ylim([-yliml yliml])
ylabel('$Radial[m/s^2]$','Interpreter','latex');
saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'_piecewise',year,'B'],'png')

%% test for a portion of a year
date_v = datevec(datetime(mday));
time_v = datevec(datetime(mtime));
mdatetime=datetime(date_v(:,1),date_v(:,2),date_v(:,3),time_v(:,4),time_v(:,5),time_v(:,6));
% these two are identical
% figure
% plot(mdatetime,a_Radial,'.g','MarkerSize',msize)
% 
% figure
% plot(datetime(mday),a_Radial,'.g','MarkerSize',msize)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% test for sep2011
% tstart = datenum(2011,9,1,0,0,0);
% tend   = datenum(2011,9,1,23,59,59);
% %
% figure
% plot(datenum(mdatetime),a_Radial,'.g','MarkerSize',10)
% ylabel('$Radial[m/s^2]$','Interpreter','latex');
% xlim([tstart tend]);
% title ([stepname,itr,' GRACE A piecewise ACC','(2011,9,1)']);

% test for oct2011
% tstart = datenum(2011,9,1,0,0,0);
% tend   = datenum(2011,10,31,23,59,59);
% %
% figure
% subplot(3,1,1)
% plot(datenum(mdatetime),a_Along,'.r','MarkerSize',msize)
% ylabel('$Along[m/s^2]$','Interpreter','latex');
% xlim([tstart tend]);
% title ([stepname,itr,' GRACE A piecewise ACC']);
% 
% subplot(3,1,2)
% plot(datenum(mdatetime),a_Out,'.b','MarkerSize',msize)
% ylabel('$Out[m/s^2]$','Interpreter','latex');
% xlim([tstart tend]);
% 
% subplot(3,1,3)
% plot(datenum(mdatetime),a_Radial,'.g','MarkerSize',msize)
% ylabel('$Radial[m/s^2]$','Interpreter','latex');
% xlim([tstart tend]);









