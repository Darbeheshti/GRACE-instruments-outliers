%% Plotting for AIUB range rate residuals
%
% Written by Neda Darbeheshti, AIUB, 2020-09.
%%
clear all
close all

format longg;

filepath='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/';
year='11';
apriori='rl03';
itr='D0';%'D3';%'d3';
d = 39;
ds = sprintf('%03d',d);
%% load Range rate residuals file
file = [filepath,itr,'Kb',apriori,year,ds,'0.RES'];
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

[MJD, frac, GPS_range, GPS_range_rate, Kband_range, Kband_range_rate ,OC_range_rate, Latitude, Longitude, Arg, beta ] = textread(file,'%f %f %f %f %f %f %f %f %f %f %f','headerlines',header);

t = datetime(2011,1,1,0,0,0) +d-1+ seconds(0:length(OC_range_rate)-1)*5;
%TF = isoutlier(OC_range_rate,'movmean',hours(1),'SamplePoints',t);
TF = isoutlier(OC_range_rate,'gesd');%'median','mean','quartiles','grubbs','gesd'
figure
plot(t,OC_range_rate,'.',t(TF),OC_range_rate(TF),'x')
title([' Year ', year,' Day ',ds])
xlabel('Time [hour]');
ylabel('$\dot\rho[m/s]$','Interpreter','latex');
grid on
legend('Data','Outlier')
rms(OC_range_rate)
% max_t=24;
% t=frac*max_t;
% y=OC_range_rate;
% Tbl = table(t,y);
% 
% figure;
% plot(Tbl.t,Tbl.y,'.');
% hold on;
% axis tight;
% ylabel('y');
% xlabel('t');
% title('Scatter Plot of Data');
% legend('Data','Simulated outliers','Location','NorthWest');
% 
% Mdl = TreeBagger(200,Tbl,'y','Method','regression');
% 
% tau = [0.25 0.5 0.75];
% predT = linspace(0,max_t,50)';
% quartiles = quantilePredict(Mdl,predT,'Quantile',tau);
% meanY = predict(Mdl,predT);
% 
% plot(predT,[quartiles(:,2) meanY],'LineWidth',2);
% legend('Data','Simulated outliers','Median response','Mean response',...
%     'Location','NorthWest');
% hold off;

% %ASD_pw(OC_range_rate,.2,'ASD [$m/s/ \sqrt{Hz}$]');
% %ASD_pw(OC_range_rate,.2,'ASD [$m/\sqrt{Hz}$]');

%rms(OC_range_rate);
%std(OC_range_rate);% mean is removed
%mean(OC_range_rate);
%min(OC_range_rate);
%max(OC_range_rate);
%rms(OC_range_rate(1:721));



