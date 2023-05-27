%% Plotting for AIUB range rate residuals
%
% Written by Neda Darbeheshti, AIUB, 2020-03.
%this code is written for 2011, rowno is hardcoded for 2011
%%
clear all
close all
format longg;
GM=3.9860044150e+14;
rrtext=1*10^(-3);
%
fieldRefe='ITSG';
%filepathRefe=['/Users/neda/Documents/COSTG/DATA/EGSIEM/',fieldRefe,'/'];%filepathRefe='/Users/neda/Documents/COSTG/DATA/';
filepathRefe=['/storage/homefs/umeyer/BARBARA/COSTG/DATA/EGSIEM/',fieldRefe,'/'];
rRefe = 0.6378136300E+07;
%
fieldAiub='AIUB';
%filepathAiub=['/Users/neda/Documents/COSTG/DATA/EGSIEM/','AIUB_AIUB-RL02_90_unfiltered','/'];
filepathAiub=['/storage/homefs/nd20z315/gracetools-master/plotting/aiub_plotting/AIUB_AIUB-RL02_90_unfiltered/website/'];
rAiub=0.6378137000E+07;
%
%filepathNeda='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/';
filepathNeda='/storage/research/aiub_u_camp/NEDA/OUT/';
rModel = 0.6378137000E+07; 
%
itr='2';
fielditr2={'187','188','189','190','191','192','193','194','195','196','197','198','199','200','201','202','203','204','205','206','207','208','209','210','211','212'};
%fielditr3={'188','189','190','191','192','193','194','195','196','197','198','199','200','201','202','203','204','205','206','207','208','209','210','211','212'};
%fielditr4={'189','190','191','192','193','194','195','196','197','198','199','200','201','202','203','204','205','206','207','208','209','210','211','212'};
year='11';
month=      {'02','03','04','05','07','08','09','10','11','12'};
%no_fieldi= [21  ,31  ,30  ,31  ,27  ,31  ,30  ,29  ,15,15];%itr1(str2num(itr)-1)
no_fieldi= [21  ,31  ,30  ,31  ,26  ,31  ,30  ,29  ,15,15];%itr2(str2num(itr)-1)
%no_fieldi= [19  ,28  ,27  ,0   ,25  ,27  ,27  ,0  ,0  ,13];%itr3%OUT > ls Mi?3_1103.OUT |wc -l, itr3
%no_fieldi=  [18  ,27  ,26  ,0   ,24  ,26  ,25  ,0  ,0  ,12];%itr4
rowno=    [39  ,48  , 47 ,50  ,45  ,48  ,47  ,47  ,35  ,33];%for AIUB_AIUB-RL02_90_unfiltered
fieldi={'1','2','3','4','5','6','7','8','9','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v'};
fieldcolor=hsv(31);
%% reference for comparison
lmaxf=60;
n_back = ((lmaxf+1)^2 + lmaxf+1)/2;
%
for icounter=5:5
ggmRefe = importGravityField([filepathRefe,fieldRefe,'-Grace2018_n96_20',year,'-',month{icounter},'.gfc'],21,21+n_back);
ggmRefe = ggmRefe(1:n_back,:); % cut to desired length
%if zero-tide
ggmRefe(4,3)=ggmRefe(4,3)+4.173e-9; % tide correction
%% others
ggmAiub = importGravityField([filepathAiub,fieldAiub,'_RL2_',year,month{icounter},'_90.gfc'],rowno(icounter),rowno(icounter)+n_back);
ggmAiub= ggmAiub(1:n_back,:); % cut to desired length

%radius correction
for l=1:n_back
   fscale=(rModel/rRefe)^ggmAiub(l,1);%multiply by degree
   ggmAiub(l,3)=ggmAiub(l,3).*fscale;
   ggmAiub(l,4)=ggmAiub(l,4).*fscale;
end
%plot degree variances
figure;
d_vec = ggmRefe;
d_vec(:,3:4) = ggmRefe(:,3:4)-ggmAiub(:,3:4);
 dv_geoidnc20(d_vec,lmaxf,rRefe,'k');
 hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for imod=1:1
for imod=1:no_fieldi(icounter)
ggmi= importGravityField([filepathNeda,'Mi',fieldi{imod},itr,'_',year,month{icounter}],13,13+n_back);
ggmi= ggmi(1:n_back,:); % cut to desired length

%radius correction
for l=1:n_back
   fscale=(rModel/rRefe)^ggmi(l,1);%multiply by degree
   ggmi(l,3)=ggmi(l,3).*fscale;
   ggmi(l,4)=ggmi(l,4).*fscale;
end
%% plot degree variances 
d_vec(:,3:4) = ggmRefe(:,3:4)-ggmi(:,3:4);
dv_geoidnc20(d_vec,lmaxf,rRefe,fieldcolor(imod,:));
%text(imod*2,rrtext/imod,fieldi{imod},'Color',fieldcolor(imod,:), 'HorizontalAlignment','center')
hold on
end
dglegend=['AIUB RL02',fielditr2];
legend(dglegend,'Location','EastOutside')
title(['20',year,month{icounter},' referenced to temporal ','ITSG-GRACE2018'])
text(30,10^(-2)/2,['iteration ',itr],'Color','b')
saveas(gcf,[filepathNeda,'plots/20',year,'/degvar_neq',itr,year,month{icounter},'.png'])
end







