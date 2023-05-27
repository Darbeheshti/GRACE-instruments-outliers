%% Plotting for AIUB range rate residuals
%
% Written by Neda Darbeheshti, AIUB, 2020-03.
%%
clear all
close all
format longg;

rgac = 0.6378136460E+07;
rggm = 0.6378137000E+07; % radius correction
lmaxf=90;
n_back = ((lmaxf+1)^2 + lmaxf+1)/2;
%
fieldRefe='EIGEN6-C4';
fieldAiub='AIUB';
filepathRefe='/Users/neda/Documents/COSTG/DATA/';
filepathAiub='/Users/neda/Documents/COSTG/DATA/EGSIEM/AIUB/';
filepathNeda='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/';
year='06';
month={'02','03','05','07','08','11'};
fielduliaod05='uliaod05';
fielduliaod06='uliaod06';
field05={'GAC-2_2006032-2006059_0028_EIGEN_G---_0005',...
         'GAC-2_2006060-2006090_0030_EIGEN_G---_0005',...
         'GAC-2_2006121-2006151_0031_EIGEN_G---_0005',...
         'GAC-2_2006182-2006212_0031_EIGEN_G---_0005',...
         'GAC-2_2006213-2006243_0031_EIGEN_G---_0005',...
         'GAC-2_2006305-2006334_0030_EIGEN_G---_0005'};             
field06={'GAC-2_2006032-2006059_GRAC_GFZOP_BC01_0600',...
         'GAC-2_2006060-2006090_GRAC_GFZOP_BC01_0600',...
         'GAC-2_2006121-2006151_GRAC_GFZOP_BC01_0600',...
         'GAC-2_2006182-2006212_GRAC_GFZOP_BC01_0600',...
         'GAC-2_2006213-2006243_GRAC_GFZOP_BC01_0600',...
         'GAC-2_2006305-2006334_GRAC_GFZOP_BC01_0600'};
%% reference for comparison
lmaxf6=180;
n_back6 = ((lmaxf6+1)^2 + lmaxf6+1)/2;
ggmRefed = importGravityField([filepathRefe,fieldRefe,'.gfc'],15,15+n_back6);
out1 = vec2cs(ggmRefed(:,1:2)',ggmRefed(:,3),ggmRefed(:,4));
[outC1,outS1,nm1] = cs2vec(out1,false); %degreewise
ggmRefe = [nm1',outC1',outS1'];
ggmRefe= ggmRefe(1:n_back,:); % cut to desired length

for plot_count=1:6
%% ggm solution 
ggmAiub = importGravityField([filepathAiub,fieldAiub,'_',year,month{plot_count},'.gfc'],11,11+n_back);
ggmAiub= ggmAiub(1:n_back,:); % cut to desired length

ggmuliaod05 = importGravityField([filepathNeda,'GRAV',fielduliaod05,'_',year,month{plot_count}],13,13+n_back);
ggmuliaod05= ggmuliaod05(1:n_back,:); % cut to desired length

ggmuliaod06 = importGravityField([filepathNeda,'GRAV',fielduliaod06,'_',year,month{plot_count}],13,13+n_back);
ggmuliaod06= ggmuliaod06(1:n_back,:); % cut to desired length

for l=1:n_back
   fscale=(rggm/rgac)^ggmuliaod06(l,1);
   ggmuliaod05(l,3)=ggmuliaod05(l,3).*fscale;
   ggmuliaod05(l,4)=ggmuliaod05(l,4).*fscale;
   ggmuliaod06(l,3)=ggmuliaod06(l,3).*fscale;
   ggmuliaod06(l,4)=ggmuliaod06(l,4).*fscale;
end
%% gac model    
gacaod05 = importGravityField([field05{plot_count}],5,5+n_back);
gacaod05= gacaod05(1:n_back,:); % cut to desired length

lmaxf6=180;
n_back6 = ((lmaxf6+1)^2 + lmaxf6+1)/2;
gacaod06 = importGravityField([field06{plot_count}],127,127+n_back6);

out1 = vec2cs(gacaod06(:,1:2)',gacaod06(:,3),gacaod06(:,4));
[outC1,outS1,nm1] = cs2vec(out1,false); %degreewise
gacaod06d = [nm1',outC1',outS1'];
gacaod06d= gacaod06d(1:n_back,:); % cut to desired length
%% plot degree variances 
 d_vec0 = gacaod05;
 d_vec1 = gacaod05;
 d_vec0(:,3:4) = gacaod05(:,3:4)-gacaod06d(:,3:4);
%  figure
%  dv_geoidnc20(d_vec0,lmaxf,rgac,'b')
%  hold on
%  d_vec1(:,3:4) = ggmuliaod05(:,3:4)-ggmuliaod06(:,3:4);
%  dv_geoidnc20(d_vec1,lmaxf,rgac,'r');
%  legend('gac','ggm')
%  title(['20',year,month{plot_count}])
 
 showtriangle(d_vec0, lmaxf,[-15 -9], 'GACdiff05-06')
 %showtriangle(d_vec1, lmaxf,[-15 -9], 'AODdif05-06')
% figure
% dv_geoidn(ggmaod05,lmaxf,rRefe)
% hold on
% dv_geoidn(ggmaod06d,lmaxf,rRefe)
% legend('AOD05','AOD06')
% 
% title(['20',year,month{plot_count}])
end
% radiusmodel = 0.6378137000E+07; % radius correction
% for l=1:n_back
%   fscale=(radiusmodel/rRefe)^ggmuliaod06(l,1);
%    ggmuliaod05(l,3)=ggmuliaod05(l,3).*fscale;
%    ggmuliaod05(l,4)=ggmuliaod05(l,4).*fscale;
%    ggmuliaod06(l,3)=ggmuliaod06(l,3).*fscale;
%    ggmuliaod06(l,4)=ggmuliaod06(l,4).*fscale;
% end

% plot degree variances 
% d_vec = ggmRefe;
% 
% d_vec(:,3:4) = ggmRefe(:,3:4)-ggmAiub(:,3:4);
% dv_geoidnc20(d_vec,lmaxf,rRefe,'r');
% hold on
% 
% d_vec(:,3:4) = ggmRefe(:,3:4)-ggmuliaod05(:,3:4);
% dv_geoidnc20(d_vec,lmaxf,rRefe,'g');
% hold on
% 
% d_vec(:,3:4) = ggmRefe(:,3:4)-ggmuliaod06(:,3:4);
% dv_geoidnc20(d_vec,lmaxf,rRefe,'b');
% hold on
% 
% legend('AIUB','RSW','SBF03')
% 
% title(['20',year,month,' referenced to ',fieldRefe])




    



% 'GAC-2_2006001-2006031_0031_EIGEN_G---_0005'	'GAC-2_2006182-2006212_0031_EIGEN_G---_0005'
% 'GAC-2_2006032-2006059_0028_EIGEN_G---_0005'	'GAC-2_2006213-2006243_0031_EIGEN_G---_0005'
% 'GAC-2_2006060-2006090_0030_EIGEN_G---_0005'	'GAC-2_2006244-2006273_0030_EIGEN_G---_0005'
% 'GAC-2_2006091-2006120_0030_EIGEN_G---_0005'	'GAC-2_2006274-2006304_0031_EIGEN_G---_0005'
% 'GAC-2_2006121-2006151_0031_EIGEN_G---_0005'	'GAC-2_2006305-2006334_0030_EIGEN_G---_0005'
% 'GAC-2_2006152-2006181_0028_EIGEN_G---_0005'	'GAC-2_2006335-2006365_0028_EIGEN_G---_0005'

% GAC-2_2006001-2006031_GRAC_GFZOP_BC01_0600	GAC-2_2006182-2006212_GRAC_GFZOP_BC01_0600
% GAC-2_2006032-2006059_GRAC_GFZOP_BC01_0600	GAC-2_2006213-2006243_GRAC_GFZOP_BC01_0600
% GAC-2_2006060-2006090_GRAC_GFZOP_BC01_0600	GAC-2_2006244-2006273_GRAC_GFZOP_BC01_0600
% GAC-2_2006091-2006120_GRAC_GFZOP_BC01_0600	GAC-2_2006274-2006304_GRAC_GFZOP_BC01_0600
% GAC-2_2006121-2006151_GRAC_GFZOP_BC01_0600	GAC-2_2006305-2006334_GRAC_GFZOP_BC01_0600
% GAC-2_2006152-2006181_GRAC_GFZOP_BC01_0600	GAC-2_2006335-2006365_GRAC_GFZOP_BC01_0600






