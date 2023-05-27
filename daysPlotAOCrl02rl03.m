%%Outlier detec tion for each day
%
% Written by Neda Darbeheshti, AIUB, 2020-12.
%%
clear all
close all
format longg;
fform='png';
year='06';
filepath3=['/storage/research/aiub_u_camp/NEDA/ORB/'];%'RL03'
filepath2=['/storage/research/aiub_data/DATAPOOL/LEO/GRACE/20',year,'/RL02/KBR/nonbz2/'];%'RL02'
filepathNeda=['/storage/research/aiub_u_camp/NEDA/OUT/'];
kbrid='GRC';%'GRCSth' for 2011,2016 & 2017 'GFO' for gfo
d=[264];
sec2hor=3600;
rbias=2.945168;
ds = sprintf('%03d',d);% %03d for day of the  year
% load KBR data RL03
    data_KBR3 = [filepath3,kbrid,year,ds,'0.KBR'];
    KBRB3 = readKBRion(data_KBR3);
    time3_=(KBRB3(:,1)-KBRB3(1,1))/sec2hor;
    ant_range3=(KBRB3(:,10))*10^(6);
% load KBR data RL02
    data_KBR2 = [filepath2,kbrid,year,ds,'0.KBR'];
    KBRB2 = readKBRion(data_KBR2);
    time2_=(KBRB2(:,1)-KBRB2(1,1))/sec2hor;
    ant_range2=(KBRB2(:,10))*10^(6);
 %% plots
%  treshl(1:length(ant_rate))=-1;
%  treshh(1:length(ant_rate))=+1;
%antena offset rate correction
figure
 plot(time2_,ant_range2,'.')
 hold on
 plot(time3_,ant_range3,'.')
 hold on
%  plot(time_,treshl,'color','r')
%  plot(time_,treshh,'color','r')
% plot(time_,treshl-2,'-b')
% plot(time_,treshh+2,'-b')
ylabel('$AOC[\mu m/s]$','Interpreter','latex');
xlabel('$Time$','Interpreter','latex');
title ({['  20',year,' ',ds]});
grid on
xlim([0 24]);
set(gca,'XTick',[0:2:24])
legend('RL02','RL03','Location','best')
saveas(gcf,[filepathNeda,'plots/20',year,'/antkbr_rls0203','_',year,ds],fform)
% ASD plot
figure
ASD_pw(ant_range2,.2,'ASD [$\mu m/s/ \sqrt{Hz}$]');
hold on
ASD_pw(ant_range3,.2,'ASD [$\mu m/s/ \sqrt{Hz}$]');
title ({['  20',year,' ',ds]});
legend('RL02','RL03','Location','best')
saveas(gcf,[filepathNeda,'plots/20',year,'/antkbrASD_rls0203','_',year,ds],fform)