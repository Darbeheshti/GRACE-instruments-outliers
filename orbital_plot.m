clear all
close all
format longg;
filepath='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/res2016/';
filepathNeda='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/';
year='11';
itr='3par';
stepname='FinM';%d0 or FinM
rNeda = 0.6378137000E+07; 
%% A
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
%% B
% file=[filepath,'d0',itr,year,'D_betap'];
% FID=fopen(file);
% datacell = textscan(FID, '%s%s%s%s%f%f%f%f%f%s', 'CollectOutput', 1);
% fclose(FID);
% accb_betap  =datacell{1,2}(:,4);
% accb_ascnode=datacell{1,2}(:,5);
%%  %%%%%%%%%%%%%%%%%%%%%%%%plots
msize=5;
subplot(4,2,1)
plot(datetime(acc_day),(acca_A-rNeda)/1000,'b','MarkerSize',msize)
ylabel('$Altitude[km]$','Interpreter','latex');
subplot(4,2,2)
plot(datetime(acc_day),acca_E,'b','MarkerSize',msize)
ylabel('$E[]$','Interpreter','latex');
subplot(4,2,3)
plot(datetime(acc_day),acca_I,'b','MarkerSize',msize)
ylabel('$I[asec]$','Interpreter','latex');
subplot(4,2,4)
plot(datetime(acc_day),acca_NODE,'.b','MarkerSize',msize)
ylabel('$NODE[asec]$','Interpreter','latex');
subplot(4,2,5)
plot(datetime(acc_day),acca_Perigee,'b','MarkerSize',msize)
ylabel('$Perigee[asec]$','Interpreter','latex');
subplot(4,2,6)
plot(datetime(acc_day),acca_Latitude,'b','MarkerSize',msize)
ylabel('$Latitude[asec]$','Interpreter','latex');
subplot(4,2,7)
plot(acca_betap,'.b','MarkerSize',msize)
ylabel('$\beta[\circ]$','Interpreter','latex');
subplot(4,2,8)
plot(acca_ascnode,'.b','MarkerSize',msize)
ylabel('$Ascnode[\circ]$','Interpreter','latex');
 
