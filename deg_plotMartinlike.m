%% Plotting for AIUB range rate residuals
%
% Written by Neda Darbeheshti, AIUB, 2020-03.
%%
%Nice darker light colors to use in matlab.
% blue = [57 106 177]./255;
% red = [204 37 41]./255;
% black = [83 81 84]./255;
% green = [62 150 81]./255;
% brown = [146 36 40]./255;
% purple = [107 76 154]./255;
% cl_colors = {blue, red, black, ...
%              green, brown, purple};
% cl_str_clr_names = ["blue", "red", "black", "green", "brown", "purple"];
% %Nice ligher colors to use in matlab.
% blue = [114 147 203]./255;
% red = [211 94 96]./255;
% black = [128 133 133]./255;
% green = [132 186 91]./255;
% brown = [171 104 87]./255;
% purple = [144 103 167]./255;
% cl_colors = {blue, red, black, ...
%              green, brown, purple};
% cl_str_clr_names = ["blue", "red", "black", "green", "brown", "purple"];

clear all
close all
format longg;
GM=3.9860044150e+14;
%
fieldITSG='ITSG';%zero-tide or inclusive permanent tide
filepathITSG=['/storage/homefs/umeyer/BARBARA/COSTG/DATA/EGSIEM/',fieldITSG,'/'];
rITSG = 0.6378136300E+07;
%
fieldCSR6='CSR06';
filepathCSR6=['/storage/homefs/umeyer/COST_G/CSR/GFC/'];
rCSR6=6.3781363000E+06;
%
fieldJPL6='JPL06';%zero-tide or inclusive permanent tide
filepathJPL6=['/storage/homefs/umeyer/COST_G/JPL/GFC/'];
rJPL6 =6.3781363000e+06;
%
filepathNeda='/storage/research/aiub_u_camp/NEDA/OUT/';
rNeda = 0.6378137000E+07;
%
year='16';
for nom=1:1
figure
month={'03'};
%month={'04','05','08','09','10','11','12'};%2002
%month={'03','04','05','07','08','09','10','11','12'};%2003 '01','02','06' are not good
%month={'01','02','03','04','05','06','07','08','09','10','11','12'};%2010
%month={'02','03','04','05','07','08','09','10','11','12'};%2011
%month={'01','02','03','04','06','07','08','09','11','12'};%2012
%month={'01','02','04','05','06','07','10','11','12'}; %2013
%month={'01','03','04','05','06','08','09','10','11'};%2014
%month={'03','04','07','08','09','12'};%2015 '01','02','05' are not good
%month={'01','02','03','05','06','07','08','11','12'};%2016
%month={'01','03','04','05','06' };%2017
fieldi={'rl03ult','aiubApr','aiubAprScloff'};
fieldcolor={[62 150 81]./255,[1 0.8 0],[146 36 40]./255};
lmaxf=90;
n_back = ((lmaxf+1)^2 + lmaxf+1)/2;
%% CSR
out1= importGravityField([filepathCSR6,fieldCSR6,'_',year,month{nom},'.gfc'],126,126+4870);
out2 = vec2cs(out1(:,1:2)',out1(:,3),out1(:,4));
[ggmCSR6(:,3),ggmCSR6(:,4),nm1] = cs2vec(out2);
ggmCSR6(:,1)=nm1(1,:)';ggmCSR6(:,2)=nm1(2,:)';
ggmCSR6 = ggmCSR6(1:n_back,:); % cut to desired length
%if zero-tide
ggmCSR6(4,3)=ggmCSR6(4,3)+4.173e-9; % tide correction
clear out1 out2
%% JPL
 ggmJPL6 = importGravityField([filepathJPL6,fieldJPL6,'_',year,month{nom},'.gfc'],135,135+n_back);
 first3r=[0 0 1 0;1 0 0 0; 1 1 0 0];
 ggmJPL6=[first3r; ggmJPL6];
 ggmJPL6 = ggmJPL6(1:n_back,:); % cut to desired length
%if zero-tide
ggmJPL6(4,3)=ggmJPL6(4,3)+4.173e-9; % tide correction
%% ITSG
ggmITSG = readGFC([filepathITSG,fieldITSG,'-Grace2018_n96_20',year,'-',month{nom},'.gfc']);
ggmITSG = ggmITSG(1:n_back,:); % cut to desired length
%if zero-tide
ggmITSG(4,3)=ggmITSG(4,3)+4.173e-9; % tide correction
%% *************************************************plot degree variances
%signal
dv_geoidnc20(ggmCSR6,lmaxf,rCSR6,[0 0 0]);
hold on
d_vec_itsg = ggmCSR6;
d_vec_itsg(:,3:4) = ggmCSR6(:,3:4)-ggmITSG(:,3:4);
dv_geoidnc20(d_vec_itsg,lmaxf,rCSR6,'r');
% 
d_vec_jpl= ggmCSR6;
d_vec_jpl(:,3:4) = ggmCSR6(:,3:4)-ggmJPL6(:,3:4);
dv_geoidnc20(d_vec_jpl,lmaxf,rCSR6,'b');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d_vec= ggmCSR6;
for imod=1:length(fieldi)
ggmi= importGravityField([filepathNeda,'GRAV',fieldi{imod},'_',year,month{nom}],13,13+n_back);
ggmi= ggmi(1:n_back,:); % cut to desired length
%radius correction
for l=1:n_back
   fscale=(rNeda/rCSR6)^ggmi(l,1);%multiply by degree
   ggmi(l,3)=ggmi(l,3).*fscale;
   ggmi(l,4)=ggmi(l,4).*fscale;
end
%% plot degree variances 
d_vec(:,3:4) = ggmCSR6(:,3:4)-ggmi(:,3:4);
dv_geoidnc20(d_vec,lmaxf,rCSR6,fieldcolor{imod});

end
title(['AIUB apr:fullScale vs. diagScale'])
legend('signal CSR 1601','ITSG','JPL',fieldi{1},'aiub fullScale','aiub diagScale','Location','NorthEastOutside')%,'AIUBRL02','JPLRL06','GFZRL06','CSRRL06','GFZRL06'
saveas(gcf,[filepathNeda,'plots/20',year,'/degvarMartinlike',year,month{nom},'.png'])
end





