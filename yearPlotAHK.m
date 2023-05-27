%%Temperature plots for each year
% Written by Neda Darbeheshti, AIUB, 2020-12.
%%
clear all
close all
format longg;
fform='png';
year='07';
filepath=['/storage/research/aiub_data/DATAPOOL/LEO/GRACE/GRACE1BJPLRL02/20',year,'/ascs/'];
filepathNeda=['/storage/research/aiub_u_camp/NEDA/OUT/'];
sec2hor=3600*24;
d = [11:11]; 
% 2002 d = [94:120 122:126 129:133 135:137 213:365];
% 2003 d = [1:21 23:25 27:365];
% 2004 d = [1:344 346:366];
% 2005 d = [1:365];
% 2006 d = [1:30  32:272 274:333 335:365]; 
% 2007 d = [1:365];
% 2008 d = [1:366];
% 2009 d = [1:365];
% 2010 d = [1:362];
% 2011 d = [38:157 185:320 346:348 350:365];
% 2012 d = [1:109 145:269 311:366];
% 2013 d = [1:57 95:219 259:365];
% 2014 d = [1:177 209:340];
% 2015 d = [7:131 133 173:270 342:365];
% 2016 d = [1:92 127:247 318:348 351:366];A  d = [1:92 127:247 ];B 
% 2017 d = [1:31 76:180];A  d = [122:142];B
for str = {'A','B'}
    %for str = {'A','B'}
                gt = cell2mat(str);
mtempIC=[];              
mtimea_hour=[];               
for dn=1:length(d)
ds = sprintf('%03d',d(dn));
% load AHK data
file = [filepath,'GRC',gt,year,ds,'0.AHK'];
AHKB = readAHK(file);
time_a=AHKB(:,1)-AHKB(1,1);
time_a=d(dn)+time_a/sec2hor;
tempIC=AHKB(:,2);
% accumulate for a year
mtimea_hour=[mtimea_hour;time_a];
mtempIC=[mtempIC; tempIC];
%clear AHKB time_a tempIC
end
%% plots
figure
plot(mtimea_hour,mtempIC,'.','color','m','MarkerSize',5)
%ylabel('$Temperature[^{\circ} C]$','Interpreter','latex');
xlabel('$Day$','Interpreter','latex');
title ({['20',year,' ',' GRACE ' ,gt]});
grid on
%xlim([1 366]);
%ylim([10 30]);
set(gca,'XTick',[1:30:366])
%saveas(gcf,[filepathNeda,'plots/20',year,'/tem',gt,'year','_',year],fform)
end



