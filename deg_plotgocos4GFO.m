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
%/storage/homefs/umeyer/COST_G/AIUB/GFC
filepathAIUB=['/storage/homefs/nd20z315/gracetools-master/plotting/aiub_plotting/AIUB_AIUB-RL02_90_unfiltered/'];
rAIUB =  0.637813630E+07;
%
fieldITSG='ITSG';%zero-tide or inclusive permanent tide
filepathITSG=['/storage/homefs/umeyer/BARBARA/COSTG/DATA/EGSIEM/',fieldITSG,'/'];
rITSG = 0.6378136300E+07;
% fieldCSR6='CSR06';
% filepathCSR6=['/storage/homefs/umeyer/COST_G/CSR/GFC/'];
fieldGFZ6='GFZ06';
filepathGFZ6=['/storage/homefs/umeyer/COST_G/GFZ/GFC/'];
rGFZ6= 6.3781364600E+06;    
%
fieldJPL6='JPL06';%zero-tide or inclusive permanent tide
filepathJPL6=['/storage/homefs/umeyer/COST_G/JPL/GFC/'];
rJPL6 =6.3781363000e+06;
%
fieldGoco='GOCO';
filepathGoco=['/storage/homefs/nd20z315/gracetools-master/plotting/aiub_plotting/'];
rGoco=0.6378136300E+07;
%
filepathNeda='/storage/research/aiub_u_camp/NEDA/OUT/';
rNeda = 0.6378137000E+07;
%
year='19';
for nom=1:1
figure
%month={'01','04'};
%month={'04','05','08','09','10','11','12'};%2002
%month={'03','04','05','07','08','09','10','11','12'};%2003 '01','02','06' are not good
%month={'01','02','03','04','05','06','07','08','09','10','11','12'};%2010
%month={'02','03','04','05','07','08','09','10','11','12'};%2011
%month={'01','02','03','04','06','07','08','09','11','12'};%2012
%month={'01','02','04','05','06','07','10','11','12'}; %2013
%month={'01','03','04','05','06','08','09','10','11'};%2014
%month={'03','04','07','08','09','12'};%2015 '01','02','05' are not good
month={'01','02','03','05','06','07','08','11','12'};%2016
%month={'01','03','04','05','06' };%2017
fieldi={'scatshift'};%,'rl03const8','rl03const8nofilter'
%fieldi={'empKinKb_bias333_accSBF_i0_AIUB_APR','empKinKb_bias333_accSBF_i1_AIUB_APR','empKinKb_bias333_accSBF_i2_AIUB_APR','empKinKb_bias333_accSBF_i3_AIUB_APR','empKinKb_bias333_accSBF_i4_AIUB_APR'};
%fieldi={'empKinKb_bias333_accSBFfullScale_i0_AIUB_APR','empKinKb_bias333_accSBFfullScale_i1_AIUB_APR','empKinKb_bias333_accSBFfullScale_i2_AIUB_APR'};
%fieldi={'empKinKb_accRSW_i0_AIUB_APR','empKinKb_accRSW_i1_AIUB_APR','empKinKb_accRSW_i2_AIUB_APR','empKinKb_accRSW_i3_AIUB_APR','empKinKb_accRSW_i4_AIUB_APR'};
%fieldi={'empKinKb_accSBF_i0_AIUB_APR','empKinKb_accSBF_i1_AIUB_APR','empKinKb_accSBF_i2_AIUB_APR','empKinKb_accSBF_i3_AIUB_APR','empKinKb_accSBF_i4_AIUB_APR'};
fieldcolor={'b','c','m','r','k','y'};
lmaxf=90;
n_back = ((lmaxf+1)^2 + lmaxf+1)/2;
%% AIUB
 %ggmAIUB = readGFC([filepathAIUB,fieldAIUB,'02r_',year,month{nom},'.gfc']);
%% official
%  out1=load([filepathGFZ6,fieldGFZ6,'_',year,month{nom},'.txt']);
%  out2 = vec2cs(out1(:,1:2)',out1(:,3),out1(:,4));
%  [ggmGFZ6(:,3),ggmGFZ6(:,4),nm1] = cs2vec(out2);
%  ggmGFZ6(:,1)=nm1(1,:)';ggmGFZ6(:,2)=nm1(2,:)';
%  ggmGFZ6 = ggmGFZ6(1:n_back,:); % cut to desired length
 %radius correction
% for l=1:n_back
%    fscaleg=(rGFZ6/rGoco)^ggmGFZ6(l,1);%multiply by degree
%    ggmGFZ6(l,3)=ggmGFZ6(l,3).*fscaleg;
%    ggmGFZ6(l,4)=ggmGFZ6(l,4).*fscaleg;
% end
% clear out1 out2
%% ggmCSR6 = importGravityField([filepathCSR6,fieldCSR6,'_',year,month{nom},'.gfc'],126,126+n_back);
%  ggmJPL6 = importGravityField([filepathJPL6,fieldJPL6,'_',year,month{nom},'.gfc'],135,135+n_back);
%  first3r=[0 0 1 0;1 0 0 0; 1 1 0 0];
%  ggmJPL6=[first3r; ggmJPL6];
%  ggmJPL6 = ggmJPL6(1:n_back,:); % cut to desired length
% %if zero-tide
% ggmJPL6(4,3)=ggmJPL6(4,3)+4.173e-9; % tide correction
% %% ITSG
% ggmITSG = readGFC([filepathITSG,fieldITSG,'-Grace2018_n96_20',year,'-',month{nom},'.gfc']);
% ggmITSG = ggmITSG(1:n_back,:); % cut to desired length
% %if zero-tide
% ggmITSG(4,3)=ggmITSG(4,3)+4.173e-9; % tide correction
%% Goco
ggmGoco = load([filepathGoco,fieldGoco,'05S.txt']);
ggmGoco(:,6) = [];
ggmGoco(:,5) = [];
ggm01=[0 0 1 0;1 0 0 0;1 1 0 0];
ggmGoco=[ggm01;ggmGoco];
ggmGoco= ggmGoco(1:n_back,:); % cut to desired length
%if zero-tide
ggmGoco(4,3)=ggmGoco(4,3)+4.173e-9; % tide correction
%% *************************************************plot degree variances
% d_vec_itsg = ggmGoco;
% d_vec_itsg(:,3:4) = ggmGoco(:,3:4)-ggmITSG(:,3:4);
% dv_geoidnc20(d_vec_itsg,lmaxf,rGoco,[0 0 0]);
% hold on
% d_vec_gfz(:,3:4) = ggmGoco(:,3:4)-ggmGFZ6(:,3:4);
% dv_geoidnc20(d_vec_gfz,lmaxf,rGoco,[0.5 1 0]);
% %
% d_vec_jpl= ggmGoco;
% d_vec_jpl(:,3:4) = ggmGoco(:,3:4)-ggmJPL6(:,3:4);
% dv_geoidnc20(d_vec_jpl,lmaxf,rGoco,[1 0 0.5]);
% %
% d_vec_aiub= ggmGoco;
% d_vec_aiub(:,3:4) = ggmGoco(:,3:4)-ggmAIUB(:,3:4);
% dv_geoidnc20(d_vec_aiub,lmaxf,rGoco,[.5 .5 .5]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d_vec= ggmGoco;
for imod=1:length(fieldi)
ggmi= importGravityField([filepathNeda,'GRAV',fieldi{imod},'_',year,month{nom}],13,13+n_back);
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

end
title(['20',year,month{nom},' referenced to GOCO05S'])
legend('scatshift','Location','southwest')%,'AIUBRL02','JPLRL06','GFZRL06','CSRRL06','GFZRL06'
saveas(gcf,[filepathNeda,'plots/20',year,'/degvar',year,month{nom},'.png'])
%% plot triangles
% showtriangle(d_vec_itsg, lmaxf,[-15 -9], 'ITSG')
% saveas(gcf,[filepathNeda,'plots/20',year,'/tri4itsg',year,month,'.png'])
% showtriangle(d_vec, lmaxf,[-15 -9],['20',year,month{nom},fieldi{end}])
% saveas(gcf,[filepathNeda,'plots/20',year,'/tri4',fieldi{end},year,month{nom},'.png'])
end


%ggmAIUB = readGFC([filepathAIUB,fieldAIUB,'_RL2_',year,month{nom},'_90.gfc']);
%ggmAIUB = readGFC([filepathAIUB,fieldAIUB,'02r_',year,month{nom},'.gfc']);
% %ggmAIUB =importGravityField([filepathNeda,'GRAV','rl03b','_',year,month],13,13+n_back);
% ggmAIUB= ggmAIUB(1:n_back,:); % cut to desired length
% %radius correction
% for l=1:n_back
%    fscale=(rAIUB/rGoco)^ggmAIUB(l,1);%multiply by degree
%    ggmAIUB(l,3)=ggmAIUB(l,3).*fscale;
%    ggmAIUB(l,4)=ggmAIUB(l,4).*fscale;
% end


