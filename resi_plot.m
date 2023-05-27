%% Plotting for AIUB range rate residuals
%
% Written by Neda Darbeheshti, AIUB, 2021-06.
%%
clear all
close all
format longg;
filepath=['/storage/research/aiub_u_camp/NEDA/OUT/'];
filepathNeda=['/storage/research/aiub_u_camp/NEDA/OUT/'];
year='17';%07
apriori='aiubApr8cons';%rl03ult
itr='D0';%'D3';%'d3';
did='0';%0,a,b
d=[148];%14
%
htext=1;
xotext=.15;
rtext=1*10^(-4);
rrtext=1*10^(-6);
for dn=1:length(d)
ds = sprintf('%03d',d(dn));
%% load GRACE A file  
file = [filepath,itr,'C',apriori,year,ds,did,'.RES'];
%input=load(file);
fileID = fopen(file);
input = textscan(fileID,'%f %f %f %f %f %f %f %f %s %f %f %f');
fclose(fileID);
%
fracg=cell2mat(input(:,1));
fracg= fracg/60;
xr=cell2mat(input(:,6));
ya=cell2mat(input(:,7));
zc=cell2mat(input(:,8));
% plot position in time and frequency for last iteration 
figure
subplot(4,1,1);
plot(fracg,xr,'.r','LineWidth',2,'MarkerSize',2)
hold on 
plot(fracg,ya,'.g','LineWidth',2,'MarkerSize',2)
hold on 
plot(fracg,zc,'.b','LineWidth',2,'MarkerSize',2)
title ({['Year ',year,ds,did],'       '});
ylabel('$A[m]$','Interpreter','latex');
%legend('Radial','Along-track','Cross-track')
grid on
txt = num2str((round(rms(xr),4)));
text(htext,xotext,txt,'Color','red')
txt = num2str((round(rms(ya),4)));
text((htext+10),xotext,txt,'Color','g')
txt =num2str((round(rms(zc),4)));
text((htext+20),xotext,txt,'Color','blue')
axis([0 24 -0.09 0.09])
set(gca,'XTick',[0:2:24])
%% load GRACE B file
file = [filepath,itr,'D',apriori,year,ds,did,'.RES'];
fileID = fopen(file);
input = textscan(fileID,'%f %f %f %f %f %f %f %f %s %f %f %f');
fclose(fileID);
%
fracg=cell2mat(input(:,1));
fracg= fracg/60;
xr=cell2mat(input(:,6));
ya=cell2mat(input(:,7));
zc=cell2mat(input(:,8));
% plot position in time and frequency for last iteration 
subplot(4,1,2);
plot(fracg,xr,'.r','LineWidth',2,'MarkerSize',2)
hold on 
plot(fracg,ya,'.g','LineWidth',2,'MarkerSize',2)
hold on 
plot(fracg,zc,'.b','LineWidth',2,'MarkerSize',2)
ylabel('$B[m]$','Interpreter','latex');
grid on
txt = num2str((round(rms(xr),4)));
text(htext,xotext,txt,'Color','red')
txt = num2str((round(rms(ya),4)));
text((htext+10),xotext,txt,'Color','g')
txt =num2str((round(rms(zc),4)));
text((htext+20),xotext,txt,'Color','blue')
axis([0 24 -0.09 0.09])
set(gca,'XTick',[0:2:24])
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
[~, frac, ~, ~, ~, ~ ,OC_range_rate, ~, ~, ~, ~ ] = textread(file,'%f %f %f %f %f %f %f %f %f %f %f','headerlines',header);
% plot range residuals in time and frequency for last iteration 
subplot(4,1,3);
plot(frac*24,OC_range_rate,'.c','LineWidth',2,'MarkerSize',2)
ylabel('$\rho[m]$','Interpreter','latex');
grid on
txt = num2str(round(rms(OC_range_rate),4));
text((htext+10),rtext,txt,'Color','k')
axis([0 24 -10^(-3) 10^(-3)])
set(gca,'XTick',[0:2:24])
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
[~, frac, ~, ~, ~, ~ ,OC_range_rate, ~,~, ~, ~ ] = textread(file,'%f %f %f %f %f %f %f %f %f %f %f','headerlines',header);
%plot range rate residuals in time and frequency for last iteration 
subplot(4,1,4);
plot(frac*24,OC_range_rate,'.m','LineWidth',2,'MarkerSize',2)
ylabel('$\dot\rho[m/s]$','Interpreter','latex');
xlabel('Time [hour]');
grid on
txt = num2str(round(rms(OC_range_rate),7));
text((htext+10),rrtext,txt,'Color','k')
axis([0 24 -10^(-6) 10^(-6)])
set(gca,'XTick',[0:2:24])
saveas(gcf,[filepathNeda,'plots/20',year,'/okres_',itr,apriori,'_',year,ds,did],'png')
clear fracg xr ya zc frac OC_range_rate
end



















