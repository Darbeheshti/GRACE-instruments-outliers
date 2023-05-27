%% Plotting for AIUB range rate residuals
%
% Written by Neda Darbeheshti, AIUB, 2020-03.
%%
clear all
close all
format longg;
GM=3.9860044150e+14;
%
fieldRefe='ITSG';
filepathRefe=['/Users/neda/Documents/COSTG/DATA/EGSIEM/',fieldRefe,'/'];%filepathRefe='/Users/neda/Documents/COSTG/DATA/';
rRefe = 0.6378136300E+07;
%
fieldAiub='AIUB';
filepathAiub=['/Users/neda/Documents/COSTG/DATA/EGSIEM/','AIUB_AIUB-RL02_90_unfiltered','/'];
rAiub=0.6378137000E+07;
%
filepathNeda='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/';
rModel = 0.6378137000E+07; 
%
year='11';
month='05';%month={'02','03','04','05','07','08','09','10','11','12'};
rowno=50;  %rowno={'39','48','47','50','45','48','47','47','35','33'}; for AIUB_AIUB-RL02_90_unfiltered
%% reference for comparison
lmaxf=90;
n_back = ((lmaxf+1)^2 + lmaxf+1)/2;
%
ggmRefe = importGravityField([filepathRefe,fieldRefe,'-Grace2018_n96_20',year,'-',month,'.gfc'],21,21+n_back);
ggmRefe = ggmRefe(1:n_back,:); % cut to desired length
%if zero-tide
ggmRefe(4,3)=ggmRefe(4,3)+4.173e-9; % tide correction
%% others
ggmAiub = importGravityField([filepathAiub,fieldAiub,'_RL2_',year,month,'_90.gfc'],rowno,rowno+n_back);
ggmAiub= ggmAiub(1:n_back,:); % cut to desired length

field1='rl03neda';
field2='rl03ulit';
for ggmi=1:length(field)

ggm1 = importGravityField([filepathNeda,'GRAV',field1,'_',year,month],13,13+n_back);
ggm1= ggm1(1:n_back,:); % cut to desired length

ggm2 = importGravityField([filepathNeda,'GRAV',field2,'_',year,month],13,13+n_back);
ggm2= ggm2(1:n_back,:); % cut to desired length

 %ggm3 = importGravityField([filepathNeda,'GRAV',field3,'_',year,month],13,13+n_back);
 %ggm3= ggm3(1:n_back,:); % cut to desired length

%radius correction
for l=1:n_back
   fscale=(rModel/rRefe)^ggm1(l,1);%multiply by degree
   ggm1(l,3)=ggm1(l,3).*fscale;
   ggm1(l,4)=ggm1(l,4).*fscale;
   ggm2(l,3)=ggm2(l,3).*fscale;
   ggm2(l,4)=ggm2(l,4).*fscale;
   %ggm3(l,3)=ggm3(l,3).*fscale;
   %ggm3(l,4)=ggm3(l,4).*fscale;
   ggmAiub(l,3)=ggmAiub(l,3).*fscale;
   ggmAiub(l,4)=ggmAiub(l,4).*fscale;
end
%% plot degree variances 
d_vec0 = ggmRefe;
d_vec1 = ggmRefe;
d_vec2 = ggmRefe;
d_vec3 = ggmRefe;
d_vec4 = ggmRefe;
%
d_vec0(:,3:4) = ggmRefe(:,3:4)-ggmRefe1(:,3:4);
d_vec1(:,3:4) = ggmRefe(:,3:4)-ggmAiub(:,3:4);
d_vec2(:,3:4) = ggmRefe(:,3:4)-ggm1(:,3:4);
d_vec3(:,3:4) = ggmRefe(:,3:4)-ggm2(:,3:4);
% d_vec4(:,3:4) = ggmRefe(:,3:4)-ggm3(:,3:4);
%
%dv_geoidnc20(ggmRefe,lmaxf,rRefe,'k');
%hold on
%dv_geoidnc20(d_vec0,lmaxf,rRefe,'c');
%hold on
dv_geoidnc20(d_vec1,lmaxf,rRefe,'g');
hold on
dv_geoidnc20(d_vec2,lmaxf,rRefe,'b');
hold on
 dv_geoidnc20(d_vec3,lmaxf,rRefe,'r');
  %hold on
 %dv_geoidnc20(d_vec4,lmaxf,rRefe,'c');
legend('AIUB RL02','AIUB RL03neda','AIUB RL03ulit')
%legend('Signal','ITSG-GRACE2016','AIUB RL03')
%legend('Signal','AIUB RL02','AOD05','AOD06','Difference')
 %legend('Signal','AIUB RL02','Level1BRL02','Level1BRL03','Difference')
%legend('Signal','AIUB RL02','Old gap table','New session table','Difference')
title(['20',year,month,' referenced to temporal ','ITSG-GRACE2018'])
%% plots triangular
%showtriangle(ggmRefe, lmaxf,[-12 -6], fieldRefe)
%showtriangle(d_vec0, lmaxf,[-15 -9], 'AIUB')
% showtriangle(d_vec1, lmaxf,[-15 -9], 'AOD05RL02')
% showtriangle(d_vec2, lmaxf,[-15 -9], 'AOD06RL02')
 %showtriangle(d_vec3, lmaxf,[-15 -9], 'SESdiff')

%% plots in spatial domain
% figure
% plot_geoid_diff(ggm1,ggm2,GM,rRefe,lmaxf)
% title(['SESdiff ','year 20',year,' month ',month])
% figure
% plot_geoid_diff(ggmRefe,ggm1,GM,rRefe,lmaxf)
% %title(['year 20',year,' month ',month,' ss referenced to ',reference])
% figure
% plot_geoid_diff(ggmRefe,ggm2,GM,rRefe,lmaxf)
% %title(['year 20',year,' month ',month,' AIUB referenced to ',reference])


    







% ggmRefe1 = importGravityField([filepathRefe,fieldRefe,'-Grace2016_n90_20',year,'-',month,'.gfc'],18,18+n_back);
% ggmRefe1 = ggmRefe1(1:n_back,:); % cut to desired length
% %if zero-tide
% ggmRefe1(4,3)=ggmRefe1(4,3)+4.173e-9; % tide correction

%fieldRefe='EIGEN6-C4';
% lmaxf6=180;
% n_back6 = ((lmaxf6+1)^2 + lmaxf6+1)/2;
% ggmRefed = importGravityField([filepathRefe,fieldRefe,'.gfc'],15,15+n_back6);
% if degreewise
% out1 = vec2cs(ggmRefed(:,1:2)',ggmRefed(:,3),ggmRefed(:,4));
% [outC1,outS1,nm1] = cs2vec(out1,false); %degreewise
% ggmRefe = [nm1',outC1',outS1'];
% ggmRefe= ggmRefe(1:n_back,:); % cut to desired length






