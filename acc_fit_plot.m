%%Outlier detection for each day
%
% Written by Neda Darbeheshti, AIUB, 2020-12.
%%
clear all
close all
format longg;
filepath='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/res2016/';
filepathNeda='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/';
year='11';month='09';%month={'02','03','04','05','07','08','09','10','11','12'};
%d=[183 184];
d=270;
%d = [1:25,28:31];%01
%d = [32:60];%02
%d = [61:91];%03
%d = [127:152];%05    128                :size a and b differ 
%d = [153:182];%06    159 177 179
%d = [183:211];%07
%d = [215:244];%08     214
%d = [244:273];%09 
%d = [274:293,297,299:304];%10 eliminate from SES1110.SES 294 295 296 298
npoly=3;
for dn=1:length(d)
ds = sprintf('%03d',d(dn));
%% load ACC file
%GRACE A
file = [filepath,'GRCAc',year,ds,'.ACC'];
FID=fopen(file);
datacella = textscan(FID, '%f%f%f%f%f%f%f', 'HeaderLines', 9, 'CollectOutput', 1);
fclose(FID);
acca_lin = datacella{1};
%GRACE B
file = [filepath,'GRCBc',year,ds,'.ACC'];%'c'
FID=fopen(file);
datacellb = textscan(FID, '%f%f%f%f%f%f%f', 'HeaderLines', 9, 'CollectOutput', 1);
fclose(FID);
accb_lin = datacellb{1};
%%%%%%%%%%%%%
time_hour=acca_lin(:,1)*24;
%diff
acc_dx=acca_lin(:,2)-accb_lin(:,2);
acc_dy=acca_lin(:,3)-accb_lin(:,3);
acc_dz=acca_lin(:,4)-accb_lin(:,4);
% %polynomial fitting
p_dx = polyfit(time_hour,acc_dx,npoly);
p_dy = polyfit(time_hour,acc_dy,npoly);
p_dz = polyfit(time_hour,acc_dz,npoly);
% polynomial evaluation
y_dx = polyval(p_dx,time_hour);
y_dy = polyval(p_dy,time_hour);
y_dz = polyval(p_dz,time_hour);
% %diff shift
% acc_dsx=acca_lin(31:end,2)-accb_lin(1:end-30,2);
% acc_dsy=acca_lin(31:end,3)-accb_lin(1:end-30,3);
% acc_dsz=acca_lin(31:end,4)-accb_lin(1:end-30,4);
%% plots
%%%%%%%%%%%%%%%% A-B and fitting
figure
subplot(3,1,1)
plot(time_hour,acc_dx,'.','color','r')%[0 0 icolor(dn)]
hold on
plot(time_hour,y_dx,'.','color','y')
ylabel('$x[mm/s^2]$','Interpreter','latex');
grid on
title ({['20',year, ' ',ds,' degree ',num2str(npoly)]});
%
subplot(3,1,2)
plot(time_hour,acc_dy,'.','color','b')%[0 0 icolor(dn)]
hold on
plot(time_hour,y_dy,'.','color','y')
ylabel('$y[mm/s^2]$','Interpreter','latex');
grid on
%
subplot(3,1,3)
plot(time_hour,acc_dz,'.','color','g')%[0 0 icolor(dn)]
hold on
plot(time_hour,y_dz,'.','color','y')
ylabel('$z[mm/s^2]$','Interpreter','latex');
grid on
saveas(gcf,[filepathNeda,'plots/20',year,'/poly_acc_xyz','_',year,ds],'png')
%%%%%%%%%%%%%%%% 30s shift plot A-B
% figure
% subplot(3,1,1)
% plot(time_hour(1:end-30),acc_dsx,'.','color','r')
% ylabel('$x[mm/s^2]$','Interpreter','latex');
% legend('A-B');
% grid on
% title ({['20',year, ' ',ds]});
% %
% subplot(3,1,2)
% plot(time_hour(1:end-30),acc_dsy,'.','color','b')
% ylabel('$y[mm/s^2]$','Interpreter','latex');
% grid on
% legend('A-B');
% %
% subplot(3,1,3)
% plot(time_hour(1:end-30),acc_dsz,'.','color','g')
% ylabel('$z[mm/s^2]$','Interpreter','latex');
% grid on
% legend('A-B');
%
clear datacella datacellb acca_lin accb_lin acc_dx acc_dy acc_dz p_dx p_dy p_dz y_dx y_dy y_dz
end





%icolor=[0:30]/30;%icolor = (b-a).*rand(31,1) + a;
%icolor=[.5 .7];
% for i=1:length(d)
% fieldi{i}=num2str(d);
% end
%legend([fieldi])
% plot(acca_lin(:,1)*24,acca_lin(:,3)-accb_lin(:,3),'b.')
% ylabel('$y[mm/s^2]$','Interpreter','latex');
% grid on
% legend('A-B');
% plot(acca_lin(:,1)*24,acca_lin(:,4)-accb_lin(:,4),'g.')
% ylabel('$z[mm/s^2]$','Interpreter','latex');
% grid on
% legend('A-B');
