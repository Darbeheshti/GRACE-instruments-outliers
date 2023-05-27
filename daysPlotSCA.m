%%Outlier detec tion for each day
%
% Written by Neda Darbeheshti, AIUB, 2020-12.
%%
clear all
close all
format longg;
fform='png';
year='03';
rls='RL03';
filepath=['/storage/research/aiub_u_camp/NEDA/ORB/'];%'RL03'
%filepath=['/storage/research/aiub_data/DATAPOOL/LEO/GRACE/2006/RL02/KBR/nonbz2/'];%'RL02'
filepathNeda=['/storage/research/aiub_u_camp/NEDA/OUT/'];
kbr_id='GRC';%'GRCSth' for 2011,2016 & 2017 'GFO' for gfo
sca_id='GRC';
d=[80];
%d=[94:118 121:137 217 221 240 244 261 264 272 275 276 278 281 290 299:301 309:310 314:315 319:322 329:330 338:340 343:346 351:353 358:359   ];%2002
%d=[3 4 5 8 13:19 21:31 32:35 38 41:48 50 51 54:59 66 68 69 71 78  80 94:111 114:118  128:137 142:147 153 158 217 236;238 259 265 266 281 305:308 322 327:332 337 344 351 ];%2003
%d=[13 14 15 34 35 37 40 42 43 47 76 89:91 93 96 117:118 124 131:135 145 215:218 222 223  225 231 250 252 273 318 320 321 330 336  340 341 ];%2004
%d=[1 2 19 41 49 50 55 61 76 96 118 119 131 149 158 160 164 258 262 299 300 319  337 342:346 358 ];%2005
%% d=[ 8 9 11 26 48 54 84 85 109 110 157 164 184 185 190 217 225:243:250 257 263 284 285 290 326 333 362];2006
%d=[4 38 64 66 69 100 107 109 116 123 143 155 184 244:245 269 311 319 320 344];%2007
%d=[28 29 34 35 57 76 135 146:152 153:160 177 183 205 206 220 226  245,247  252:254 280 303 325 326 352:353 358];%2008
%d=[35 36 37 61:63 77 78 85 87 94  108 120 136 137 152 153  163 171 201 209:212 217:218 222 284 285 301 311 312 325  338 343 360:361];2009
%d=[22 27:28  61 67:69 74 76 79 87 93:95 98 107 108 117:120 121:151 152:153 159:160 166  168:171 188 195 224 230  245 272 285 286 292 294 319 ];2010
%d=[15 32 37 42 46 51 56 59 63 70 109 186 202 207 212 216  257 337 340 341 342 344]%2012
%d=[3 4 20 21 28 121 122 127 148 149 155  163 166  170 171 197 198 277:287 290 297:298 311:320 322:323 326:329 ];%2013
%d=[7 82 101 104 108  109 112 114 115 118  122 125 129 130 156 157 215 228 257 262 268 305 310 314 330];2014
%d=[13 15 41:43 60 63 68 69 72 76 87 88 96 115  116 131 208 217 226 233  244 252 258:261 265 365 ],2015
%d=[325:330,335, 356:362]%2016 
%d=[ 6 7 27 28 76 77 88 89 90 107:111 117:120 121 122 126:130 133:136 139:143 148:152 152:158];%2017
sec2hor=3600;
ds = sprintf('%03d',d);% %03d for day of the  year
% load KBR data
    data_KBR = [filepath,kbr_id,year,ds,'0.KBR'];
    %KBRB = readKBRgfo(data_KBR);%for GFO
    KBRB = readKBRion(data_KBR);
    time_KBRX=(KBRB(:,1)-KBRB(1,1))/sec2hor;
    ant_rate=KBRB(:,10)*10^(6);
% load SCAA data
    data_SCAA = [filepath,sca_id,'A',year,ds,'0.ATT'];
    SCAA = readSCA(data_SCAA);
    time_SCAA=(SCAA(:,1)-SCAA(1,1))/sec2hor;
    q_A_noisy=SCAA(:,2:5);
% load SCAB data
    data_SCAB = [filepath,sca_id,'B',year,ds,'0.ATT'];
    SCAB = readSCA(data_SCAB);
    time_SCAB=(SCAB(:,1)-SCAB(1,1))/sec2hor;
    q_B_noisy=SCAB(:,2:5);
%% plots
 treshl(1:length(ant_rate))=-1;
 treshh(1:length(ant_rate))=+1;
%antena offset rate correction
figure
plot(time_KBRX,ant_rate,'.','color','k')
hold on
plot(time_KBRX,treshl,'color','r')
plot(time_KBRX,treshh,'color','r')
plot(time_KBRX,treshl-2,'-b')
plot(time_KBRX,treshh+2,'-b')
ylabel('$AOC[\mu m/s]$','Interpreter','latex');
xlabel('$Time$','Interpreter','latex');
title ({[rls, '  20',year,' ',ds]});
grid on
xlim([0 24]);
set(gca,'XTick',[0:2:24])
saveas(gcf,[filepathNeda,'plots/20',year,'/antkbr',rls,'_',year,ds],fform)
% ASD plot
% ASD_pw(ant_rate,.2,'ASD [$\mu m/s/ \sqrt{Hz}$]');
% saveas(gcf,[filepathNeda,'plots/20',year,'/antkbrASD',rls,'_',year,ds],fform)
% A quaternions
figure
subplot(4,1,1)
plot(time_SCAA,q_A_noisy(:,1))
ylabel('$q_0$','Interpreter','latex');
grid on
xlim([0 24]);
set(gca,'XTick',[0:2:24])
title ({[rls, ' GRACE A  20',year,' ',ds]});
subplot(4,1,2)
plot(time_SCAA,q_A_noisy(:,2))
ylabel('$q_1$','Interpreter','latex');
grid on
xlim([0 24]);
set(gca,'XTick',[0:2:24])
subplot(4,1,3)
plot(time_SCAA,q_A_noisy(:,3))
ylabel('$q_2$','Interpreter','latex');
grid on
xlim([0 24]);
set(gca,'XTick',[0:2:24])
subplot(4,1,4)
plot(time_SCAA,q_A_noisy(:,4))
ylabel('$q_3$','Interpreter','latex');
xlabel('$Time$','Interpreter','latex');
grid on
xlim([0 24]);
set(gca,'XTick',[0:2:24])
saveas(gcf,[filepathNeda,'plots/20',year,'/scaa',rls,'_',year,ds],fform)
% B quaternions
figure
subplot(4,1,1)
plot(time_SCAB,q_B_noisy(:,1))
ylabel('$q_0$','Interpreter','latex');
grid on
xlim([0 24]);
set(gca,'XTick',[0:2:24])
title ({[rls, ' GRACE B  20',year,' ',ds]});
subplot(4,1,2)
plot(time_SCAB,q_B_noisy(:,2))
ylabel('$q_1$','Interpreter','latex');
grid on
xlim([0 24]);
set(gca,'XTick',[0:2:24])
subplot(4,1,3)
plot(time_SCAB,q_B_noisy(:,3))
ylabel('$q_2$','Interpreter','latex');
grid on
xlim([0 24]);
set(gca,'XTick',[0:2:24])
subplot(4,1,4)
plot(time_SCAB,q_B_noisy(:,4))
ylabel('$q_3$','Interpreter','latex');
xlabel('$Time$','Interpreter','latex');
grid on
xlim([0 24]);
set(gca,'XTick',[0:2:24])
saveas(gcf,[filepathNeda,'plots/20',year,'/scab',rls,'_',year,ds],fform)

figure
ASD_pw(q_A_noisy(:,1),1,'ASD [$\mu m/s/ \sqrt{Hz}$]');
figure
ASD_pw(q_A_noisy(:,2),1,'ASD [$\mu m/s/ \sqrt{Hz}$]');
figure
ASD_pw(q_A_noisy(:,3),1,'ASD [$\mu m/s/ \sqrt{Hz}$]');
figure
ASD_pw(q_A_noisy(:,4),1,'ASD [$\mu m/s/ \sqrt{Hz}$]');

s = spectrogram(q_A_noisy(:,1));
figure
spectrogram(q_A_noisy(:,4),'yaxis')


N = 1024;
n = 0:N-1;

w0 = 2*pi/5;
x = sin(w0*n)+10*sin(2*w0*n);
figure
plot(x)




















