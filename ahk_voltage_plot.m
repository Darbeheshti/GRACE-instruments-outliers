%%Outlier detection for each day
%
% Written by Neda Darbeheshti, AIUB, 2020-12.
%%
clear all
close all
format longg;
year='12';
filepath=['/storage/research/aiub_data/DATAPOOL/LEO/GRACE/GRACE1BJPLRL02/20',year,'/ascs/'];
filepathNeda=['/storage/research/aiub_u_camp/NEDA/OUT/'];
id='A';
d=[57];
head_no=38;%different header, 50 for 20110910 ,42 for 200701
%sec2hor=3600*24;
%mtime_hour=[];
%mahkt1=[];
%mahkt2=[];
%mahkt3=[];
%mahkt4=[];
for dn=1:length(d)
ds = sprintf('%03d',d(dn));
% load AHK data
file = [filepath,'GRC',id,year,ds,'0.AHK'];
FID=fopen(file);
datacella = textscan(FID, '%f%f%s%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f', 'HeaderLines', head_no, 'CollectOutput', 1);
fclose(FID);
ahka = datacella{3};
%time_=datacella{1}(:,1);
%ahkt1=ahka(:,11);
%ahkt2=ahka(:,12);
%ahkt3=ahka(:,13);
%ahkt4=ahka(:,17);
%mean_ahkt3(dn)=mean(rmmissing(ahkt3));
%mahkt1=[mahkt1; ahkt1];
%mahkt2=[mahkt2; ahkt2];
%mahkt3=[mahkt3; ahkt3];
%mahkt4=[mahkt4; ahkt4];
%mtime_hour=[mtime_hour;time_];
%clear  datacella  ahka  ahkt3 
ahkt3=ahka(:,22);
end
figure
plot(ahkt3,'.','color','b','MarkerSize',15)
ylabel('$Temperature[^{\circ} C]$','Interpreter','latex');
xlabel('$Day$','Interpreter','latex');
title ({['20',year,' ',id]});
% mtime_hour=mtime_hour-mtime_hour(1);
% mtime_hour=mtime_hour/sec2hor;
% figure
% plot(mtime_hour,mahkt2,'.','color','g');
% hold on
% plot(mtime_hour,mahkt3,'.','color','b');
% hold on
% plot(mtime_hour,mahkt4,'.','color','k');
% ylabel('$temperature[^{\circ} C]$','Interpreter','latex');
% xlim([1 31])
% ylim([10 60])
% title ({['20',year,' ',month,' ',id]});
% grid on
% saveas(gcf,[filepathNeda,'plots/20',year,'/ahk4year','_',year,id],'png')
