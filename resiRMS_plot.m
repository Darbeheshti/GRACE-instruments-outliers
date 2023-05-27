%% Plotting for AIUB residuals
%
% Written by Neda Darbeheshti, AIUB, 2020-03.
%%
clear all
close all

format longg;

filepath='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/';
year='16';
month='05';
apriori='0itr';
itr='D0';%'D3';%'d3';
did='0';%0,a,b
%d = [2   6 7  9 10  12 13 14 15 16 17 21 22 23 24 25 28 29 30 31];
%d=[1  3  4  5  8 11  18  19  20  ];%a,b
%d=[1  3   11  18   ];%c
%d=11%d
%d=[32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60];
%d = [1:25,28:31];%01
%d = [32:60];%02
%d = [61:91];%03
d = [127:152];%05
%d = [153:182];%06
%d = [183:211];%07
%d = [214:244];%08
%month      1     2     3     4     5     6     7     8     9    10    11    12
%sessi   0010  0320  0610  0920  1220  1530  1830  2140  2450  2750  3060  3360

for dn=1:length(d)
ds = sprintf('%03d',d(dn));
%% load GRACE A file  
file = [filepath,'res2016/',itr,'C',apriori,year,ds,did,'.RES'];
fileID = fopen(file);
input_a = textscan(fileID,'%f %f %f %f %f %f %f %f %s %f %f %f');
fclose(fileID);

xr_a=cell2mat(input_a(:,6));
ya_a=cell2mat(input_a(:,7));
zc_a=cell2mat(input_a(:,8));
%rms
rms_xr_a(dn)=rms(xr_a);
rms_ya_a(dn)=rms(ya_a);
rms_zc_a(dn)=rms(zc_a);
%% load GRACE B file
file = [filepath,'res2016/',itr,'D',apriori,year,ds,did,'.RES'];
fileID = fopen(file);
input_b = textscan(fileID,'%f %f %f %f %f %f %f %f %s %f %f %f');
fclose(fileID);

xr_b=cell2mat(input_b(:,6));
ya_b=cell2mat(input_b(:,7));
zc_b=cell2mat(input_b(:,8));
%rms
rms_xr_b(dn)=rms(xr_b);
rms_ya_b(dn)=rms(ya_b);
rms_zc_b(dn)=rms(zc_b);
%% load Range residuals file   
file = [filepath,'res2016/',itr,'KbV',apriori,year,ds,did,'.RES'];
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
[~, ~, ~, ~, ~, ~ ,OC_range, ~, ~, ~, ~ ] = textread(file,'%f %f %f %f %f %f %f %f %f %f %f','headerlines',header);
%rms
rms_r(dn)=rms(OC_range);
%% load Range rate residuals file
file = [filepath,'res2016/',itr,'Kb',apriori,year,ds,did,'.RES'];
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
[~, ~, ~, ~, ~, ~ ,OC_range_rate, ~, ~, ~, ~ ] = textread(file,'%f %f %f %f %f %f %f %f %f %f %f','headerlines',header);
rms_rr(dn)=rms(OC_range_rate);
clear xr_a xr_b ya_a ya_b zc_a zc_b input_a input_b OC_range OC_range_rate
end
%%%%%%%%%% write to a file
rmsfilename= [filepath,'resirms',year,month,'.mat'];
save(rmsfilename,'rms_xr_a','rms_ya_a','rms_zc_a',...
                  'rms_xr_b','rms_ya_b','rms_zc_b','rms_r','rms_rr');
%% plots             
marks=50;
figure
plot(d,rms_xr_a,'.r','MarkerSize',marks)
hold on
plot(d,rms_ya_a,'.g','MarkerSize',marks)
hold on
plot(d,rms_zc_a,'.b','MarkerSize',marks)
grid on
ylabel('$RMS[m]$','Interpreter','latex');
xlabel('Day [number]');
legend('radial','along-track','cross-track')
title([apriori,' GRACE A ',' 20',year,month])
saveas(gcf,[filepath,'plots/20',year,'/rmsa_',apriori,did,'_',year,month],'png')
figure
plot(d,rms_xr_b,'.r','MarkerSize',marks)
hold on
plot(d,rms_ya_b,'.g','MarkerSize',marks)
hold on
plot(d,rms_zc_b,'.b','MarkerSize',marks)
grid on
ylabel('$RMS[m]$','Interpreter','latex');
xlabel('Day [number]');
legend('radial','along-track','cross-track')
title([apriori,' GRACE B ',' 20',year,month])
saveas(gcf,[filepath,'plots/20',year,'/rmsb_',apriori,did,'_',year,month],'png')
figure
plot(d,rms_r,'.c','MarkerSize',marks)
grid on
ylabel('$RMS[m]$','Interpreter','latex');
xlabel('Day [number]');
title([apriori,' Range ',' 20',year,month])
saveas(gcf,[filepath,'plots/20',year,'/rmsr_',apriori,did,'_',year,month],'png')
figure
plot(d,rms_rr,'.m','MarkerSize',marks)
grid on
ylabel('$RMS[m/s]$','Interpreter','latex');
xlabel('Day [number]');
title([apriori,' Range-rate ',' 20',year,month])
saveas(gcf,[filepath,'plots/20',year,'/rmsrr_',apriori,did,'_',year,month],'png')
%% monthly outlier detection:which day %%%%%%%%%%%%%%%%%%%%%
TFa = isoutlier(rms_xr_a,'percentile',[0 70]);
%
figure
plot(d,rms_xr_a,'r.',d(TFa),rms_xr_a(TFa),'kx','MarkerSize',marks)
xlabel('Day [number]');
legend('radial','outlier')
title(['GRACE A ',' 20',year,month])
saveas(gcf,[filepath,'plots/20',year,'/dayouta_',apriori,did,'_',year,month],'png')
%
TFb = isoutlier(rms_xr_b,'percentile',[0 70]);
%
figure
plot(d,rms_xr_b,'r.',d(TFb),rms_xr_b(TFb),'kx','MarkerSize',marks)
xlabel('Day [number]');
legend('radial','outlier')
title(['GRACE B ',' 20',year,month])
saveas(gcf,[filepath,'plots/20',year,'/dayoutb_',apriori,did,'_',year,month],'png')
%saveas(gcf,[filepathNeda,'plots/20',year,'/degvar',year,month,'.png'])
%
totalgap=[d(TFa) d(TFb)];
%totalgap=sort(totalgap);
totalgap=unique(totalgap)
