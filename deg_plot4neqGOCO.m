%% Plotting for AIUB range rate residuals
%
% Written by Neda Darbeheshti, AIUB, 2020-03.
%%
clear all
close all
format longg;
GM=3.9860044150e+14;
%rrtext=1*10^(-3);
wdegree=56;
%
fieldGoco='GOCO';
filepathGoco=['/storage/homefs/nd20z315/gracetools-master/plotting/aiub_plotting/'];
rGoco=0.6378136300E+07;
%
filepathNeda='/storage/research/aiub_u_camp/NEDA/OUT/';
rModel = 0.6378137000E+07; 
%
itr='1';
year='17';
 month=      {'01','03','04','05','06'};%2017
 no_fieldi=  [31  ,15  ,29  ,31  ,29  ];%2017
% month=      {'01','03','05','06','07','08','11','12'};%2016  for'07','08','12' itr='4';
% no_fieldi=  [31  ,31  ,22  ,23  ,27  , 21 ,23  ,30 ];%2016
%month=      {'01','03','04','05','07','08'};%2015
%no_fieldi=  [17  ,31  ,30  ,10  ,25  ,31  ];%2015
%  month=     {'01','03','04','05','06','08','09','10','11'};%2014
%  no_fieldi=  [17 ,29  ,29  ,30  ,22  ,29  ,30  ,31  ,30  ];%2014
%month=     {'01','03','04','06','07','08','09','11','12'};%2012
%no_fieldi=  [31 ,31  ,17  ,29  ,31  ,31  ,26  ,23  , 29   ];%2012 ls Mi*_1001|wc -l
%month=     {'01','03','04','05','06','07','08','09','10','11','12'};%2009
%no_fieldi=  [31 ,31  ,31  ,31  ,30  ,30  ,30  ,30  ,31  , 29 , 30  ];%2009
%  month=     {'01','03','04'};%2007
%  no_fieldi=  [31 ,31  ,29  ];%2007
%month=     {'01','03','04','05','06','07','08','09','10','11','12'};%2006
%no_fieldi=  [25 ,30  ,30  ,31  ,31  ,31  ,31  ,31  ,28  , 25 , 27  ];%2006
fieldi={'1','2','3','4','5','6','7','8','9','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v'};
fieldcolor=hsv(31);
%% reference for comparison
lmaxf=60;
n_back = ((lmaxf+1)^2 + lmaxf+1)/2;
%
ggmGoco = load([filepathGoco,fieldGoco,'05S.txt']);
ggmGoco(:,6) = [];
ggmGoco(:,5) = [];
ggm01=[0 0 1 0;1 0 0 0;1 1 0 0];
ggmGoco=[ggm01;ggmGoco];
ggmGoco= ggmGoco(1:n_back,:); % cut to desired length
%if zero-tide
ggmGoco(4,3)=ggmGoco(4,3)+4.173e-9; % tide correction
%for icounter=1:length(no_fieldi)
    for icounter=4:4
figure;
for imod=1:no_fieldi(icounter)
    
ggmi= importGravityField([filepathNeda,'Mi',fieldi{imod},itr,'_',year,month{icounter}],13,13+n_back);
ggmi= ggmi(1:n_back,:); % cut to desired length
%radius correction
for l=1:n_back
   fscale=(rModel/rGoco)^ggmi(l,1);%multiply by degree
   ggmi(l,3)=ggmi(l,3).*fscale;
   ggmi(l,4)=ggmi(l,4).*fscale;
end
%% plot degree variances 
d_vec(:,3:4) = ggmGoco(:,3:4)-ggmi(:,3:4);
dv_geoidnc20neq(d_vec,lmaxf,rGoco,fieldcolor(imod,:),fieldi{imod},wdegree);
%text(imod*2,rrtext/imod,fieldi{imod},'Color',fieldcolor(imod,:), 'HorizontalAlignment','center')
hold on
end
dglegend=[fieldi];
legend(dglegend,'Location','EastOutside')
title(['20',year,month{icounter},' referenced to GOCO05S'])
%text(30,10^(-2)/2,['itr 1 '],'Color','b')
saveas(gcf,[filepathNeda,'plots/20',year,'/degvar_neq',itr,year,month{icounter},'.png'])
saveas(gcf,[filepathNeda,'plots/20',year,'/degvar_neq',itr,year,month{icounter},'.fig'])
end







