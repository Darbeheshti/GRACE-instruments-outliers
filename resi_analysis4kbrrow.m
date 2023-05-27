%% Plotting for AIUB range rate residuals
%
% Written by Neda Darbeheshti, AIUB, 2020-03.
%%
clear all
close all

format longg;

filepath='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/';
year='11';
dn=243;%39,59,77,284,294,295,296,365 %d=[229,231,237,243];%08
ds = sprintf('%03d',dn);

kbrfilename= [filepath,'GRCSth',year,ds,'.KBR'];

kbrday=readKBR(kbrfilename);
frac=(kbrday(:,1)-kbrday(1,1))/(3600*24);
thour = datetime(str2num(year),1,1,0,0,0) +dn-1+ seconds(0:length(kbrday)-1)*5;
subplot(2,1,1)
plot(frac,kbrday(:,3),'*b','LineWidth',1,'MarkerSize',1)
title([' Year ', year,' Day ',ds])
xlabel('Time [hour]');
ylabel('$\dot\rho[m/s]$','Interpreter','latex');
grid on

%% plot Range rate rmss
outliermethod='median';%'median','mean','quartiles','grubbs','gesd'
hfraction=1;
hday=hfraction*24;%24 for 60 m, 48 for 30 m, 

bin_lower_num=[0:1:hday-1];
bin_upper_num=[1:1:hday];
bin_lower=bin_lower_num/hday;
bin_upper=bin_upper_num/hday;
bin_size=60*60/5;

for bin_id=1:hday
bin_sum=0;
bin_counter=0; 

for  ii=1:length(kbrday)
    if (bin_lower(bin_id) <= frac(ii) & frac(ii)< bin_upper(bin_id))
        bin_sum=bin_sum+(kbrday(ii,3))^2;
        bin_counter=bin_counter+1;
    end
   
end

bin_size_real(bin_id)=bin_counter;
bin_rms(bin_id)=sqrt(bin_sum/bin_counter);
end

TF_bin = isoutlier(bin_rms,outliermethod);

subplot(2,1,2)
plot(bin_upper_num,bin_rms,'*b',bin_upper_num(TF_bin ),bin_rms(TF_bin ),'*r','LineWidth',3,'MarkerSize',3)
title([' Year ', year,' Day ',ds])
xlabel('Bin [Number]');
ylabel('$RMS[m/s]$','Interpreter','latex');
grid on  
legend('Data','Outlier')
%% writing in a file 
gaptimel=bin_lower_num(TF_bin )/hfraction;
gaptimeu=bin_upper_num(TF_bin )/hfraction;

% fid = fopen(gapfilename,'a+');
%  for i =1: length(gaptimel)
% fprintf(fid,'%03d %f %f\r\n', d(dn),gaptimel(i),gaptimeu(i));  
%  end
% fclose(fid);
















