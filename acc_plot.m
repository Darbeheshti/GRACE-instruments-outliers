%%Outlier detection for each day
%
% Written by Neda Darbeheshti, AIUB, 2020-12.
%%
clear all
close all
format longg;
filepath=['/storage/research/aiub_u_camp/NEDA/ORB/'];
filepathNeda='/storage/research/aiub_u_camp/NEDA/OUT/';
year='07';%month={'02','03','04','05','07','08','09','10','11','12'};
d=[ 20];
%d = [1:25,28:31];%01
%d = [32:60];%02
%d = [61:91];%03
%d = [127:152];%05
%d = [153:182];%06
%d = [183:211];%07
%d = [214:244];%08
%d = [244:273];%09 249 254 260 266
%d = [274:293,297,299:304];%10 eliminate from SES1110.SES 294 295 296 298
npoly=3;
hknots=4;
%acc_bias=29.3370*10^(-6);
%nos=6*3600; %hours*secondes
%nmin=96;
%time_pc=(15/60)*[1:96];
%rls='rl02';
%acct='GRCAc';%'GRCAT'
for dn=1:length(d)
    %for dn=1:1
ds = sprintf('%03d',d(dn));
%% load ACC file
%GRACE A
file = [filepath,'GRCAc',year,ds,'0.ACC'];
FID=fopen(file);
datacella = textscan(FID, '%f%f%f%f%f%f%f', 'HeaderLines', 9, 'CollectOutput', 1);
fclose(FID);
acca_lin = datacella{1};
time_houra=acca_lin(:,1)*24;
% acc_dx=acca_lin(:,2)-mean(acca_lin(:,2));
% acc_dy=acca_lin(:,3)-mean(acca_lin(:,3));
% acc_dz=acca_lin(:,4)-mean(acca_lin(:,4));
acc_dx=acca_lin(:,2);
acc_dy=acca_lin(:,3);
acc_dz=acca_lin(:,4);
%GRACE B
file = [filepath,'GRCBc',year,ds,'0.ACC'];%'c'
FID=fopen(file);
datacellb = textscan(FID, '%f%f%f%f%f%f%f', 'HeaderLines', 9, 'CollectOutput', 1);
fclose(FID);
accb_lin = datacellb{1};
time_hourb=accb_lin(:,1)*24;
bcc_dx=accb_lin(:,2);
bcc_dy=accb_lin(:,3);
bcc_dz=accb_lin(:,4);
%% polynomial fitting
% p_dx(dn,:) = polyfit(time_hour,acc_dx,npoly);
% p_dy(dn,:) = polyfit(time_hour,acc_dy,npoly);
% p_dz(dn,:) = polyfit(time_hour,acc_dz,npoly);
% polynomial evaluation
% y_dx = polyval(p_dx(dn,:),time_hour);
% y_dy = polyval(p_dy(dn,:),time_hour);
% y_dz = polyval(p_dz(dn,:),time_hour);
%% spline fitting
% sp_dx = spap2(hknots,npoly+1,time_hour,acc_dx); 
% sp_dy = spap2(hknots,npoly+1,time_hour,acc_dy); 
% sp_dz = spap2(hknots,npoly+1,time_hour,acc_dz); 
%% plots
% A
nmax=21600;%for first six hours
mm2nm=10^(6);
figure
subplot(3,1,1)
plot(time_houra(1:nmax),-acc_dx(1:nmax)*mm2nm,'.','color','r')
%ylim([-800 -300])
% hold on
% plot(time_hour,y_dx,'color','k')
% hold on
% fnplt(sp_dx,'y',[ time_hour(1) time_hour(end)])
ylabel('$x[mm/s^2]$','Interpreter','latex');
title ({['20',year,' ', ds,' A']});
grid on
%
subplot(3,1,2)
plot(time_houra(1:nmax),acc_dy(1:nmax)*mm2nm,'.','color','b')
%ylim([-40 100])
% hold on
% plot(time_hour,y_dy,'color','k')
% hold on
% fnplt(sp_dy,'y',[ time_hour(1) time_hour(end)])
ylabel('$y[mm/s^2]$','Interpreter','latex');
grid on
%
subplot(3,1,3)
plot(time_houra(1:nmax),acc_dz(1:nmax)*mm2nm,'.','color','g')
%ylim([-40 100])
% hold on
% plot(time_hour,y_dz,'color','k')
% hold on
% fnplt(sp_dz,'y',[ time_hour(1) time_hour(end)])
ylabel('$z[mm/s^2]$','Interpreter','latex');
grid on
saveas(gcf,[filepathNeda,'plots/20',year,'/iacc_xyz','_',year,ds],'png')
% B
% figure
% subplot(3,1,1)
% plot(time_hourb,bcc_dx,'.','color','r')
% ylabel('$x[mm/s^2]$','Interpreter','latex');
% title ({['20',year,' ', ds,' B']});
% grid on
% %
% subplot(3,1,2)
% plot(time_hourb,bcc_dy,'.','color','b')
% ylabel('$y[mm/s^2]$','Interpreter','latex');
% grid on
% %
% subplot(3,1,3)
% plot(time_hourb,bcc_dz,'.','color','g')
% ylabel('$z[mm/s^2]$','Interpreter','latex');
% grid on
% saveas(gcf,[filepathNeda,'plots/20',year,'/ibcc_xyz','_',year,ds],'png')
%
%clear datacellb  acca_lin accb_lin time_hour acc_dx acc_dy acc_dz bcc_dx bcc_dy bcc_dz %y_dx y_dy y_dz
end

%
% figure
% subplot(4,1,1)
% plot(d,p_dx(:,1),'.r','MarkerSize',10)
% hold on 
% plot(d,p_dy(:,1),'.b','MarkerSize',10)
% hold on 
% plot(d,p_dz(:,1),'.g','MarkerSize',10)
% ylabel('$p3$','Interpreter','latex');
% title ({['20',year,' ', month,' A', '      Bias']});
% grid on
% %
% subplot(4,1,2)
% plot(d,p_dx(:,2),'.r','MarkerSize',10)
% hold on 
% plot(d,p_dy(:,2),'.b','MarkerSize',10)
% hold on 
% plot(d,p_dz(:,2),'.g','MarkerSize',10)
% ylabel('$p2$','Interpreter','latex');
% %title ('       2bias');
% grid on
% %
% subplot(4,1,3)
% plot(d,p_dx(:,3),'.r','MarkerSize',10)
% hold on 
% plot(d,p_dy(:,3),'.b','MarkerSize',10)
% hold on 
% plot(d,p_dz(:,3),'.g','MarkerSize',10)
% ylabel('$p1$','Interpreter','latex');
% %title ('        1bias');
% grid on
% %
% subplot(4,1,4)
% plot(d,p_dx(:,4),'.r','MarkerSize',10)
% hold on 
% plot(d,p_dy(:,4),'.b','MarkerSize',10)
% hold on 
% plot(d,p_dz(:,4),'.g','MarkerSize',10)
% ylabel('$p0[m/s^2]$','Interpreter','latex');
% legend('x','y','z');
% %title ('       0bias');
% grid on
% saveas(gcf,[filepathNeda,'plots/20',year,'/bias4month','_',year,month],'png')