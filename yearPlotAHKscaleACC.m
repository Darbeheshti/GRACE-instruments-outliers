%%Outlier detection for each day
%
% Written by Neda Darbeheshti, AIUB, 2020-12.
%%
clear all
close all
format longg;
year='15';
filepath=['/storage/research/aiub_data/DATAPOOL/LEO/GRACE/GRACE1BJPLRL02/20',year,'/ascs/'];
filepathNeda=['/storage/research/aiub_u_camp/NEDA/OUT/'];
itr='rl03b';
stepname='FinM';%d0 or FinM
id='a';
idg='A';
d=[1:365];
head_no=40;%different header, 50 for 20110910 ,42 for 200701
%% load AHK data
for dn=1:length(d)
ds = sprintf('%03d',d(dn));
file = [filepath,'GRC',idg,year,ds,'0.AHK'];
FID=fopen(file);
datacella = textscan(FID, '%f%f%s%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f', 'HeaderLines', head_no, 'CollectOutput', 1);
fclose(FID);
ahka = datacella{3};
ahkt3=ahka(:,13);
mean_ahkt3(dn)=mean(rmmissing(ahkt3));
clear  datacella  ahka  ahkt3 
end
%% load scale for a year
file=[filepathNeda,stepname,itr,year,id,'_scl11'];
FID=fopen(file);
datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
fclose(FID);
acca_scl11=datacell{1,2}(:,2);
acc_day=datacell{1,3}(:,4);% the time just once
% %%%%%%%%%%%%%%%
% file=[filepathNeda,stepname,itr,year,id,'_scl22'];
% FID=fopen(file);
% datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
% fclose(FID);
% acca_scl22=datacell{1,2}(:,2);
%%%%%%%%%%%%%%%
% file=[filepathNeda,stepname,itr,year,id,'_scl33'];
% FID=fopen(file);
% datacell = textscan(FID, '%s%s%s%s%s%f%f%f%f%s%s%s%s%s', 'CollectOutput', 1);
% fclose(FID);
% acca_scl33=datacell{1,2}(:,2);
%% %%%%%%%%plots
lday=1;
uday=234;
 %% sub plots
figure
subplot(2,1,1)
plot(mean_ahkt3,'color',[.5 .5 .5],'LineWidth',3)
xlim([1 365])
ylabel('$Temperature[^{\circ} C]$','Interpreter','latex');
xlabel('$Day$','Interpreter','latex');
title ({['20',year,' ',idg]});
subplot(2,1,2)
plot(datetime(acc_day(lday:uday)),acca_scl11(lday:uday),'.r','MarkerSize',10)
ylabel('$s_x$ (along)[-]','Interpreter','latex');
saveas(gcf,[filepathNeda,'plots/20',year,'/ahk4year2sub','_',year,id],'png')
 %% two sided plot
figure
yyaxis left
plot(mean_ahkt3,'color',[.5 .5 .5],'LineWidth',3)
ylabel('$temperature[^{\circ} C]$','Interpreter','latex');
yyaxis right
plot((acca_scl11(lday:uday)),'.r','MarkerSize',10)
ylabel('$s_x$ (along)[-]','Interpreter','latex');
grid on
ax = gca;
ax.YAxis(1).Color = [.5 .5 .5];
ax.YAxis(2).Color = 'r';
xlim([1 365])
title ({['20',year,' ',idg]});
saveas(gcf,[filepathNeda,'plots/20',year,'/ahk4year2side','_',year,id],'png')





