%%This code plots annual AOC which has been stored in one file.
%
% Written by Neda Darbeheshti, AIUB, 2020-12.
%%
clear all
close all
format longg;
year='15';
file_id='AOC';
filepath=['/storage/research/aiub_u_camp/NEDA/ORB/'];
filepathNeda=['/storage/research/aiub_u_camp/NEDA/OUT/'];
sec2hor=3600*24;
extraday=13;% 2002 starts from day 94 % 2015 starts from day 13
%% load and modification
AOC4year=load([filepath,file_id,year]);
%
AOC4year(:,1)=AOC4year(:,1)-AOC4year(1,1);
AOC4year(:,1)=AOC4year(:,1)/sec2hor;
% if begining of the yaer is not day 1
AOC4year(:,1)=AOC4year(:,1)+extraday;
AOC4year(:,2)=AOC4year(:,2)*10^(6);
%% plot
figure
plot(AOC4year(:,1),AOC4year(:,2),'.','color','k')
ylabel('$AOC[\mu m/s]$','Interpreter','latex');
xlabel('$Day$','Interpreter','latex');
grid on
title ({['  20',year,' ']});
xlim([1 366]);
%ylim([-800 600]);
set(gca,'XTick',[1:30:366])
saveas(gcf,[filepathNeda,'plots/20',year,'/aoc4year','_',year],'png')