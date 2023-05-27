clear all
close all
format longg;
c20_const=0.4841694723127*10^(-3);
tide_const=4.173e-9;% zero-tide correction
%grep "gfc     2    0 " ITSG-Grace2018_n96_2*> c20_ITSG
fieldITSG='ITSG';
filepathITSG=['/storage/homefs/umeyer/BARBARA/COSTG/DATA/EGSIEM/',fieldITSG,'/'];
%
file=[filepathITSG,'c20_',fieldITSG];
FID=fopen(file);
datacell= textscan(FID, '%s%f%f%f%f%f%f', 'CollectOutput', 1);
fclose(FID);
c20_ITSG=datacell{1,2}(:,3);
c20_ITSG=c20_ITSG+tide_const;% zero-tide correction
%
time_convert=cell2mat(datacell{1,1}(:,1));
mont_convert=time_convert(:,20:26);
for dn=1:length(mont_convert)
mon_ITSG{dn}=[mont_convert(dn,:) '-01'];
end 
clear datacell time_convert mont_convert
%grep "GRCOF2    2    0" JPL06_* > c20_JPL
fieldJPL6='JPL';
filepathJPL6=['/storage/homefs/umeyer/COST_G/JPL/GFC/'];
%
file=[filepathJPL6,'c20_',fieldJPL6];
FID=fopen(file);
datacell = textscan(FID, '%s%f%f%f%f%f%f%f%f%s', 'CollectOutput', 1);
fclose(FID);
c20_JPL=datacell{1,2}(:,3);
c20_JPL=c20_JPL+tide_const;% zero-tide correction
%
time_convert=cell2mat(datacell{1,1}(:,1));
year_convert=time_convert(:,7:8);
mont_convert=time_convert(:,9:10);
for dn=1:length(mont_convert)
mon_JPL{dn}=['20' year_convert(dn,:) '-' mont_convert(dn,:) '-01'];
end 
clear datacell time_convert mont_convert year_convert
%grep "gfc    2    0" AIUB02r_*> c20_AIUB02
fieldAIUB02='AIUB02';
filepathAIUB02=['/storage/homefs/nd20z315/gracetools-master/plotting/aiub_plotting/AIUB_AIUB-RL02_90_unfiltered/'];
%
file=[filepathAIUB02,'c20_',fieldAIUB02];
FID=fopen(file);
datacell = textscan(FID, '%s%f%f%f%f%f%f%f%f%s', 'CollectOutput', 1);
fclose(FID);
c20_AIUB02=datacell{1,2}(:,3);
%
time_convert=cell2mat(datacell{1,1}(:,1));
year_convert=time_convert(:,9:10);
mont_convert=time_convert(:,11:12);
for dn=1:length(mont_convert)
mon_AIUB02{dn}=['20' year_convert(dn,:) '-' mont_convert(dn,:) '-01'];
end 
clear datacell time_convert mont_convert year_convert
%grep "GEOCOE    2    0" GRAVrl03ult_*> c20_AIUB03
fieldAIUB03='AIUB03';
filepathNeda='/storage/research/aiub_u_camp/NEDA/OUT/';
%
file=[filepathNeda,'c20_',fieldAIUB03];
FID=fopen(file);
datacell = textscan(FID, '%s%f%f%f%f%f%f%s%f', 'CollectOutput', 1);
fclose(FID);
c20_AIUB03=datacell{1,2}(:,3);
%
time_convert=cell2mat(datacell{1,1}(:,1));
year_convert=time_convert(:,13:14);
mont_convert=time_convert(:,15:16);
for dn=1:length(mont_convert)
mon_AIUB03{dn}=['20' year_convert(dn,:) '-' mont_convert(dn,:) '-01'];
end 
clear datacell time_convert mont_convert year_convert
%% plotting
figure
plot(datetime(mon_ITSG),c20_ITSG+c20_const','color',[0 0 0],'LineWidth',2)
hold on 
plot(datetime(mon_JPL),c20_JPL+c20_const,'color',[1 0 0.5],'LineWidth',2)
plot(datetime(mon_AIUB02),c20_AIUB02+c20_const,'color',[.5 .5 .5],'LineWidth',2)
plot(datetime(mon_AIUB03),c20_AIUB03+c20_const,'color','b','LineWidth',2)
%ylabel('$$','Interpreter','latex');
xlabel('$Year$','Interpreter','latex');
title(['C20+',c20_const])
grid on
%xlim([datetime(2004-01-01) datetime(2016-01-01)]);
legend('ITSG','JPLRL06','AIUBRL02','AIUBRL03')%'AIUBRL02','JPLRL06','GFZRL06','CSRRL06','GFZRL06'
saveas(gcf,[filepathNeda,'plots/2002','/c20time','.png'])