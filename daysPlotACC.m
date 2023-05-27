%%Outlier detection for each day
%
% Written by Neda Darbeheshti, AIUB, 2020-12.
%%
%07A 17 18 19 20 
%07B 4 11 12 13 14
%06 from /gracetools-master/plotting/aiub_plotting/AIUB_AIUB-RL02_90_unfiltered/website 14,16,17 june    12,17,26 sep 
%06 165 166 167 168
clear all
close all
format longg;
filepath=['/storage/research/aiub_u_camp/NEDA/ORB/'];
filepathNeda='/storage/research/aiub_u_camp/NEDA/OUT/';
year='06';
d=[263];%262 %269 272 275 276 278 281 290 299 301 304 317 320 335:345  357 358 359
micro=10^(3);
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
% acc_dx=acca_lin(:,2)-median(acca_lin(:,2));
% acc_dy=acca_lin(:,3)-median(acca_lin(:,3));
% acc_dz=acca_lin(:,4)-median(acca_lin(:,4));
acc_dx=acca_lin(:,2)*micro;
acc_dy=acca_lin(:,3)*micro;
acc_dz=acca_lin(:,4)*micro;
%GRACE B
file = [filepath,'GRCBc',year,ds,'0.ACC'];
FID=fopen(file);
datacellb = textscan(FID, '%f%f%f%f%f%f%f', 'HeaderLines', 9, 'CollectOutput', 1);
fclose(FID);
accb_lin = datacellb{1};
time_hourb=accb_lin(:,1)*24;
% bcc_dx=accb_lin(:,2)-median(accb_lin(:,2));
% bcc_dy=accb_lin(:,3)-median(accb_lin(:,3));
% bcc_dz=accb_lin(:,4)-median(accb_lin(:,4));
bcc_dx=accb_lin(:,2)*micro;
bcc_dy=accb_lin(:,3)*micro;
bcc_dz=accb_lin(:,4)*micro;
%% plots
% A
figure
plot(time_houra,acc_dx,'.','color','r')
ylabel('$ACC[\mu m/s^2]$','Interpreter','latex');
title ({[' GRACE A 20',year,' ',ds]});
hold on
plot(time_houra,acc_dy,'.','color','b')
plot(time_houra,acc_dz,'.','color','g')
xlabel('$Time$','Interpreter','latex');
grid on
xlim([0 24]);
set(gca,'XTick',[0:2:24])
legend('x','y','z','Location','best');
saveas(gcf,[filepathNeda,'plots/20',year,'/iacc_xyz','_',year,ds],'png')
% B
figure
plot(time_hourb,bcc_dx,'.','color','r')
ylabel('$ACC[\mu m/s^2]$','Interpreter','latex');
title ({[' GRACE B 20',year,' ',ds]});
hold on
plot(time_hourb,bcc_dy,'.','color','b')
plot(time_hourb,bcc_dz,'.','color','g')
xlabel('$Time$','Interpreter','latex');
grid on
xlim([0 24]);
set(gca,'XTick',[0:2:24])
legend('x','y','z','Location','best');
%legend('along','cross','radial');
saveas(gcf,[filepathNeda,'plots/20',year,'/ibcc_xyz','_',year,ds],'png')
%
clear datacellb  acca_lin accb_lin time_hour acc_dx acc_dy acc_dz bcc_dx bcc_dy bcc_dz %y_dx y_dy y_dz
end

