%%This program detects outliers in annual AOC file.
% and creats one AOC outlier file for a year.
%
% Written by Neda Darbeheshti, AIUB, 2021-11.
%%
clear all
close all
format longg;
year='17';
%extraday=1; just correctd for 2007
extraday=1; %2002 starts from day 94  %2015 starts from day 13
file_id='AOC';
filepath=['/storage/research/aiub_u_camp/NEDA/ORB/'];
filepathNeda=['/storage/research/aiub_u_camp/NEDA/OUT/'];
sec2hor=3600*24;
%% load and modification
AOC4year=load([filepath,file_id,year]);
%
AOC4year(:,1)=AOC4year(:,1)-AOC4year(1,1);
AOC4year(:,1)=AOC4year(:,1)/sec2hor;
% if begining of the yaer is not day 1
AOCtime=AOC4year(:,1)+extraday;
AOCrate=AOC4year(:,2)*10^(6);
%% find the outliers
thresholdValue=3;
outlierIndexes = abs(AOCrate) > thresholdValue;
%% write outliers epoch in a file
outlierTime=AOCtime(outlierIndexes);
% writing in a file 
outlierfilename= [filepath,'outlier',file_id,year];
fid = fopen(outlierfilename,'w');
 for i =1: length(outlierTime)
fprintf(fid,'%f\n',outlierTime(i));  
 end
fclose(fid);
outlierLength=num2str(round(length(outlierTime)*5/3600));
%% plot
figure
plot(AOCtime,AOCrate,'k.',AOCtime(outlierIndexes),AOCrate(outlierIndexes),'r.');
ylabel('$AOC[\mu m/s]$','Interpreter','latex');
xlabel('$Day$','Interpreter','latex');
grid on
title ({['  20',year,' ','Outlier length ',outlierLength,' hours']});
xlim([1 366]);
%ylim([-800 600]);
set(gca,'XTick',[1:30:366])
legend('AOC rate','outlier','Location','best')
saveas(gcf,[filepathNeda,'plots/20',year,'/aocOutlierYear','_',year],'png')








