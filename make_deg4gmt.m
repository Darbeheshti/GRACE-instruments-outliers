%% Writing for AIUB gravity
%
% Written by Neda Darbeheshti, AIUB, 2020-04.
%%
clear all
close all

format longg;

filepath='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/';
year='18';
month='11';
apriori='gsGOCO05S';
 
lmaxf=90;
n_back = ((lmaxf+1)^2 + lmaxf+1)/2;

ggm = importGravityField([filepath,'GRAV',apriori,'_',year,month],13,4198);
ggm= ggm(1:n_back,:); % cut to desired length

dvs(1,:)=2:lmaxf;

dvs(2,:)= dv_geoidn_no_plot(ggm,lmaxf);

figure
semilogy(dvs(1,:),dvs(2,:),'.-','LineWidth',2,'MarkerSize',20)

filename = [filepath,'degvar',apriori,'_',year,month,'.txt'];

fileID = fopen(filename,'wt');
fprintf(fileID,'%2i %14.12e\r\n',dvs);
fclose(fileID);

%% Global computations for grided geoid

Latlim = [-89 89];
Lonlim = [-180 179.5];
step = 1;

[~, ~, geoid1, ~ ,~,~, Latitudeg, Longitudeg] = SH_Synthesis_Grid(ggm05s,lmaxf,Latlim,Lonlim,ae,step,ae,GM,400);
[~, ~, geoid2, ~, ~,~, ~, ~] =                    SH_Synthesis_Grid(ggm2,lmaxf,Latlim,Lonlim,ae,step,ae,GM,400);
dN = geoid1 - geoid2;
figure;
axesm robinson
meshm(dN,[1/step Latlim(end) Lonlim(1)])






