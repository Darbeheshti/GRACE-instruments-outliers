clear all
close all
format longg;
year='11';month='09';%month={'02','03','04','05','07','08','09','10','11','12'};
sid='A';
id='a';
maxd=30;%30 sep, 31 oct
lday=176;
uday=208;
%176:208;% sep
%209:235;% oct
filepath=['/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/res20',year,'/'];
filepathNeda='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/';
itr='3par';
stepname='FinM';%d0 or FinM
%% extract F107 for a month
load('F107_2000_2015.mat');%  part of DTM2013
time_dtm=datetime(F107Pmat(:,1),F107Pmat(:,2),F107Pmat(:,3));
ltime=round((str2num(year)+(str2num(month)-1)/12)*365);
utime=round((str2num(year)+str2num(month)/12)*365);
%% scale for a year
file=[filepath,stepname,itr,year,id,'_scl11'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_scl11=datacell{1,2}(:,2);
acc_day=datacell{1,3}(:,4);% the time just once
% %%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,id,'_scl22'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_scl22=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,id,'_scl33'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_scl33=datacell{1,2}(:,2);
%% AHK temperature for a month
d=[1:maxd];
head_no=50;%different header ,42 for 200701
sec2hor=3600*24;
mtime_hour=[];
%mahkt1=[];
%mahkt2=[];
mahkt3=[];
%mahkt4=[];
for dn=1:length(d)
    %for dn=1:1
ds = sprintf('%02d',d(dn));
% load AHK data
%GRACE A
file = [filepath,'AHK1B_20',year,'-',month,'-',ds,'_',sid,'_02.asc'];
FID=fopen(file);
datacella = textscan(FID, '%f%f%s%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f', 'HeaderLines', head_no, 'CollectOutput', 1);
fclose(FID);
ahkb = datacella{3};
time_=datacella{1}(:,1);
% ahkt1=ahkb(:,11);
% ahkt2=ahkb(:,12);
ahkt3=ahkb(:,13);
mean_ahkt3(dn)=mean(rmmissing(ahkt3));
%ahkt4=ahkb(:,17);
% mahkt1=[mahkt1; ahkt1];
% mahkt2=[mahkt2; ahkt2];
mahkt3=[mahkt3; ahkt3];
% mahkt4=[mahkt4; ahkt4];
mtime_hour=[mtime_hour;time_];
clear  datacella time_ ahkb  ahkt3 
end
%% plots sacle factor
figure
subplot(3,1,1)
plot(datetime(acc_day(lday:uday)),(acca_scl11(lday:uday)),'.r','MarkerSize',15)
ylabel('$[]$','Interpreter','latex');
% hold on
% plot(datetime(acc_day(lday:uday)),(acca_scl22(lday:uday)),'.b','MarkerSize',15)
% hold on
% plot(datetime(acc_day(lday:uday)),(acca_scl33(lday:uday)),'.g','MarkerSize',15)
%ylim([-1 2])
%legend('along-track','cross-track','radial');
%legend('11','22','33');
title ([stepname,itr,' GRACE A along-track scale factor']);
grid on
% plots teperature
mtime_hour=mtime_hour-mtime_hour(1);
mtime_hour=mtime_hour/sec2hor;
subplot(3,1,2)
%plot(mtime_hour,mahkt2,'.','color','g');
hold on
plot(mtime_hour,mahkt3,'.','color',[.5 .5 .5]);
% hold on
% plot(mtime_hour,mahkt4,'.','color','k');
ylabel('$temperature[^{\circ} C]$','Interpreter','latex');
xlim([1 31])
%ylim([10 60])
title ({['20',year,' ',month,' ',sid]});
grid on
% plots f10.7
subplot(3,1,3)
plot(time_dtm(ltime:utime),F107Pmat(ltime:utime,4),'color',[.5 .5 .5],'MarkerSize',15)
ylabel('$[sfu]$','Interpreter','latex');
title('F10.7');
grid on
saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'temp_sfu_scale3subs',year,month,sid],'png')
%% two sided plot
figure
subplot(2,1,1)
yyaxis left
plot(mean_ahkt3,'color',[.5 .5 .5],'MarkerSize',15)
ylabel('$temperature[^{\circ} C]$','Interpreter','latex');
yyaxis right
plot((acca_scl11(lday:uday)),'.r','MarkerSize',15)
ylabel('$s_x$ (along)[-]','Interpreter','latex');
grid on
ax = gca;
ax.YAxis(1).Color = [.5 .5 .5];
ax.YAxis(2).Color = 'r';
xlim([1 31])
title ({['20',year,' ',month,' ',sid]});
%
subplot(2,1,2)
yyaxis left
plot(F107Pmat(ltime:utime,4),'color',[.5 .5 .5],'MarkerSize',15)
ylabel('$[sfu]$','Interpreter','latex');
yyaxis right
plot((acca_scl11(lday:uday)),'.r','MarkerSize',15)
ylabel('$s_x$ (along)[-]','Interpreter','latex');
grid on
ax = gca;
ax.YAxis(1).Color = [.5 .5 .5];
ax.YAxis(2).Color = 'r';
xlim([1 31])
saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'temp_sfu_scale2subs',year,month,sid],'png')
