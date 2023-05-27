%%Outlier detection for each day
%
% Written by Neda Darbeheshti, AIUB, 2021-05. For SEDNA:
% these plots are like Uli`s plot
%%
clear all
close all
format longg;
fform='ps';
%year='11';%month={'02','03','04','05','07','08','09','10','11','12'};
%year='12' ;%month={'01','02','03','04','06','07','08','09','11','12'};
year='07';
%year='16' ;%month={'01','02','03','04','06','07','08','09','11','12'};
%year='17' ;%month={'01','03','04','05','06'};
filepath=['/storage/research/aiub_u_camp/NEDA/ORB/'];
filepathNeda=['/storage/research/aiub_u_camp/NEDA/OUT/'];
%%%%%%%%%%%%%%%%%%%2011
%d = [1:25,28:31];%01 %d = [32:60];%02 %d = [61:91];%03 %d = [127:152];%05 %d = [153:182];%06
%d = [183:211];%07 %d = [214:244];%08 d = [244:273];%09 249 254 260 266
%d = [274:293,297,299:304];%10 eliminate from SES1110.SES 294 295 296 298
%%%%%%%%%%%%%%%%%%%2013
%d = [1:31];1301
%%%%%%%%%%%%%%%%%%%2016
%d = [318:335];1611 d = [339:366];1612
%%%%%%%%%%%%%%%%%%%2017 
%d = [1:31];1701 d = [76:90];%1703 d = [91:120];%1704 d = [121:151];%1705 d = [152:180];%1706
month='01';d = [1:31];
macc_dx=[];
macc_dy=[];
macc_dz=[];
mbcc_dx=[];
mbcc_dy=[];
mbcc_dz=[];
macc_dsx=[];
macc_dsy=[];
macc_dsz=[];
mtime_hour=[];
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
time_=d(dn)+acca_lin(:,1);
acc_dx=acca_lin(:,2)-mean(acca_lin(:,2));
acc_dy=acca_lin(:,3)-mean(acca_lin(:,3));
acc_dz=acca_lin(:,4)-mean(acca_lin(:,4));
acc_dx=-acc_dx*1000;
acc_dy= acc_dy*1000;
acc_dz=-acc_dz*1000;
%GRACE B
file = [filepath,'GRCBc',year,ds,'0.ACC'];%'c'
FID=fopen(file);
datacellb = textscan(FID, '%f%f%f%f%f%f%f', 'HeaderLines', 9, 'CollectOutput', 1);
fclose(FID);
accb_lin = datacellb{1};
bcc_dx=accb_lin(:,2)-mean(accb_lin(:,2));
bcc_dy=accb_lin(:,3)-mean(accb_lin(:,3));
bcc_dz=accb_lin(:,4)-mean(accb_lin(:,4));
bcc_dx=-bcc_dx*1000;
bcc_dy= bcc_dy*1000;
bcc_dz=-bcc_dz*1000;
% %diff shift
% sshift=28;
% acc_dsx=bcc_dx(sshift+1:end)-acc_dx(1:end-sshift);
% acc_dsy=bcc_dy(sshift+1:end)-acc_dy(1:end-sshift);
% acc_dsz=bcc_dz(sshift+1:end)-acc_dz(1:end-sshift);
% no shift 
acc_dsx=bcc_dx-acc_dx;
acc_dsy=bcc_dy-acc_dy;
acc_dsz=bcc_dz-acc_dz;
%% plots
macc_dx=[macc_dx; acc_dx];
macc_dy=[macc_dy; acc_dy];
macc_dz=[macc_dz; acc_dz];
%
macc_dsx=[macc_dsx; acc_dsx];
macc_dsy=[macc_dsy; acc_dsy];
macc_dsz=[macc_dsz; acc_dsz];
%
mtime_hour=[mtime_hour;time_];
clear datacella datacellb acca_lin accb_lin time_ acc_dx acc_dy acc_dz bcc_dx bcc_dy bcc_dz acc_dsx acc_dsy acc_dsz
end
figure
subplot(3,1,1)
plot(mtime_hour,macc_dz,'.','color','g')
hold on
plot(mtime_hour,macc_dsz,'.','color',[.5 .5 .5])
ylabel('$ax3[\mu m/s^2]Z$','Interpreter','latex');
legend('A','B-A');
title ({['20',year,' ',month]});
subplot(3,1,2)
plot(mtime_hour,macc_dx,'.','color','r')
hold on
plot(mtime_hour,macc_dsx,'.','color',[.5 .5 .5])
ylabel('$ax1[\mu m/s^2]X$','Interpreter','latex');
legend('A','B-A');
subplot(3,1,3)
plot(mtime_hour,macc_dy,'.','color','b')
hold on
plot(mtime_hour,macc_dsy,'.','color',[.5 .5 .5])
ylabel('$ax2[\mu m/s^2]Y$','Interpreter','latex');
legend('A','B-A');
grid on
saveas(gcf,[filepathNeda,'plots/20',year,'/rawamb_cc4month','_',year,month],fform)







