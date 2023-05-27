%% Plotting for AIUB range rate residuals
%
% Written by Neda Darbeheshti, AIUB, 2020-03.
%%
clear all
close all

format longg;
%load result file

%filepath='/storage/research/aiub_gravdet/E06/OUT/';
filepath='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/';
year='2006';
ds='48';% ds='54';

file = [filepath,'KRESs113625n.PLT'];%file = [filepath,'KRESs113634n.PLT'];
inputfile=load(file);
frac=inputfile(:,2)*24;
OC_range_rate=inputfile(:,4);
% plot range rate residuals in time and frequency for last iteration 
figure;
plot(frac,OC_range_rate,'*r','LineWidth',2,'MarkerSize',2)
title([' Year ', year,' Day ',ds])
xlabel('Time [hour]');
ylabel('Range-rate [m/s]');
grid on

hold on
file = [filepath,'KRESs213625n.PLT'];%file = [filepath,'KRESs213634n.PLT'];
inputfile=load(file);
frac=inputfile(:,2)*24;
OC_range_rate=inputfile(:,4);
% plot range rate residuals in time and frequency for last iteration 
plot(frac,OC_range_rate,'*g','LineWidth',2,'MarkerSize',2)
legend('iteration 0','iteration 1')

% hold on
% file = [filepath,'RESsu06048n.PLT'];
% inputfile=load(file);
% frac=inputfile(:,2)*24;
% OC_range_rate=inputfile(:,4);
%  %plot range rate residuals in time and frequency for last iteration 
% 
% plot(frac,OC_range_rate,'*b','LineWidth',2,'MarkerSize',2)

