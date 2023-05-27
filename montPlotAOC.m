%%Outlier detection for each day
%
% Written by Neda Darbeheshti, AIUB, 2021-05. For SEDNA:
%%
clear all
close all
format longg;
fform='png';
year='07';
%year='11';%month={'02','03','04','05','07','08','09','10','11','12'};
%year='12' ;%month={'01','02','03','04','06','07','08','09','11','12'};
%year='16' ;%month={'01','02','03','04','06','07','08','09','11','12'};
%year='17' ;%month={'01','03','04','05','06'};
KBRname='GRC';%'GRCSth',  GFO 'gfoY_';%for GFO
rls='RL03';
filepath=['/storage/research/aiub_u_camp/NEDA/ORB/'];%'RL03'
%filepath=['/storage/research/aiub_data/DATAPOOL/LEO/GRACE/2006/RL02/KBR/nonbz2/'];%'RL02'
filepathNeda=['/storage/research/aiub_u_camp/NEDA/OUT/'];
%% %%%%%%%%%%%%%%%%%2002
%'04';d = [94:117 119:120];'05';d = [121:139 142:151];
%'07';d = [182:212];'08';d = [213:243];'09';d = [244:273];'10';d = [274:304];'11';d = [305:334];'12';d = [335:365];
%%%%%%%%%%%%%%%%%%%2003
%'01';d = [1:31];'02';d = [32:59];'03';d = [60:90];'04';d = [92: 120];'05';d = [121:151];'06';d = [152:174 176:181];
%'07';d = [182:212];'08';d = [213:243];'09';d = [244:273];'10';d = [274:304];'11';d = [305:334];'12';d = [335:365];
%%%%%%%%%%%%%%%%%%%2004
%' 01';d = [1:15];'2';d = [34:60];'3';d = [61:91];'4';d = [92: 121];'5';d = [122:152];'6';d = [153:182];
%'7';d = [183:213];'8';d = [214:244];'9';d = [245:274];'10';d = [275:305];'11';d = [306:335];'12';d = [336:344 347:366];
%%%%%%%%%%%%%%%%%%%2005
%01';d = [1:31];'02';d = [32:59];'03';d = [60:90];'04';d = [92: 120];'05';d = [121:151];'06';d = [152:181];
%'07';d = [182:212];'08';d = [213:243];'09';d = [244:273];'10';d = [274:304];'11';d = [305:334];'12';d = [335:343,345:365];
%%%%%%%%%%%%%%%%%%%2006
%'01';d = [1:31];'02';d = [32:59];'03';d = [60:90];'04';d = [92: 120];'05';d = [121:151];'06';d = [152:181];
%'07';d = [182:212];'08';d = [213:243];'09';d = [244:273];'10';d = [274:304];'11';d = [305:334];'12';d = [335:365];
%%%%%%%%%%%%%%%%%%%2007
%'01';d = [1:31];'02';d = [32:59];'03';d = [60:90];'04';d = [92: 120];'05';d = [121:151];'06';d = [152:181];
%'07';d = [182:212];'08';d = [213:243];'09';d = [244:273];'10';d = [274:304];'11';d = [305:334];'12';d = [335:365];
%%%%%%%%%%%%%%%%%%%2008
%' 01';d = [1:31];'2';d = [32:60];'3';d = [61:91];'4';d = [92: 121];'5';d = [122:152];'6';d = [153:182];
%'7';d = [183:213];'8';d = [214:244];'9';d = [245:274];'10';d = [275:305];'11';d = [306:335];'12';d = [336:366];
%%%%%%%%%%%%%%%%%%%2009
%'01';d = [1:31];'02';d = [32:59];'03';d = [60:90];'04';d = [92: 120];'05';d = [121:151];'06';d = [152:181];
%'07';d = [182:212];'08';d = [213:243];'09';d = [244:273];'10';d = [274:304];'11';d = [305:334];'12';d = [335:365];
%%%%%%%%%%%%%%%%%%%2010
%'01';d = [1:31];'02';d = [32:59];'03';d = [60:90];'04';d = [92: 120];'05';d = [121:151];'06';d = [152:181];
%'07';d = [182:212];'08';d = [213:243];'09';d = [244:273];'10';d = [274:304];'11';d = [305:334];'12';d = [335:365];
%%%%%%%%%%%%%%%%%%%2012 
%d = [1:31];   %1201     %d = [32:60];  %1202    %d = [61:91];   %1203    %d = [92 :121]          %1204  
%d = [141:152];%1205     %d = [153:182];%1206    %d = [183:213]; %1207    %d = [214:244];        %1208
%d = [245:274];%1209                             %d = [306:335]; %1211    %d = [336:342,344:366];%1212
%month='12';d = [336:366];
%%%%%%%%%%%%%%%%%%%2013
%d = [1:31];%1301 d = [32:59]; %1302 d = [101:120];%1304 d = [121:151];%1305
%d = [152:181];%06 d = [182:212];%07 d = [274:304];%10 d = [305:334];1311  
%d= [335:358 362:365];1312
%%%%%%%%%%%%%%%%%%%2014
%d = [1:17];01 d = [54:59];02 d = [60:90];03 d = [91:120];04 ;d =
%[121:151];05  d = [152:175];06 d = [213:243];08 d = [244:273];09 
%d = [274:304];10 %d=[305:334];11
%%%%%%%%%%%%%%%%%%%2015
%'01';d = [13:31]; '02';d = [32:59]; '03';d = [60:90]; '04';d = [91:120];
%'05';d = [121:131 ];'07';d = [182:187, 194:212];'08';d = [213:243];
%'09';d = [244:270];'12';d = [345:365];
%%%%%%%%%%%%%%%%%%%2016
%d = [315,318:335];1611 d = [336:366];1612
%%%%%%%%%%%%%%%%%%%2017 
%'01';d = [1:31];'03';d = [76:90];'04';d = [91:120];'05';d = [121:151];'06';d = [152:180];
%%%%%%%%%%%%%%%%%%%GFO
%'01';d = [1:38];%'11';d = [305:334];
%%%%%%%%%%%%%%%%%%%2020
%'2';d = [32:59];
month='01';d = [1:31];
sec2hor=3600*24;
m_ant_rate=[];
m_rrate=[];
m_dtec=[];
matime_hour=[];
mdtime_hour=[];
cons=-(320)^2/40.30;
for dn=1:length(d)
    %for dn=1:1
ds = sprintf('%03d',d(dn));% %03d for day of the  year
% load KBR data
    data_KBR = [filepath,KBRname,year,ds,'0.KBR'];
    KBRB = readKBRion(data_KBR);
    %KBRB = readKBRgfo(data_KBR);%for GFO
    time_=d(dn)+(KBRB(:,1)-KBRB(1,1))/sec2hor;
    %time_=(KBRB(:,1)-KBRB(1,1))/sec2hor;
    %iono_cor=KBRB(:,5)-mean(KBRB(:,5));
    %iono_cor=KBRB(:,5);
    %dtec = diff(iono_cor); % 1 element less
    %dtec = dtec*cons;
    ant_rate=KBRB(:,10)*10^(6);
%     ave_ant_rate(dn)=rms(ant_rate);
%     rrate=KBRB(:,3);
%     ave_rrate(dn)=rms(rrate);
%% plots
%m_dtec=[m_dtec;dtec];
m_ant_rate=[m_ant_rate;ant_rate];
%m_rrate=[m_rrate;rrate];
matime_hour=[matime_hour;time_];
%mdtime_hour=[mdtime_hour;time_(2:end)];
clear data_KBR KBRB time_ ant_rate
end
%TF= isoutlier(m_dtec,'median');
%% plots
%ionosphere correction
% figure
% plot(mdtime_hour,m_dtec,'.','color','b')
% %ylabel('${\Delta} TEC\TECU$','Interpreter','latex');
% ylabel('$\Delta TEC[TECU]$ ','Interpreter','latex');
% %xlim([10.85 21.89])
% title ({['20',year,' ',month]});
% grid on
% saveas(gcf,[filepathNeda,'plots/20',year,'/ionkbr4month_woutlier','_',year,month],fform)
% %ionosphere correction without outliers
% figure
% plot(mdtime_hour(~TF),m_dtec(~TF),'.','color','b')
% %ylabel('${\Delta} TEC\TECU$','Interpreter','latex');
% ylabel('$\Delta TEC[TECU]$ ','Interpreter','latex');
% title ({['20',year,' ',month]});
% grid on
% saveas(gcf,[filepathNeda,'plots/20',year,'/ionkbr4month','_',year,month],fform)
%antena offset rate correction
treshl(1:length(m_ant_rate))=-1;
treshh(1:length(m_ant_rate))=1;
figure
plot(matime_hour,m_ant_rate,'.','color','k')
hold on
plot(treshl,'color','r')
hold on
plot(treshh,'color','r')
ylabel('$AOC[\mu m/s]$','Interpreter','latex');
xlabel('$Day$','Interpreter','latex');
title ({[rls,'  20',year,' ',month]});
grid on
xlim([min(d) max(d)]);
set(gca,'XTick',[min(d):2:max(d)])
saveas(gcf,[filepathNeda,'plots/20',year,'/antkbr4month',rls,'_',year,month],fform)
%
% figure
% plot(matime_hour,m_rrate,'.','color','k')
% ylabel('$\dot{\rho}[m/s]$','Interpreter','latex');
% title ({['20',year,' ',month]});
% grid on
% saveas(gcf,[filepathNeda,'plots/20',year,'/rrkbr4month','_',year,month],fform)
%avarage plots
% figure
% plot(d,ave_ant_rate,'.','color','k')
% ylabel('$AOC[\mu m/s]RMS$','Interpreter','latex');
% xlabel('$Day$','Interpreter','latex');
% title ({['20',year,' ',month]});
% grid on
% xlim([min(d) max(d)]);
% set(gca,'XTick',[min(d):2:max(d)])
% saveas(gcf,[filepathNeda,'plots/20',year,'/rms_antkbr4month','_',year,month],fform)
% %
% figure
% plot(d,ave_rrate,'.','color','k')
% ylabel('$\dot{\rho}[m/s]RMS$','Interpreter','latex');
% xlabel('$Day$','Interpreter','latex');
% title ({['20',year,' ',month]});
% grid on
% xlim([min(d) max(d)]);
% set(gca,'XTick',[min(d):2:max(d)])
% saveas(gcf,[filepathNeda,'plots/20',year,'/rms_rrkbr4month','_',year,month],fform)


