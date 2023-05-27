clear all
close all
format longg;
year='11';
filepath=['/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/res20',year,'/'];
filepathNeda='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/';

itr='3par';
stepname='FinM';%d0 or FinM
rNeda = 0.6378137000E+07; 
%% orbit
file=[filepath,'d0',itr,year,'C_betap'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%f%f%f%f%f%s', 'CollectOutput', 1);
fclose(FID);
acca_betap  =datacell{1,2}(:,4);
acca_ascnode=datacell{1,2}(:,5);
% %%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'a_A'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_A=datacell{1,2}(:,2);
acc_day=datacell{1,3}(:,4);% the time just once
% %%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'a_E'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_E=datacell{1,2}(:,2);
% %%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'a_I'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_I=datacell{1,2}(:,2);
% %%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'a_NODE'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_NODE=datacell{1,2}(:,2);
% %%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'a_Perigee'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_Perigee=datacell{1,2}(:,2);
% %%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'a_Latitude'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_Latitude=datacell{1,2}(:,2);
%%  ACC%%%%%%%%%%%%%%%
file=[filepath,stepname,itr,year,'a_GAMMA'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_GAMMA=datacell{1,2}(:,2);
acc_day=datacell{1,3}(:,4);% the time just once
%%  %%%%%%%%%%%%%%%%%%%%%%%%plots
msize=7;
mcolor=[.5 .5 .5];
figure
subplot(4,2,1)
plot(datetime(acc_day),(acca_A-rNeda)/1000,'.','color',mcolor,'MarkerSize',msize)
title ([stepname,itr,' GRACE A']);
ylabel('$Altitude[km]$','Interpreter','latex');
subplot(4,2,2)
plot(datetime(acc_day),acca_E,'.','color',mcolor,'MarkerSize',msize)
title (['orbital elements']);
ylabel('$E[]$','Interpreter','latex');
subplot(4,2,3)
plot(datetime(acc_day),acca_I,'.','color',mcolor,'MarkerSize',msize)
ylabel('$I[asec]$','Interpreter','latex');
subplot(4,2,4)
plot(datetime(acc_day),acca_NODE,'.','color',mcolor,'MarkerSize',msize)
ylabel('$NODE[asec]$','Interpreter','latex');
subplot(4,2,5)
plot(datetime(acc_day),acca_Perigee,'.','color',mcolor,'MarkerSize',msize)
ylabel('$Perigee[asec]$','Interpreter','latex');
subplot(4,2,6)
plot(datetime(acc_day),acca_Latitude,'.','color',mcolor,'MarkerSize',msize)
ylabel('$Latitude[asec]$','Interpreter','latex');
subplot(4,2,7)
plot(acca_betap,'.','color',mcolor,'MarkerSize',msize)
ylabel('$\beta[\circ]$','Interpreter','latex');
subplot(4,2,8)
plot(acca_ascnode,'.','color',mcolor,'MarkerSize',msize)
ylabel('$Ascnode[\circ]$','Interpreter','latex');
saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'orbit',year,'A'],'png')
%
figure
yyaxis left
plot(datetime(acc_day),acca_betap,'.','color',[.5 .5 .5],'MarkerSize',msize)
ylim([-90 90])
ylabel('$\beta[\circ]$','Interpreter','latex');
yyaxis right
plot(datetime(acc_day),acca_GAMMA,'.g','MarkerSize',10)
ylim([-1 1])
ylabel('$ sheer \quad parameter-\gamma[rad]$','Interpreter','latex');
title ([stepname,itr,' GRACE A ']);
grid on
ax = gca;
ax.YAxis(1).Color = [.5 .5 .5];
ax.YAxis(2).Color = 'g';
saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'_gammabetap',year,'A'],'png')
%
figure
yyaxis left
plot(datetime(acc_day),(acca_A-rNeda)/1000,'.','color',[.5 .5 .5],'MarkerSize',msize)
ylabel('$Altitude[km]$','Interpreter','latex');
yyaxis right
plot(datetime(acc_day),acca_GAMMA,'.g','MarkerSize',10)
ylim([-1 1])
ylabel('$ sheer \quad parameter-\gamma[rad]$','Interpreter','latex');
title ([stepname,itr, ' GRACE A']);
grid on
ax = gca;
ax.YAxis(1).Color = [.5 .5 .5];
ax.YAxis(2).Color = 'g';
saveas(gcf,[filepathNeda,'plots/20',year,'/',stepname,itr,'_gammaaltitude',year,'A'],'png')
