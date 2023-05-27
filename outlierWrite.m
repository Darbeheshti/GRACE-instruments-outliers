%%This program takes output of outlierAOC.m 
%
% Written by Neda Darbeheshti, AIUB, 2021-11.
%%
clear all
close all
format longg;
year='06';
file_id='AOC';
filepath=['/storage/research/aiub_u_camp/NEDA/ORB/'];
filepathNeda=['/storage/research/aiub_u_camp/NEDA/OUT/'];
%% load 
yearOutlierAOC=load([filepath,'outlier',file_id,year]);
% outlier days
daysOutlierAOC=unique(fix(yearOutlierAOC));
% outlier hours
toleranceAOC = 0.001;
hourOutlierAOC = uniquetol(yearOutlierAOC,toleranceAOC);

yearOutlierACCxA=load([filepath,'outlier','ACCxA',year]);
yearOutlierACCyA=load([filepath,'outlier','ACCyA',year]);
yearOutlierACCzA=load([filepath,'outlier','ACCzA',year]);
yearOutlierACCxB=load([filepath,'outlier','ACCxB',year]);
yearOutlierACCyB=load([filepath,'outlier','ACCyB',year]);
yearOutlierACCzB=load([filepath,'outlier','ACCzB',year]);

daysOutlierACCxA=unique(fix(yearOutlierACCxA));
daysOutlierACCyA=unique(fix(yearOutlierACCyA));
daysOutlierACCzA=unique(fix(yearOutlierACCzA));
daysOutlierACCxB=unique(fix(yearOutlierACCxB));
daysOutlierACCyB=unique(fix(yearOutlierACCyB));
daysOutlierACCzB=unique(fix(yearOutlierACCzB));
daysOutlier=unique([daysOutlierACCxA; daysOutlierACCyA ;daysOutlierACCzA ;daysOutlierACCxB ;daysOutlierACCyB ;daysOutlierACCzB;daysOutlierAOC]);


% %
% AOC4year(:,1)=AOC4year(:,1)-AOC4year(1,1);
% AOC4year(:,1)=AOC4year(:,1)/sec2hor;
% % if begining of the yaer is not day 1
% AOCtime=AOC4year(:,1)+extraday;
% AOCrate=AOC4year(:,2)*10^(6);
% %% find the outliers
% thresholdValue=1;
% outlierIndexes = abs(AOCrate) > thresholdValue;
% %% write outliers epoch in a file
% outlierTime=AOCtime(outlierIndexes);
% % writing in a file 
% outlierfilename= [filepath,'outlier',file_id,year];
% fid = fopen(outlierfilename,'w');
%  for i =1: length(outlierTime)
% fprintf(fid,'%f\n',outlierTime(i));  
%  end
% fclose(fid);
% outlierLength=num2str(round(length(outlierTime)*5/3600));
% %% plot
% figure
% plot(AOCtime,AOCrate,'k.',AOCtime(outlierIndexes),AOCrate(outlierIndexes),'r.');
% ylabel('$AOC[\mu m/s]$','Interpreter','latex');
% xlabel('$Day$','Interpreter','latex');
% grid on
% title ({['  20',year,' ','Outlier length ',outlierLength,' hours']});
% xlim([1 366]);
% %ylim([-800 600]);
% set(gca,'XTick',[1:30:366])
% legend('AOC rate','outlier','Location','best')
% saveas(gcf,[filepathNeda,'plots/20',year,'/aocOutlierYear','_',year],'png')








