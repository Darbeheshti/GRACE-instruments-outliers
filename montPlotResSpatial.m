%% Plotting for AIUB range rate residuals and thruster data, monthly spatial
% Written by Neda Darbeheshti, AIUB, 2022-05.
% jan 2007
% april 2014
% jan 2015 april 2015
%% # creat monthly file of residuals
% /storage/research/aiub_u_camp/NEDA/OUT
% kbr_res_id=D0KbaiubApr03rls
% year=15
% for (( co=14; co<=31; co++ ))
% do
%  awk 'NR>=13{printf "%16.15e %16.15e %16.15e %6i %16.15e\n",$8,$9,$7,$1,$2}' ${kbr_res_id}${year}0${co}0.RES >> LatLonD0Kb${year}
% done
%% # creat monthly plot of THR
% /storage/research/aiub_data/DATAPOOL/LEO/GRACE/GRACE1BJPLRL02/
%   
% thr_id=THR1B_20
% year=15  
% sat_id=A
% month=1
% # sum of 12 columns
% for (( co=14; co<=14; co++ ))
% do
%  awk 'NR>=65{printf "%9i %4i \n",$1,$19+$20+$21+$22+$23+$24+$25+$26+$27+$28+$29+$30}' ${thr_id}${year}-0${month}-${co}_${sat_id}_02.asc >> ${thr_id}${year}-month0${month}_${sat_id}
% done
% 
% for (( co=16; co<=31; co++ ))
% do
%  awk 'NR>=65{printf "%9i %4i \n",$1,$19+$20+$21+$22+$23+$24+$25+$26+$27+$28+$29+$30}' ${thr_id}${year}-0${month}-${co}_${sat_id}_02.asc >> ${thr_id}${year}-month0${month}_${sat_id}
% done
clear all
close all
format longg;
%% residual file
filepath=['/storage/research/aiub_u_camp/NEDA/OUT/'];% also path for plotting
file = [filepath,'LatLonD0Kb15'];
Month_D0Kb=load(file);
lat=Month_D0Kb(:,1);
lon=Month_D0Kb(:,2);
res=Month_D0Kb(:,3);
% time and time conversion
mjd_res=Month_D0Kb(:,4)+Month_D0Kb(:,5);
iso_res = mjd2iso(mjd_res);
gracegps_res = iso2gracegps(iso_res, 'GPS');
%% thruster file
year='15';month='01';gt='A';
filepathTHR=['/storage/research/aiub_data/DATAPOOL/LEO/GRACE/GRACE1BJPLRL02/20',year,'/ascs/'];
fileTHR = [filepathTHR,'THR1B_20',year,'-','month',month,'_',gt];
Month_THR=load(fileTHR);
gracegps_thr=Month_THR(:,1);
sum12_thr_ontime=Month_THR(:,2);
% interpolate lat&lon from residual file
lat_thr = spline(gracegps_res,lat,gracegps_thr);
lon_thr = spline(gracegps_res,lon,gracegps_thr);
%% plotting
sz = 7;
% residuals
% figure
% scatter(lon,lat,sz,res,'filled')
% title(['Month ',month,' 20',year])
% xlabel('Lon');
% ylabel('Lat');
% xlim([-190 190])
% ylim([-100 100])
% h = colorbar;
% set(get(h,'label'),'string','$\dot\rho[m/s]$','Interpreter','latex');
% saveas(gcf,[filepath,'plots/20',year,'/D0KbSpatial',year,month,'.png'])
% therusters
figure
scatter(lon_thr,lat_thr,sz,sum12_thr_ontime,'filled')
title(['GRACE ',gt,' Month ',month,' 20',year])
colorbar; 
caxis([0 250]);
xlabel('Lon');
ylabel('Lat');
xlim([-190 190])
ylim([-100 100])
colorbar
h = colorbar;
set(get(h,'label'),'string','thruster on-time[millisec]');
saveas(gcf,[filepath,'plots/20',year,'/ThrSpatial',year,month,gt,'.png'])

% avaregae 
% sum 6
% grace-f0 begining to mid 2021































