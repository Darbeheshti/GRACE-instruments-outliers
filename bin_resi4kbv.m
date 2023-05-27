%% Plotting for AIUB range rate residuals
%
% Written by Neda Darbeheshti, AIUB, 2020-03.
%%
clear all
close all

format longg;
rtext=.9*10^(-6);
filepath='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/';
year='11';
month='08';
%apriori='rl3';
apriori='rl03nedaus2kin8';
%apriori='3rls';
itr='D0';%'D3';%'d3';
did='0';%0,a,b
%d=[249,254,255,260,266];%09
%d=[229,231,237,243];%08
%d=[186,187,188];%07
%d=[91,97,103,110];%04
d=243;
%d=[39,61,80,83,87,91,97,103,131,229,231,237,243,249,254,255,260,266];
hfraction=1;
outliermethod='median';%'median','mean','quartiles','grubbs','gesd'
gapfilename= [filepath,'gaptable',year,month,outliermethod,num2str(hfraction)];
%delete gapfilename;
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
%% plot Range rate residuals 
%thour = datetime(2011,1,1,0,0,0) +d(dn)-1+ seconds(0:length(OC_range_rate)-1)*5;
thour= frac*24;
%TF = isoutlier(OC_range_rate,'percentiles',[0 10^(-7)]);
figure
%subplot(2,1,1)
%plot(thour,OC_range_rate,'b.',thour(TF),OC_range_rate(TF),'rx')
plot(thour,OC_range_rate,'b.')
%title([' Year ', year,' Day ',ds,'          Method: ', outliermethod])
title([' Year ', year,' Day ',ds])
ylabel('$\dot\rho[m/s]$','Interpreter','latex');
grid on
%txt = [num2str(rms(OC_range_rate))];
%text(6,rtext,txt,'Color','r')
%legend('Data','Outlier')
hold on
%% make the bins
hday=hfraction*24;%24 for 60 m, 48 for 30 m, 

bin_lower_num=[0:1:hday-1];
bin_upper_num=[1:1:hday];
bin_lower=bin_lower_num/hday;
bin_upper=bin_upper_num/hday;
bin_size=60*60/5;

for bin_id=1:hday
bin_sum=0;
bin_counter=0; 

for  ii=1:length(OC_range_rate)
    if (bin_lower(bin_id) <= frac(ii) & frac(ii)< bin_upper(bin_id))
        bin_sum=bin_sum+(OC_range_rate(ii))^2;
        bin_counter=bin_counter+1;
    end
   
end

bin_size_real(bin_id)=bin_counter;
bin_rms(bin_id)=sqrt(bin_sum/bin_counter);
end

TF_bin = isoutlier(bin_rms,outliermethod);

%subplot(2,1,2)
plot(bin_upper_num/hfraction,bin_rms,'*g',bin_upper_num(TF_bin )/hfraction,bin_rms(TF_bin ),'*r','LineWidth',9,'MarkerSize',9)
%title(['Method: ', outliermethod])
xlabel('Time [hour]');
%ylabel('$RMS[m/s]$','Interpreter','latex');
grid on  
legend('Data point','RMS bin','Outlier bin')
%legend('RMS bin','Outlier bin')
%saveas(gcf,[filepath,'plots/20',year,'/outlier_',itr,apriori,'_',year,ds,did],'png')
%% writing in a file 
gaptimel=bin_lower_num(TF_bin )/hfraction;
gaptimeu=bin_upper_num(TF_bin )/hfraction;
sestimel=bin_lower_num(~TF_bin )/hfraction;
sestimeu=bin_upper_num(~TF_bin )/hfraction;
[~, ia, ~] = unique(TF_bin);
% fid = fopen(gapfilename,'a+');
%  for i =1: length(gaptimel)
% fprintf(fid,'%03d %f %f\r\n', d(dn),gaptimel(i),gaptimeu(i));  
%  end
% fclose(fid);
% clear OC_range_rate frac thour
end
















