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
year='16';
month='03';%month={'02','03','04','05','07','08','09','10','11','12'};
%rowno=45;  %rowno={'39','48','47','50','45','48','47','47','35','33'}; for AIUB_AIUB-RL02_90_unfiltered
fieldi={'0itr'};
fieldcolor={'b','r','g','m','c'};
%% reference for comparison
lmaxf=90;
n_back = ((lmaxf+1)^2 + lmaxf+1)/2;
%
ggmRefe = importGravityField([filepathRefe,fieldRefe,'-Grace2018_n96_20',year,'-',month,'.gfc'],21,21+n_back);
ggmRefe = ggmRefe(1:n_back,:); % cut to desired length
%if zero-tide
ggmRefe(4,3)=ggmRefe(4,3)+4.173e-9; % tide correction
%% others
%ggmAiub = importGravityField([filepathAiub,fieldAiub,'_RL2_',year,month,'_90.gfc'],rowno,rowno+n_back);
%ggmAiub= ggmAiub(1:n_back,:); % cut to desired length

%radius correction
% for l=1:n_back
%    fscale=(rModel/rRefe)^ggmAiub(l,1);%multiply by degree
%    ggmAiub(l,3)=ggmAiub(l,3).*fscale;
%    ggmAiub(l,4)=ggmAiub(l,4).*fscale;
% end
%plot degree variances
% d_vec = ggmRefe;
% d_vec(:,3:4) = ggmRefe(:,3:4)-ggmAiub(:,3:4);
%  dv_geoidnc20(d_vec,lmaxf,rRefe,'k');
%  hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for imod=1:1
for imod=1:length(fieldi)
ggmi= importGravityField([filepathNeda,'GRAV',fieldi{imod},'_',year,month],13,13+n_back);
ggmi= ggmi(1:n_back,:); % cut to desired length

%radius correction
for l=1:n_back
   fscale=(rModel/rRefe)^ggmi(l,1);%multiply by degree
   ggmi(l,3)=ggmi(l,3).*fscale;
   ggmi(l,4)=ggmi(l,4).*fscale;
end
%% plot degree variances 
d_vec(:,3:4) = ggmRefe(:,3:4)-ggmi(:,3:4);
dv_geoidnc20(d_vec,lmaxf,rRefe,fieldcolor{imod});
hold on
end
dglegend=[fieldi];
legend(dglegend)
title(['20',year,month,' referenced to temporal ','ITSG-GRACE2018'])
%saveas(gcf,[filepathNeda,'plots/20',year,'/degvar',year,month,'.png'])

%%plots triangular
%showtriangle(ggmRefe, lmaxf,[-12 -6], fieldRefe)
%showtriangle(d_vec0, lmaxf,[-15 -9], 'AIUB')
% showtriangle(d_vec1, lmaxf,[-15 -9], 'AOD05RL02')
% showtriangle(d_vec2, lmaxf,[-15 -9], 'AOD06RL02')
 %showtriangle(d_vec3, lmaxf,[-15 -9], 'SESdiff')

%%plots in spatial domain
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






