%%Outlier detection for each day
%
% Written by Neda Darbeheshti, AIUB, 2020-12.
%%
clear all
close all

format longg;

filepath='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/res2016/';
year='11';
month='09';
apriori='1rls';%0itr
itr='D0';%'D3';%'d3';
did='0';%0,a,b
%from resiRMS_plot
d=[ 249 254 255 260 266 284 ];
%d = [1  3  4  5   6  8 11  18  19  20  21  22];%1
%d = [32    35    38    39    40    44    45    47    48];%02
thrsh=3*10^(-2);%for plot
gapfilename= [filepath,'gapOrb',year,month];
for dn=1:length(d)
    %for dn=1:1
ds = sprintf('%03d',d(dn));
%% load GRACE A file  
file = [filepath,itr,'C',apriori,year,ds,did,'.RES'];
fileID = fopen(file);
input_a = textscan(fileID,'%f %f %f %f %f %f %f %f %s %f %f %f');
fclose(fileID);
fracga=cell2mat(input_a(:,1));
fracga= fracga/60;
xr_a=cell2mat(input_a(:,6));
ya_a=cell2mat(input_a(:,7));
zc_a=cell2mat(input_a(:,8));
TFxr_a = isoutlier(xr_a,'median');
TFya_a = isoutlier(ya_a,'median');
TFzc_a = isoutlier(zc_a,'median');
%% load GRACE B file  
file = [filepath,itr,'D',apriori,year,ds,did,'.RES'];
fileID = fopen(file);
input_b = textscan(fileID,'%f %f %f %f %f %f %f %f %s %f %f %f');
fclose(fileID);
fracgb=cell2mat(input_b(:,1));
fracgb= fracgb/60;
xr_b=cell2mat(input_b(:,6));
ya_b=cell2mat(input_b(:,7));
zc_b=cell2mat(input_b(:,8));
TFxr_b = isoutlier(xr_b,'median');
TFya_b = isoutlier(ya_b,'median');
TFzc_b = isoutlier(zc_b,'median');
%% gap for each day
totalgap=[fracga(TFxr_a) ;fracga(TFya_a) ;fracga(TFzc_a) ; fracgb(TFxr_b); fracgb(TFya_b); fracgb(TFzc_b)];
totalgap=sort(totalgap);
% writing in a file 
fid = fopen(gapfilename,'a+');
 for i =1: length(totalgap)
fprintf(fid,'%03d %f\r\n', d(dn),totalgap(i));  
 end
fclose(fid);
%% plots
figure
subplot(3,2,1)
plot(fracga,xr_a,'r.',fracga(TFxr_a),xr_a(TFxr_a),'kx','MarkerSize',10)
yline(-thrsh,'k','LineWidth',1);
yline(thrsh,'k','LineWidth',1);
grid on
ylabel('$Radial[m]$','Interpreter','latex');
title ({[' Year ',year,' Day ',ds],' A '});
%
subplot(3,2,3)
plot(fracga,ya_a,'g.',fracga(TFya_a),ya_a(TFya_a),'kx','MarkerSize',10)
yline(-thrsh,'k','LineWidth',1);
yline(thrsh,'k','LineWidth',1);
grid on
ylabel('$Along-track[m]$','Interpreter','latex');
%
subplot(3,2,5)
plot(fracga,zc_a,'b.',fracga(TFzc_a),zc_a(TFzc_a),'kx','MarkerSize',10)
yline(-thrsh,'k','LineWidth',1);
yline(thrsh,'k','LineWidth',1);
grid on
ylabel('$Cross-track[m]$','Interpreter','latex');
xlabel('Time [hour]');
%
subplot(3,2,2)
plot(fracgb,xr_b,'r.',fracgb(TFxr_b),xr_b(TFxr_b),'kx','MarkerSize',10)
yline(-thrsh,'k','LineWidth',1);
yline(thrsh,'k','LineWidth',1);
grid on
title ({[' Year ',year,' Day ',ds],' B '});
%
subplot(3,2,4)
plot(fracgb,ya_b,'g.',fracgb(TFya_b),ya_b(TFya_b),'kx','MarkerSize',10)
yline(-thrsh,'k','LineWidth',1);
yline(thrsh,'k','LineWidth',1);
grid on
%
subplot(3,2,6)
plot(fracgb,zc_b,'b.',fracgb(TFzc_b),zc_b(TFzc_b),'kx','MarkerSize',10)
yline(-thrsh,'k','LineWidth',1);
yline(thrsh,'k','LineWidth',1);
grid on
xlabel('Time [hour]');
%save the plots
saveas(gcf,[filepath,'plots/','orbitsOutlier',itr,apriori,'_',year,ds,did],'png')
clear xr_a xr_b ya_a ya_b zc_a zc_b TFxr_a Txr_b TFya_a TFya_b TFzc_a TFzc_b input_a input_b fracga fracgb totalgap
end
