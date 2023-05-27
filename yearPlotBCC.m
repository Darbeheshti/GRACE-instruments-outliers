%%Outlier detection for each year
% Written by Neda Darbeheshti, AIUB, 2021-05. For SEDNA:
%%
clear all
close all
format longg;
fform='png';
year='07';
filepath=['/storage/research/aiub_u_camp/NEDA/ORB/'];
filepathNeda=['/storage/research/aiub_u_camp/NEDA/OUT/'];
d = [1:365];
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
for str = {'A','B'}
                gt = cell2mat(str);
macc_dx=[];
macc_dy=[];
macc_dz=[];
mtimea_hour=[];
for dn=1:length(d)
    %for dn=1:1
ds = sprintf('%03d',d(dn));
%% load ACC file
%GRACE A
file = [filepath,'GRC',gt,'c',year,ds,'0.ACC'];
FID=fopen(file);
datacella = textscan(FID, '%f%f%f%f%f%f%f', 'HeaderLines', 9, 'CollectOutput', 1);
fclose(FID);
acca_lin = datacella{1};
time_a=d(dn)+acca_lin(:,1);
acc_dx=acca_lin(:,2)*micro;
acc_dy=acca_lin(:,3)*micro;
acc_dz=acca_lin(:,4)*micro;
%accumulate for a year
mtimea_hour=[mtimea_hour;time_a];
macc_dx=[macc_dx; acc_dx];
macc_dy=[macc_dy; acc_dy];
macc_dz=[macc_dz; acc_dz];
clear datacella acca_lin time_ acc_dx acc_dy acc_dz 
end
%% plots
figure
plot(mtimea_hour,macc_dx,'.','color','r')
hold on
plot(mtimea_hour,macc_dy,'.','color','b')
plot(mtimea_hour,macc_dz,'.','color','g')
ylabel('$ACC[\mu m/s^2]$','Interpreter','latex');
xlabel('$Day$','Interpreter','latex');
title ({['20',year,' ',' GRACE ' ,gt]});
grid on
legend('ACCx','ACCy','ACCz','Location','best');
xlim([1 366]);
%ylim([-800 600]);
set(gca,'XTick',[1:30:366])
saveas(gcf,[filepathNeda,'plots/20',year,'/acc',gt,'year','_',year],fform)
end






































