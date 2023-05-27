%%Outlier detection for each day
%
% Written by Neda Darbeheshti, AIUB, 2020-12.
%%
clear all
close all
format longg;
fform='png';
year='06';
kinid='ES2';
filepath=['/storage/research/aiub_u_camp/NEDA/STA/'];
filepathNeda=['/storage/research/aiub_u_camp/NEDA/OUT/'];
% GRACE A
file=[filepath,'RMS',kinid,year,'KINA'];
%file=[filepath,'RMS',year,'KINA'];
FID=fopen(file);
datacella = textscan(FID, '%s%s%f', 'CollectOutput', 1);
fclose(FID);
kina_rms=datacella{1,2}(:,1);
kina_day=datacella{1,1}(:,1);
for dn=1:length(kina_day)
dayna(dn)=str2num(kina_day{dn}(7:9));
%dayna(dn)=str2num(kina_day{dn}(8:10));
end
% GRACE B
%file=[filepath,'RMS',year,'KINB'];
file=[filepath,'RMS',kinid,year,'KINB'];
FID=fopen(file);
datacellb = textscan(FID, '%s%s%f', 'CollectOutput', 1);
fclose(FID);
kinb_rms=datacellb{1,2}(:,1);
kinb_day=datacellb{1,1}(:,1);
for dn=1:length(kinb_day)
daynb(dn)=str2num(kinb_day{dn}(7:9));
%daynb(dn)=str2num(kinb_day{dn}(8:10));
end
%% plots
figure
plot(dayna,kina_rms,'.','color','b')
hold on
plot(daynb,kinb_rms,'.','color','r')
xlim([1 366])
%xlim([91 120])
ylabel('$Orbit RMS[m]$','Interpreter','latex');
xlabel('$Day$','Interpreter','latex');
title ({['20',year,kinid]});
grid on
legend('GRACE A','GRACE B');
set(gca)
saveas(gcf,[filepathNeda,'plots/20',year,'/rms',kinid,'kin4year','_',year],fform)




