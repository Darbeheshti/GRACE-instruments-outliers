%% Plotting like Klinger 2016 page 114, Fig 8.1
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
dvAIUB=[]; 
%
fieldITSG='ITSG';%zero-tide or inclusive permanent tide
filepathITSG=['/storage/homefs/umeyer/BARBARA/COSTG/DATA/EGSIEM/',fieldITSG,'/'];
rITSG = 0.6378136300E+07;
dvITSG=[]; 
% fieldCSR6='CSR06';
% filepathCSR6=['/storage/homefs/umeyer/COST_G/CSR/GFC/'];
fieldGFZ6='GFZ06';
filepathGFZ6=['/storage/homefs/umeyer/COST_G/GFZ/GFC/'];
rGFZ6= 6.3781364600E+06;    
%
fieldJPL6='JPL06';%zero-tide or inclusive permanent tide
filepathJPL6=['/storage/homefs/umeyer/COST_G/JPL/GFC/'];
rJPL6 =6.3781363000e+06;
dvJPL=[];
%
fieldGoco='GOCO';
filepathGoco=['/storage/homefs/nd20z315/gracetools-master/plotting/aiub_plotting/'];
rGoco=0.6378136300E+07;
%
filepathNeda='/storage/research/aiub_u_camp/NEDA/OUT/';
rNeda = 0.6378137000E+07;
dvNEDA=[];
%
year='16';
for nom=1:9
figure
%month={'01','02','03','04','05','06','07','08','09','10','11','12'};
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
fieldi={'rl03ult'};
fieldcolor={'b','c','m','r','k','y'};
lmaxf=90;
n_back = ((lmaxf+1)^2 + lmaxf+1)/2;
%% AIUB
%  ggmAIUB = readGFC([filepathAIUB,fieldAIUB,'02r_',year,month{nom},'.gfc']);
%% official
%  out1=load([filepathGFZ6,fieldGFZ6,'_',year,month{nom},'.txt']);
%  out2 = vec2cs(out1(:,1:2)',out1(:,3),out1(:,4));
%  [ggmGFZ6(:,3),ggmGFZ6(:,4),nm1] = cs2vec(out2);
%  ggmGFZ6(:,1)=nm1(1,:)';ggmGFZ6(:,2)=nm1(2,:)';
%  ggmGFZ6 = ggmGFZ6(1:n_back,:); % cut to desired length
%  %radius correction
% for l=1:n_back
%    fscaleg=(rGFZ6/rGoco)^ggmGFZ6(l,1);%multiply by degree
%    ggmGFZ6(l,3)=ggmGFZ6(l,3).*fscaleg;
%    ggmGFZ6(l,4)=ggmGFZ6(l,4).*fscaleg;
% end
% clear out1 out2
%% ggmCSR6 = importGravityField([filepathCSR6,fieldCSR6,'_',year,month{nom},'.gfc'],126,126+n_back);
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
d_vec_itsg = ggmGoco;
d_vec_itsg(:,3:4) = ggmGoco(:,3:4)-ggmITSG(:,3:4);
dvMonthI=dv_geoidnc20(d_vec_itsg,lmaxf,rGoco,[0 0 0]);
dvITSG=[dvITSG; dvMonthI];
hold on
% d_vec_gfz(:,3:4) = ggmGoco(:,3:4)-ggmGFZ6(:,3:4);
% dv_geoidnc20(d_vec_gfz,lmaxf,rGoco,[0.5 1 0]);
%
d_vec_jpl= ggmGoco;
d_vec_jpl(:,3:4) = ggmGoco(:,3:4)-ggmJPL6(:,3:4);
dvMonthJ=dv_geoidnc20(d_vec_jpl,lmaxf,rGoco,[1 0 0.5]);
dvJPL=[dvJPL; dvMonthJ];
%
% d_vec_aiub= ggmGoco;
% d_vec_aiub(:,3:4) = ggmGoco(:,3:4)-ggmAIUB(:,3:4);
% dvMonthA=dv_geoidnc20(d_vec_aiub,lmaxf,rGoco,[.5 .5 .5]);
% dvAIUB=[dvAIUB; dvMonthA];
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
dvMonthN=dv_geoidnc20(d_vec,lmaxf,rGoco,fieldcolor{imod});
dvNEDA=[dvNEDA; dvMonthN];
end
title(['20',year,month{nom},' referenced to GOCO05S'])
legend('ITSG','JPLRL06','AIUBRL03','Location','southwest')%,'AIUBRL02','JPLRL06','GFZRL06','CSRRL06','GFZRL06'
%saveas(gcf,[filepathNeda,'plots/20',year,'/degvar',year,month{nom},'.png'])
end

clims = [10^(-5) 10^(-3)];
% % set limits for the caxis
% caxis([log10(clims(1)) log10(clims(2))]);
% % preallocate Ticks and TickLabels
% num_of_ticks = 5;
% Ticks      = zeros(1,num_of_ticks);
% TickLabels = zeros(1,num_of_ticks);
% % distribute Ticks and TickLabels
% for n = 1:1:num_of_ticks
%     
%     Ticks(n)      = log10(round(clims(2))/num_of_ticks*n);
%     TickLabels(n) = round(clims(2))/num_of_ticks*n;
% end

figure
imagesc(rGoco*dvITSG,clims)
title(['20',year, ' ITSG referenced to GOCO05S'])
xlabel('Spherical Harmonic Degree')
ylabel('Month')
set(gca,'YTick',[1:1:12])
%colorbar('Ticks',Ticks,'TickLabels',TickLabels)
h = colorbar('southoutside');
h.Label.String ='Geoid Heights (m)';
saveas(gcf,[filepathNeda,'plots/20',year,'/degvarcolor','ITSG',year,'.png'])

% figure
% imagesc(rGoco*dvAIUB,clims)
% title(['20',year, ' AIUBRL02 referenced to GOCO05S'])
% xlabel('Spherical Harmonic Degree')
% ylabel('Month')
% set(gca,'YTick',[1:1:12])
% h = colorbar('southoutside');
% h.Label.String ='Geoid Heights (m)';
% saveas(gcf,[filepathNeda,'plots/20',year,'/degvarcolor','AIUBRL02',year,'.png'])

figure
imagesc(rGoco*dvJPL,clims)
title(['20',year, ' JPLRL06 referenced to GOCO05S'])
xlabel('Spherical Harmonic Degree')
ylabel('Month')
set(gca,'YTick',[1:1:12])
h = colorbar('southoutside');
h.Label.String ='Geoid Heights (m)';
saveas(gcf,[filepathNeda,'plots/20',year,'/degvarcolor','JPLRL06',year,'.png'])

figure
imagesc(rGoco*dvNEDA,clims)
title(['20',year, ' AIUBRL03 referenced to GOCO05S'])
xlabel('Spherical Harmonic Degree')
ylabel('Month')
set(gca,'YTick',[1:1:12])
h = colorbar('southoutside');
h.Label.String ='Geoid Heights (m)';
saveas(gcf,[filepathNeda,'plots/20',year,'/degvarcolor','AIUBRL03',year,'.png'])
