%%Outlier detection for each month
% like Klinger thesis 2018
% Written by Neda Darbeheshti, AIUB, 2021-05. For SEDNA:
%%
clear all
close all
format longg;
fform='png';
year='07';%07
filepath=['/storage/research/aiub_u_camp/NEDA/ORB/'];
filepathNeda=['/storage/research/aiub_u_camp/NEDA/OUT/'];
month='1';d = [1:180];
% 2002 '04';d = [94:117 119:120]; '09';d = [244:273];        
%      '10';d = [274:304];        '11';d = [305:334];
% 2003 '04';d = [92: 120];        '05';d = [121:151]; 
% 2006 '06';d = [152:181];        '09';d = [244:265 267:273] 
macc_dx=[];
macc_dy=[];
macc_dz=[];
mbcc_dx=[];
mbcc_dy=[];
mbcc_dz=[];
mtimea_hour=[];
mtimeb_hour=[];
nano=10^(3);
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
time_a=d(dn)+acca_lin(:,1);
acc_dx=acca_lin(:,2)*nano;
acc_dy=acca_lin(:,3)*nano;
acc_dz=acca_lin(:,4)*nano;
%GRACE B
file = [filepath,'GRCBc',year,ds,'0.ACC'];
FID=fopen(file);
datacellb = textscan(FID, '%f%f%f%f%f%f%f', 'HeaderLines', 9, 'CollectOutput', 1);
fclose(FID);
accb_lin = datacellb{1};
time_b=d(dn)+accb_lin(:,1);
bcc_dx=accb_lin(:,2)*nano;
bcc_dy=accb_lin(:,3)*nano;
bcc_dz=accb_lin(:,4)*nano;
%accumulate for a month
macc_dx=[macc_dx; acc_dx];
macc_dy=[macc_dy; acc_dy];
macc_dz=[macc_dz; acc_dz];
%
mbcc_dx=[mbcc_dx; bcc_dx];
mbcc_dy=[mbcc_dy; bcc_dy];
mbcc_dz=[mbcc_dz; bcc_dz];
%
mtimea_hour=[mtimea_hour;time_a];
mtimeb_hour=[mtimeb_hour;time_b];
clear datacella datacellb acca_lin accb_lin time_ acc_dx acc_dy acc_dz bcc_dx bcc_dy bcc_dz 
end
%subtract median 
%A
% macc_dx=macc_dx-median(macc_dx);
% macc_dy=macc_dy-median(macc_dy);
% macc_dz=macc_dz-median(macc_dz);
% %B
% mbcc_dx=mbcc_dx-median(mbcc_dx);
% mbcc_dy=mbcc_dy-median(mbcc_dy);
% mbcc_dz=mbcc_dz-median(mbcc_dz);
%% plots
figure
plot(mtimea_hour,macc_dx,'.','color','r')
hold on
plot(mtimea_hour,macc_dy,'.','color','b')
plot(mtimea_hour,macc_dz,'.','color','g')
ylabel('$ACC[\mu m/s^2]$','Interpreter','latex');
xlabel('$Day$','Interpreter','latex');
title ({[' GRACE A 20',year,' ',month]});
grid on
legend('along','cross','radial');
xlim([min(d) max(d)]);
set(gca,'XTick',[min(d):2:max(d)])
saveas(gcf,[filepathNeda,'plots/20',year,'/rawacc4month','_',year,month],fform)
figure
plot(mtimeb_hour,mbcc_dx,'.','color','r')
hold on
plot(mtimeb_hour,mbcc_dy,'.','color','b')
plot(mtimeb_hour,mbcc_dz,'.','color','g')
ylabel('$ACC[\mu m/s^2]$','Interpreter','latex');
xlabel('$Day$','Interpreter','latex');
title ({[' GRACE B 20',year,' ',month]});
grid on
legend('along','cross','radial');
xlim([min(d) max(d)]);
set(gca,'XTick',[min(d):2:max(d)])
saveas(gcf,[filepathNeda,'plots/20',year,'/rawbcc4month','_',year,month],fform)
