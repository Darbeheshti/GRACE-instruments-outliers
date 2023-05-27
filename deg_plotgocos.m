%% Plotting for AIUB range rate residuals
%
% Written by Neda Darbeheshti, AIUB, 2020-03.
%%
clear all
close all
format longg;
GM=3.9860044150e+14;
%
fieldAIUB='AIUB';
%filepathAIUB=['/Users/neda/Documents/COSTG/DATA/EGSIEM/AIUB_bachelor/'];%%just for 2016
%filepathAIUB=['/Users/neda/Documents/COSTG/DATA/EGSIEM/','AIUB_AIUB-RL02_90_unfiltered','/'];
rAIUB = 0.6378137000E+07;
%
fieldITSG='ITSG';
filepathITSG=['/storage/homefs/umeyer/BARBARA/COSTG/DATA/EGSIEM/ITSG',fieldITSG,'/'];
rITSG = 0.6378136300E+07;
%
fieldGoco='GOCO';
filepathGoco=['/storage/homefs/nd20z315/gracetools-master/plotting/aiub_plotting'];
rGoco=0.6378136300E+07;
%
filepathNeda='/storage/research/aiub_u_camp/NEDA/OUT';
rNeda = 0.6378137000E+07; 
%
year='11';
month='09';%month={'02','03','04','05','07','08','09','10','11','12'};
rowno=47;  %rowno= [39  ,48  , 47 ,50  ,45  ,48  ,47  ,47  ,35  ,33]; %for AIUB_AIUB-RL02_90_unfiltered
fieldi={'3par','dpar','dparBsbf'};
%fieldi={'rl03','rl03i1','rl03i2','rl03neda','rl03ulig','rl03ulit','rl03ulitstatic','rl03ulitstt'};
fieldcolor={'b','r','g','m','c','y','k','b'};
lmaxf=90;
n_back = ((lmaxf+1)^2 + lmaxf+1)/2;
%% AIUB
%ggmAIUB= importGravityField([filepathAIUB,fieldAIUB,'_',year,month],13,13+n_back);%just for 2016
ggmAIUB = importGravityField([filepathAIUB,fieldAIUB,'_RL2_',year,month,'_90.gfc'],rowno,rowno+n_back);
ggmAIUB= ggmAIUB(1:n_back,:); % cut to desired length
%radius correction
for l=1:n_back
   fscale=(rAIUB/rGoco)^ggmAIUB(l,1);%multiply by degree
   ggmAIUB(l,3)=ggmAIUB(l,3).*fscale;
   ggmAIUB(l,4)=ggmAIUB(l,4).*fscale;
end
%% ITSG
ggmITSG = importGravityField([filepathITSG,fieldITSG,'-Grace2018_n96_20',year,'-',month,'.gfc'],21,21+n_back);
ggmITSG = ggmITSG(1:n_back,:); % cut to desired length
%if zero-tide
ggmITSG(4,3)=ggmITSG(4,3)+4.173e-9; % tide correction
%% Goco
ggmGoco = load([filepathGoco,fieldGoco,'05S.txt']);
ggmGoco(:,6) = [];
ggmGoco(:,5) = [];
ggm01=[0 0 1 0;1 0 0 0;1 1 0 0];
ggmGoco=[ggm01;ggmGoco];
ggmGoco= ggmGoco(1:n_back,:); % cut to desired length
%if zero-tide
ggmGoco(4,3)=ggmGoco(4,3)+4.173e-9; % tide correction
%plot degree variances
d_vec = ggmGoco;
d_vec(:,3:4) = ggmGoco(:,3:4)-ggmITSG(:,3:4);
dv_geoidnc20(d_vec,lmaxf,rGoco,[0 0 0]);
hold on
d_vec(:,3:4) = ggmGoco(:,3:4)-ggmAIUB(:,3:4);
dv_geoidnc20(d_vec,lmaxf,rGoco,[.5 .5 .5]);
hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for imod=1:1
for imod=1:length(fieldi)
ggmi= importGravityField([filepathNeda,'GRAV',fieldi{imod},'_',year,month],13,13+n_back);
ggmi= ggmi(1:n_back,:); % cut to desired length
%radius correction
for l=1:n_back
   fscale=(rNeda/rGoco)^ggmi(l,1);%multiply by degree
   ggmi(l,3)=ggmi(l,3).*fscale;
   ggmi(l,4)=ggmi(l,4).*fscale;
end
%% plot degree variances 
d_vec(:,3:4) = ggmGoco(:,3:4)-ggmi(:,3:4);
dv_geoidnc20(d_vec,lmaxf,rGoco,fieldcolor{imod});
hold on
end
title(['20',year,month,' referenced to GOCO05S'])
legend(['ITSG','AIUB',fieldi])
saveas(gcf,[filepathNeda,'plots/20',year,'/degvar',year,month,'.png'])









