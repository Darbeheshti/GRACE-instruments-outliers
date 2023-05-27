%%This program detects outliers in daily ACC file.
% and creats 6 ACC outlier file (per axis per satellite) for a year.
%
% Written by Neda Darbeheshti, AIUB, 2021-11.
%%
clear all
close all
format longg;
fform='png';
year='16';
filepath=['/storage/research/aiub_u_camp/NEDA/ORB/'];
filepathNeda=['/storage/research/aiub_u_camp/NEDA/OUT/'];
 d = [1:92 127:247 318:366];
% 2002 d = [94:120 122:126 129:133 135:137 213:365];
% 2003 d = [1:21 23:25 27:365];
% 2004 d = [1:344 346:366];
% 2005 d = [1:365];
% 2006 d = [1:24 26:265 267:328 329:365 ]; 
% 2007 d = [1:365];
% 2008 d = [1:366];
% 2009 d = [1:365];
% 2010 d = [1:362];
% 2011 d = [39:151 153:156 186:319 347 351:365];
% 2012 d = [1:109 145:269 311:366];
% 2013 d = [1:57 95:219 259:365];
% 2014 d = [1:177 209:340];
% 2015 d = [7:131 133 173:270 342:365];
% 2016 d = [1:92 127:247 318:366];
% 2017 d = [1:31 76:180];
micro=10^(3);
thresholdValue=10;
formatSpec = '%.1f';
 for str = {'A','B'}
%str = {'A'}
gt = cell2mat(str);
macc_dx=[];
macc_dy=[];
macc_dz=[];
mtimea_hour=[];
moutlierIndexes_dx=[];
moutlierIndexes_dy=[];
moutlierIndexes_dz=[];
for dn=1:length(d)
    %for dn=1:10
ds = sprintf('%03d',d(dn));
%% load ACC file
file = [filepath,'GRC',gt,'c',year,ds,'0.ACC'];
FID=fopen(file);
datacella = textscan(FID, '%f%f%f%f%f%f%f', 'HeaderLines', 9, 'CollectOutput', 1);
fclose(FID);
acca_lin = datacella{1};
time_a=d(dn)+acca_lin(:,1);
acc_dx=acca_lin(:,2)*micro;
acc_dy=acca_lin(:,3)*micro;
acc_dz=acca_lin(:,4)*micro;
%% find the outliers
macc_dxMedian=median(acc_dx);
macc_dyMedian=median(acc_dy);
macc_dzMedian=median(acc_dz);
outlierIndexes_dx = abs(acc_dx-macc_dxMedian) > thresholdValue;
outlierIndexes_dy = abs(acc_dy-macc_dyMedian) > thresholdValue;
outlierIndexes_dz = abs(acc_dz-macc_dzMedian) > thresholdValue;
%accumulate for a year
mtimea_hour=[mtimea_hour;time_a];
macc_dx=[macc_dx; acc_dx];
macc_dy=[macc_dy; acc_dy];
macc_dz=[macc_dz; acc_dz];
moutlierIndexes_dx=[moutlierIndexes_dx; outlierIndexes_dx];
moutlierIndexes_dy=[moutlierIndexes_dy; outlierIndexes_dy];
moutlierIndexes_dz=[moutlierIndexes_dz; outlierIndexes_dz];
clear datacella acca_lin time_a acc_dx acc_dy acc_dz outlierIndexes_dx outlierIndexes_dy outlierIndexes_dz
end
%length of outlier
outlierTime_dx=mtimea_hour(moutlierIndexes_dx);
outlierTime_dy=mtimea_hour(moutlierIndexes_dy);
outlierTime_dz=mtimea_hour(moutlierIndexes_dz);
%
outlierLength_dx=num2str((length(outlierTime_dx)/60),formatSpec);
outlierLength_dy=num2str((length(outlierTime_dy)/60),formatSpec);
outlierLength_dz=num2str((length(outlierTime_dz)/60),formatSpec);
%% plots
figure
subplot(3,1,1);
plot(mtimea_hour,macc_dx,'b.',mtimea_hour(moutlierIndexes_dx),macc_dx(moutlierIndexes_dx),'r.')
ylabel('$ACCx[\mu m/s^2]$','Interpreter','latex');
grid on
title ({['20',year,' ',' GRACE ' ,gt,' Outlier length ',outlierLength_dx,' minutes']});
legend('ACCx','outlier','Location','best')
xlim([1 366]);
set(gca,'XTick',[1:30:366])
%
subplot(3,1,2);
plot(mtimea_hour,macc_dy,'b.',mtimea_hour(moutlierIndexes_dy),macc_dy(moutlierIndexes_dy),'r.')
ylabel('$ACCy[\mu m/s^2]$','Interpreter','latex');
grid on
title ({[' Outlier length ',outlierLength_dy,' minutes']});
legend('ACCy','outlier','Location','best')
xlim([1 366]);
%ylim([-200 700]);
set(gca,'XTick',[1:30:366])
%
subplot(3,1,3);
plot(mtimea_hour,macc_dz,'b.',mtimea_hour(moutlierIndexes_dz),macc_dz(moutlierIndexes_dz),'r.')
ylabel('$ACCz[\mu m/s^2]$','Interpreter','latex');
xlabel('$Day$','Interpreter','latex');
grid on
title ({[' Outlier length ',outlierLength_dz,' minutes']});
legend('ACCz','outlier','Location','best')
xlim([1 366]);
set(gca,'XTick',[1:30:366])
saveas(gcf,[filepathNeda,'plots/20',year,'/accOutlierYear',gt,'_',year],fform)
clear mtimea_hour macc_dx macc_dy macc_dz outlierIndexes_dx outlierIndexes_dy outlierIndexes_dz outlierTime_dx outlierTime_dy outlierTime_dz 
clear moutlierIndexes_dx moutlierIndexes_dy moutlierIndexes_dz
end






































