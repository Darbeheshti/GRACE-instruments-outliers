%%Outlier detection for each day
%
% Written by Neda Darbeheshti, AIUB, 2022-05.
%%
clear all
close all
format longg;
filepath=['/storage/research/aiub_u_camp/NEDA/ORB/'];
filepathNeda=['/storage/research/aiub_u_camp/NEDA/OUT/'];
year='07';
d=20;
id='T';%c
%d=[ 249 254 255 260 266 270 284 ];
%d = [1:25,28:31];%01
%d = [32:60];%02
%d = [61:91];%03
%d = [127:152];%05    128                :size a and b differ 
%d = [153:182];%06    159 177 179
%d = [183:211];%07
%d = [215:244];%08     214
%d = [244:273];%09 
%d = [274:293,297,299:304];%10 eliminate from SES1110.SES 294 295 296 298
for dn=1:length(d)
ds = sprintf('%03d',d(dn));
%% load ACC file
%GRACE A
file = [filepath,'GRCA',id,year,ds,'.ACC'];
FID=fopen(file);
datacella = textscan(FID, '%f%f%f%f%f%f%f', 'HeaderLines', 9, 'CollectOutput', 1);
fclose(FID);
acca_lin = datacella{1};
%GRACE B
file = [filepath,'GRCB',id,year,ds,'.ACC'];%'c'
FID=fopen(file);
datacellb = textscan(FID, '%f%f%f%f%f%f%f', 'HeaderLines', 9, 'CollectOutput', 1);
fclose(FID);
accb_lin = datacellb{1};
%%%%%%%%%%%%%
time_hour=acca_lin(:,1)*24;
%diff
acc_dx=acca_lin(:,2)-mean(acca_lin(:,2));
acc_dy=acca_lin(:,3)-mean(acca_lin(:,3));
acc_dz=acca_lin(:,4)-mean(acca_lin(:,4));
acc_dx=-acc_dx*1000;
acc_dy= acc_dy*1000;
acc_dz=-acc_dz*1000;
%
bcc_dx=accb_lin(:,2)-mean(accb_lin(:,2));
bcc_dy=accb_lin(:,3)-mean(accb_lin(:,3));
bcc_dz=accb_lin(:,4)-mean(accb_lin(:,4));
bcc_dx=-bcc_dx*1000;
bcc_dy= bcc_dy*1000;
bcc_dz=-bcc_dz*1000;
% %diff shift
sshift=28;
acc_dsx=-acc_dx(sshift+1:end)+bcc_dx(1:end-sshift);
acc_dsy=-acc_dy(sshift+1:end)+bcc_dy(1:end-sshift);
acc_dsz=-acc_dz(sshift+1:end)+bcc_dz(1:end-sshift);
%% plots
%%%%%%%%%%%%%%%% 
yliml=0.05;
xliml=1;
figure
subplot(3,1,1)
plot(time_hour,-acc_dx,'.','color','k')%[0 0 icolor(dn)]
% hold on
% plot(time_hour,-bcc_dz,'.','color',[0 .7 .7])%[0 0 icolor(dn)]
hold on
plot(time_hour(sshift+1:end),-acc_dsx,'.','color',[.5 .5 .5])
ylabel('$R[\mu m/s^2]Z$','Interpreter','latex');
xlim([4*xliml 7*xliml])
ylim([-yliml yliml])
grid on
%legend('A','B','B-A');
%
title ({['20',year, ' ',ds]});
subplot(3,1,2)
plot(time_hour,acc_dy,'.','color','k')%[0 0 icolor(dn)]
% hold on
% plot(time_hour,-bcc_dy,'.','color','m')%[0 0 icolor(dn)]
hold on
plot(time_hour(sshift+1:end),acc_dsy,'.','color',[.5 .5 .5])
ylabel('$S[\mu m/s^2]X$','Interpreter','latex');
xlim([4*xliml 7*xliml])
ylim([-yliml yliml])
grid on
%legend('A','B','B-A');
%
subplot(3,1,3)
plot(time_hour,-acc_dz,'.','color','k')%[0 0 icolor(dn)]
% hold on
% plot(time_hour,bcc_dx,'.','color','c')%[0 0 icolor(dn)]
hold on
plot(time_hour(sshift+1:end),-acc_dsz,'.','color',[.5 .5 .5])
ylabel('$W[\mu m/s^2]Y$','Interpreter','latex');
xlim([4*xliml 7*xliml])
ylim([-yliml yliml])
grid on
%legend('A','B','B-A');
%
saveas(gcf,[filepathNeda,'plots/20',year,'/abcc_xyz','_',year,ds],'png')
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
clear datacella datacellb acca_lin accb_lin acc_dx acc_dy acc_dz bcc_dx bcc_dy bcc_dz acc_dsx acc_dsy acc_dsz
end






