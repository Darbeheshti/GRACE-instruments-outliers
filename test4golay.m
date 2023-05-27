close all
clear all
%length (aoc_smooth)=199999
%file = ['/storage/research/aiub_u_camp/NEDA/OUT/','qKbtest06',ds,'0.OUT'];
year='17';
rls='RL03';
d=115;%060010,171150
sec2hor=3600;
ds = sprintf('%03d',d);% %03d for day of the  year

data_KBR = ['/storage/research/aiub_u_camp/NEDA/ORB/GRCSth',year,ds,'.KBR'];%GRCSth'
KBRB = readKBRion(data_KBR);
time_=(KBRB(:,1)-KBRB(1,1))/sec2hor;
ant_rate=KBRB(:,10)*10^(6);

no_head=18;%18 4;
filesmooth = ['/storage/research/aiub_u_camp/NEDA/OUT/qKbtest',year,ds,'.OUT'];
FID=fopen(filesmooth);                                    
datacellsmooth = textscan(FID, '%f', 'HeaderLines', no_head, 'CollectOutput', 1);
fclose(FID);

aoc_smooth = datacellsmooth{1,1};
aoc_smooth=aoc_smooth*10^(6);

figure
plot (time_,ant_rate,'b.')
hold on 
plot (time_,ant_rate,'b-')
hold on 
plot(time_,aoc_smooth(1:length(ant_rate)),'r.')
hold on 
plot(time_,aoc_smooth(1:length(ant_rate)),'r-')
ylabel('$AOC[\mu m/s]$','Interpreter','latex');
xlabel('$Time$','Interpreter','latex');
legend('original','smooth');
title ({[rls, '  20',year,' ',ds]});
grid on
xlim([0 1]);