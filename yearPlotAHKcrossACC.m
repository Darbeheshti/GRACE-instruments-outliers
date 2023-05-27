%%Temperature plots for each year
% Written by Neda Darbeheshti, AIUB, 2020-12.
%%
clear all
close all
format longg;
fform='png';
year='07';
filepathAHK=['/storage/research/aiub_data/DATAPOOL/LEO/GRACE/GRACE1BJPLRL02/20',year,'/ascs/'];
filepathACC=['/storage/research/aiub_u_camp/NEDA/ORB/'];
filepathNeda=['/storage/research/aiub_u_camp/NEDA/OUT/'];
sec2hor=3600*24;
micro=10^(3);
d = [1:31]; month='01';
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
mtimeAHK_hour=[];  
macc_dy=[];
mtimeACC_hour=[]; 
for dn=1:length(d)
ds = sprintf('%03d',d(dn));
%% load AHK data
file = [filepathAHK,'GRC',gt,year,ds,'0.AHK'];
AHKB = readAHK(file);
time_AHK=AHKB(:,1)-AHKB(1,1);
time_AHK=d(dn)+time_AHK/sec2hor;
tempIC=AHKB(:,2);
% accumulate for a year
mtimeAHK_hour=[mtimeAHK_hour;time_AHK];
mtempIC=[mtempIC; tempIC];
clear file AHKB AHK time_AHK tempIC
%% load ACC file
file = [filepathACC,'GRC',gt,'c',year,ds,'0.ACC'];
FID=fopen(file);
datacella = textscan(FID, '%f%f%f%f%f%f%f', 'HeaderLines', 9, 'CollectOutput', 1);
fclose(FID);
acca_lin = datacella{1};
time_ACC=d(dn)+acca_lin(:,1);
acc_dy=acca_lin(:,3)*micro;
%accumulate for a year
mtimeACC_hour=[mtimeACC_hour;time_ACC];
macc_dy=[macc_dy; acc_dy];
clear file FID datacella acca_lin time_ACC acc_dy  
end

switch gt
            case 'A'
                llima=-30.3; hlima=-29.3;  %ACC
                llimt=21;  hlimt=28;     %temperature
            case 'B'
%                llima=-12; hlima=-10;   %ACC
%                llimt=26;  hlimt=28;   %temperature
               llima=-200; hlima=700;   %ACC
               llimt=21;  hlimt=28;   %temperature
        end

figure
yyaxis left
plot(mtimeACC_hour,macc_dy,'.','color','b','MarkerSize',5)
ylabel('$ACC(cross)[\mu m/s^2]$','Interpreter','latex');
ylim([llima hlima]);
yyaxis right
plot(mtimeAHK_hour,mtempIC,'.','color','m','MarkerSize',5)
ylabel('$temperature[^{\circ} C]$','Interpreter','latex');
ylim([llimt hlimt]);
grid on
ax = gca;
ax.YAxis(1).Color = 'b';
ax.YAxis(2).Color = 'm';
%xlim([1 366])
xlim([1 31])
title ({['20',year,' ',' GRACE ' ,gt]});
saveas(gcf,[filepathNeda,'plots/20',year,'/ahkcross4year2side',gt,'year','_',year,month],fform)
end


