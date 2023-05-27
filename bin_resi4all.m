%%Outlier detection for each day
%
% Written by Neda Darbeheshti, AIUB, 2020-12.
%%
clear all
close all

format longg;

filepath='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/res2016/';
year='16';
month='01';
apriori='0itr';
itr='D0';%'D3';%'d3';
did='0';%0,a,b
%from resiRMS_plot
d=1;
%d = [1  3  4  5   6  8 11  18  19  20  21  22];%1
%d = [32    35    38    39    40    44    45    47    48];%02
outliermethod='median';%'median','mean','quartiles','grubbs','gesd'
thrsh=3*10^(-2);%for plot
gapfilename= [filepath,'gapOrb',year,month];
hfraction=1;
hday=hfraction*24;%24 for 60 m, 48 for 30 m
bin_lower_num=[0:1:hday-1];
bin_upper_num=[1:1:hday];
bin_lower=bin_lower_num/hday;
bin_upper=bin_upper_num/hday;
bin_size=60*60/5;
for dn=1:length(d)
    %for dn=1:1
ds = sprintf('%03d',d(dn));
%% load GRACE A file  
file = [filepath,itr,'C',apriori,year,ds,did,'.RES'];
fileID = fopen(file);
input_a = textscan(fileID,'%f %f %f %f %f %f %f %f %s %f %f %f');
fclose(fileID);
fracga=cell2mat(input_a(:,1));
fracga= fracga/60;
xr_a=cell2mat(input_a(:,6));
ya_a=cell2mat(input_a(:,7));
zc_a=cell2mat(input_a(:,8));
%% make the bins
for bin_id=1:hday
bin_sumx=0;
bin_sumy=0;
bin_sumz=0;
bin_counter=0; 
%
for  ii=1:length(fracga)
    if (bin_lower(bin_id) <= fracga(ii) & fracga(ii)< bin_upper(bin_id))
        bin_sumx=bin_sumx+(xr_a(ii))^2;
        bin_sumy=bin_sumy+(ya_a(ii))^2;
        bin_sumz=bin_sumz+(zc_a(ii))^2;
        bin_counter=bin_counter+1;
    end
   
end
%
bin_size_real(bin_id)=bin_counter;
bin_rmsx(bin_id)=sqrt(bin_sumx/bin_counter);
bin_rmsy(bin_id)=sqrt(bin_sumy/bin_counter);
bin_rmsz(bin_id)=sqrt(bin_sumz/bin_counter);
end

TF_binx = isoutlier(bin_rmsx,outliermethod);
TF_biny = isoutlier(bin_rmsy,outliermethod);
TF_binz = isoutlier(bin_rmsz,outliermethod);
%
figure
subplot(3,2,1)
plot(fracga,xr_a,'r.')
hold on
plot(bin_upper_num/hfraction,bin_rmsx,'*r',bin_upper_num(TF_binx )/hfraction,bin_rmsx(TF_binx ),'*k','LineWidth',9,'MarkerSize',9)
yline(-thrsh,'k','LineWidth',1);
yline(thrsh,'k','LineWidth',1);
grid on
ylabel('$Radial[m]$','Interpreter','latex');
title ({[' Year ',year,' Day ',ds],' A '});
%
subplot(3,2,3)
plot(fracga,ya_a,'g.')
hold on
plot(bin_upper_num/hfraction,bin_rmsy,'*g',bin_upper_num(TF_biny )/hfraction,bin_rmsy(TF_biny ),'*k','LineWidth',9,'MarkerSize',9)
yline(-thrsh,'k','LineWidth',1);
yline(thrsh,'k','LineWidth',1);
grid on
ylabel('$Along-track[m]$','Interpreter','latex');
%
subplot(3,2,5)
plot(fracga,zc_a,'b.')
hold on
plot(bin_upper_num/hfraction,bin_rmsz,'*b',bin_upper_num(TF_binz )/hfraction,bin_rmsz(TF_binz ),'*k','LineWidth',9,'MarkerSize',9)
yline(-thrsh,'k','LineWidth',1);
yline(thrsh,'k','LineWidth',1);
grid on
ylabel('$Cross-track[m]$','Interpreter','latex');
xlabel('Time [hour]');
%% load GRACE B file  
file = [filepath,itr,'D',apriori,year,ds,did,'.RES'];
fileID = fopen(file);
input_b = textscan(fileID,'%f %f %f %f %f %f %f %f %s %f %f %f');
fclose(fileID);
fracgb=cell2mat(input_b(:,1));
fracgb= fracgb/60;
xr_b=cell2mat(input_b(:,6));
ya_b=cell2mat(input_b(:,7));
zc_b=cell2mat(input_b(:,8));
%% make the bins
for bin_id=1:hday
bin_sumx=0;
bin_sumy=0;
bin_sumz=0;
bin_counter=0; 
%
for  ii=1:length(fracga)
    if (bin_lower(bin_id) <= fracga(ii) & fracga(ii)< bin_upper(bin_id))
        bin_sumx=bin_sumx+(xr_a(ii))^2;
        bin_sumy=bin_sumy+(ya_a(ii))^2;
        bin_sumz=bin_sumz+(zc_a(ii))^2;
        bin_counter=bin_counter+1;
    end
   
end
%
bin_size_real(bin_id)=bin_counter;
bin_rmsx(bin_id)=sqrt(bin_sumx/bin_counter);
bin_rmsy(bin_id)=sqrt(bin_sumy/bin_counter);
bin_rmsz(bin_id)=sqrt(bin_sumz/bin_counter);
end

TF_binx = isoutlier(bin_rmsx,outliermethod);
TF_biny = isoutlier(bin_rmsy,outliermethod);
TF_binz = isoutlier(bin_rmsz,outliermethod);
subplot(3,2,2)
plot(fracgb,xr_b,'r.')
hold on
plot(bin_upper_num/hfraction,bin_rmsx,'*r',bin_upper_num(TF_binx )/hfraction,bin_rmsx(TF_binx ),'*k','LineWidth',9,'MarkerSize',9)
yline(-thrsh,'k','LineWidth',1);
yline(thrsh,'k','LineWidth',1);
grid on
title ({[' Year ',year,' Day ',ds],' B '});
%
subplot(3,2,4)
plot(fracgb,ya_b,'g.')
hold on
plot(bin_upper_num/hfraction,bin_rmsy,'*g',bin_upper_num(TF_biny )/hfraction,bin_rmsy(TF_biny ),'*k','LineWidth',9,'MarkerSize',9)
yline(-thrsh,'k','LineWidth',1);
yline(thrsh,'k','LineWidth',1);
grid on
%
subplot(3,2,6)
plot(fracgb,zc_b,'b.')
hold on
plot(bin_upper_num/hfraction,bin_rmsz,'*b',bin_upper_num(TF_binz )/hfraction,bin_rmsz(TF_binz ),'*k','LineWidth',9,'MarkerSize',9)
yline(-thrsh,'k','LineWidth',1);
yline(thrsh,'k','LineWidth',1);
grid on
xlabel('Time [hour]');
%% load Range residuals file   
file = [filepath,itr,'KbV',apriori,year,ds,did,'.RES'];
% Counts header lines and removes them.
header=0;
fid = fopen(file);
while 1
    line = fgetl(fid);
    header = header+1;
    if (~isempty(strfind(line,'END OF HEADER')))
        break
    end
end
% Reads the desired values.
[~, fracgr, ~, ~, ~, ~ ,OC_range, ~, ~, ~, ~ ] = textread(file,'%f %f %f %f %f %f %f %f %f %f %f','headerlines',header);
fracgr= fracgr*24;
TFkbr = isoutlier(OC_range,outliermethod);
%% load Range rate residuals file
file = [filepath,itr,'Kb',apriori,year,ds,did,'.RES'];
% Counts header lines and removes them.
header=0;
fid = fopen(file);
while 1
    line = fgetl(fid);
    header = header+1;
    if (~isempty(strfind(line,'END OF HEADER')))
        break
    end
end
% Reads the desired values.
[~, fracgv, ~, ~, ~, ~ ,OC_range_rate, ~, ~, ~, ~ ] = textread(file,'%f %f %f %f %f %f %f %f %f %f %f','headerlines',header);
fracgv= fracgv*24;
TFkbv = isoutlier(OC_range_rate,outliermethod);
%% gap for each day
% totalgap=[fracga(TFxr_a) ;fracga(TFya_a) ;fracga(TFzc_a) ; fracgb(TFxr_b); fracgb(TFya_b); fracgb(TFzc_b)];
% totalgap=sort(totalgap);
% totalses=[fracga(~TFxr_a) ;fracga(~TFya_a) ;fracga(~TFzc_a) ; fracgb(~TFxr_b); fracgb(~TFya_b); fracgb(~TFzc_b)];
% totalses=sort(totalses);
% totalses=unique(totalses);
% writing in a file 
% fid = fopen(gapfilename,'a+');
%  for i =1: length(totalgap)
% fprintf(fid,'%03d %f\r\n', d(dn),totalgap(i));  
%  end
% fclose(fid);
%save the plots
%saveas(gcf,[filepath,'plots/','orbitsOutlier',itr,apriori,'_',year,ds,did],'png')
figure
subplot(2,1,1)
plot(fracgr,OC_range,'m.',fracgr(TFkbr),OC_range(TFkbr),'kx','MarkerSize',10)
subplot(2,1,2)
plot(fracgv,OC_range_rate,'c.',fracgv(TFkbv),OC_range_rate(TFkbv),'kx','MarkerSize',10)
%yline(-thrsh,'k','LineWidth',1);
%yline(thrsh,'k','LineWidth',1);
grid on
%ylabel('$Radial[m]$','Interpreter','latex');
%title ({[' Year ',year,' Day ',ds],' A '});
%clear xr_a xr_b ya_a ya_b zc_a zc_b TFxr_a Txr_b TFya_a TFya_b TFzc_a TFzc_b input_a input_b fracga fracgb totalgap
end
