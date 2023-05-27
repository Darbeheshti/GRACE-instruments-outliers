%% Plotting like Klinger 2016 page 114, Fig 8.1
%
% Written by Neda Darbeheshti, AIUB, 2020-03.
%%
clear all
close all
format longg;
%
lmaxf=90;
n_back = ((lmaxf+1)^2 + lmaxf+1)/2;
%% Goco
fieldGoco='GOCO';
filepathGoco=['/storage/homefs/nd20z315/gracetools-master/plotting/aiub_plotting/'];
rGoco  = 0.6378136300E+07;
%
ggmGoco = load([filepathGoco,fieldGoco,'05S.txt']);
ggmGoco(:,6) = [];
ggmGoco(:,5) = [];
ggm01=[0 0 1 0;1 0 0 0;1 1 0 0];
ggmGoco=[ggm01;ggmGoco];
ggmGoco= ggmGoco(1:n_back,:); % cut to desired length
%if zero-tide
ggmGoco(4,3)=ggmGoco(4,3)+4.173e-9; % tide correction
%% GRACE
%input='input_AIUB03P_gfc.m';
%'input_CSR6'; just up to DO60 fro gfc files
data = { 'input_ITSG18_gfc.m';
         'input_AIUB02_gfc.m';
         'input_AIUB03P_gfc.m';
                };
rinput = [6.3781363000e+06 0.637813630E+07 0.6378137000E+07];   
for kk=3:3   
run(data{kk})
n = length(t);
dv_input=[];

for k=1:1
    %for k=1:n
%ggmi= importGravityField(fields(k,:),13,13+n_back);
ggmi =readGFC(fields(k,:));
ggmi= ggmi(1:n_back,:); % cut to desired length-not needed for AIUB
%ggmi(4,3)=ggmi(4,3)+4.173e-9; % tide correction for zero-tide
%radius correction
for l=1:n_back
   fscale=(rinput(kk)/rGoco)^ggmi(l,1);%multiply by degree
   ggmi(l,3)=ggmi(l,3).*fscale;
   ggmi(l,4)=ggmi(l,4).*fscale;
end
%accumulate degree variances 
d_vec(:,3:4) = ggmGoco(:,3:4)-ggmi(:,3:4);
dv_month=dv_geoidn4colorful(d_vec,lmaxf,rGoco);
dv_input=[dv_input; dv_month];
    end
end
clims = [10^(-5) 10^(-3)];

figure
imagesc(rGoco*dv_input,clims)
title('AIUB03P')
xlabel('Spherical Harmonic Degree')
ylabel('Year')
set(gca,'YTick',[1:12:n])
%colorbar('Ticks',Ticks,'TickLabels',TickLabels)
h = colorbar('southoutside');
h.Label.String ='Geoid Heights (m)';
%saveas(gcf,[filepathNeda,'plots/20',year,'/degvarcolor','ITSG',year,'.png'])






   


