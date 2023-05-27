%% Plotting for AIUB range rate residuals
%
% Written by Neda Darbeheshti, AIUB, 2020-03.
%%
clear all
close all

format longg;

filepath='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/';
year='11';
dn=237;%39,59,77,284,294,295,296,365 %d=[229,231,237,243];%08
ds = sprintf('%03d',dn);

kbrfilename= [filepath,'GRCSth',year,ds,'.KBR'];

kbrday=readKBR(kbrfilename);
thour=(kbrday(:,1)-kbrday(1,1))/(3600);
kbr_rate=kbrday(:,3);

figure
plot(thour,kbr_rate,'*b','LineWidth',1,'MarkerSize',1)
title([' Year ', year,' Day ',ds])
xlabel('Time [hour]');
ylabel('$\dot\rho[m/s]$','Interpreter','latex');
grid on

%% Mahalanobis distance
for i=1:length(kbr_rate)
d1_mahal(i)=mahal(kbr_rate(i),kbr_rate);
end
figure
plot(thour,d1_mahal)
title('Mahalanobis distance')

P_val= chi2cdf(d1_mahal,2);
outlierInd_P_val=zeros(length(P_val),1);
for i=1:length(P_val)
if P_val(i)>0.05
    outlierInd_P_val(i)=1;
end
end
outlierInd_P_val=logical(outlierInd_P_val);
figure
plot(thour,kbr_rate,'b.',thour(outlierInd_P_val),kbr_rate(outlierInd_P_val),'rx')
title(' Mahalanobis p-values')















