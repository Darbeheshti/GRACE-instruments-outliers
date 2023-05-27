%%Outlier detection for each day
%
% Written by Neda Darbeheshti, AIUB, 2020-12.
%%
%from GRACE-FO L1B DATA PRODUCT USER HANDBOOK
%thrust_count 14 columns
%on_time      14 columns
%accum_dur    14 columns
%qualflg       1 columns
clear all
close all
format longg;
%filepath=['/storage/research/aiub_u_camp/NEDA/ORB/'];
filepathNeda='/storage/research/aiub_u_camp/NEDA/OUT/';
year='15';month='01';gt='A';
filepath=['/storage/research/aiub_data/DATAPOOL/LEO/GRACE/GRACE1BJPLRL02/20',year,'/ascs/'];
d=[20];
for dn=1:length(d)
ds = sprintf('%02d',d(dn));
fileTHR = [filepath,'THR1B_20',year,'-',month,'-',ds,'_',gt,'_','02.asc'];
fileACC = [filepath,'ACC1B_20',year,'-',month,'-',ds,'_',gt,'_','02.asc'];
% load ACC1B file
ACC1B = readACC(fileACC);
% load THR1B data
head_no=64;
FID=fopen(fileTHR);
datacella = textscan(FID, '%f%f%s%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f', 'HeaderLines', head_no, 'CollectOutput', 1);
fclose(FID);
% ACC1B data
time_acc=ACC1B(:,1);
acc_dx=ACC1B(:,2);
%% THR1B data
time_thr = datacella{1}(:,1);
% sum of 12 columns
thr_ontime=datacella{3}(:,15:26);
sum12_thr_ontime=sum(thr_ontime');
thrFire=11*10^(-7)*ones(length(time_thr),1);%this value is arbitrary
% plot ACC and THR for first six hours of the day
nmax=21600;%for first six hours
figure
plot(time_acc(1:nmax),acc_dx(1:nmax))
hold on 
plot(time_thr,thrFire,'.') 
xlim([time_acc(1) time_acc(nmax)])
figure
plot(time_thr,sum12_thr_ontime','.') 
end





















