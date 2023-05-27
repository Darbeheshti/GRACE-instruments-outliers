%% Plotting for AIUB range rate residuals
%
% Written by Neda Darbeheshti, AIUB, 2020-03.
%%
clear all
close all

format longg;
filepath='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/';
year='11';
month='08';
apriori='rl03nedaus2kin8';
itr='D0';%'D3';%'d3';
did='0';%0,a,b
%d=[249,254,255,260,266];%09
%d=[229,231,237,243];%08
d=[229:243];%08
%d=[186,187,188];%07
%d=[91,97,103,110];%04
%d=214;
lowPercent  = 0; 
highPercent = 95;
for dn=1:length(d) 
ds = sprintf('%03d',d(dn));
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
[~, frac, ~, ~, ~, ~ ,OC_range_rate, ~, ~, ~, ~ ] = textread(file,'%f %f %f %f %f %f %f %f %f %f %f','headerlines',header);
thour= frac*24;
% %% plot outlier with percentiles
% TF_percent = isoutlier(OC_range_rate,'percentiles',[lowPercent, highPercent]);
% figure
% plot(thour,OC_range_rate,'b.',thour(TF_percent),OC_range_rate(TF_percent),'rx')
% title([' Year ', year,' Day ',ds,'  percentiles'])
% ylabel('$\dot\rho[m/s]$','Interpreter','latex');
% grid on
% %% plot outlier with mean
% TF_mean = isoutlier(OC_range_rate,'mean');
% figure
% plot(thour,OC_range_rate,'b.',thour(TF_mean),OC_range_rate(TF_mean),'rx')
% title([' Year ', year,' Day ',ds,'  mean'])
% ylabel('$\dot\rho[m/s]$','Interpreter','latex');
% grid on
% %% plot outlier with mean
TF_median = isoutlier(OC_range_rate,'median');
figure
subplot(2,2,1)
plot(thour,OC_range_rate,'b.',thour(TF_median),OC_range_rate(TF_median),'rx')
title([' Year ', year,' Day ',ds,'  median'])
xlabel('Time [hour]');
ylabel('$\dot\rho[m/s]$','Interpreter','latex');
legend('Data','Outlier')
grid on
%% Mahalanobis distance
for i=1:length(OC_range_rate)
d1_mahal(i)=mahal(OC_range_rate(i),OC_range_rate);
end
subplot(2,2,2)
plot(thour,d1_mahal)
xlabel('Time [hour]');
title('Mahalanobis distance')
grid on
%
P_val= chi2cdf(d1_mahal,10);
subplot(2,2,3)
plot(thour,P_val)
xlabel('Time [hour]');
title('p-values')
grid on

outlierInd_P_val=zeros(length(P_val),1);
for i=1:length(P_val)
if P_val(i)>0.99
    outlierInd_P_val(i)=1;
end
end
outlierInd_P_val=logical(outlierInd_P_val);
subplot(2,2,4)
plot(thour,OC_range_rate,'b.',thour(outlierInd_P_val),OC_range_rate(outlierInd_P_val),'rx')
xlabel('Time [hour]');
ylabel('$\dot\rho[m/s]$','Interpreter','latex');
legend('Data','Outlier')
title('Mahalanobis p-values')
grid on
saveas(gcf,[filepath,'plots/20',year,'/mahal_',itr,apriori,'_',year,ds,did],'png')
%
% [outlierInd_percent,pLow,pHigh,~] = isoutlier(d1_mahal,'percentiles',[lowPercent, highPercent]);
% figure
% plot(thour,OC_range_rate,'b.',thour(outlierInd_percent),OC_range_rate(outlierInd_percent),'rx')
% title('Mahalanobis percentiles')
%
% rms(OC_range_rate)
% std(OC_range_rate)
% mean(OC_range_rate)
%
clear OC_range_rate frac thour TF_percent TF_mean TF_median outlierInd_P_val outlierInd_percent P_val d1_mahal
end
















