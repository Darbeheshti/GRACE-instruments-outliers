%%Outlier detection for each day
%
% Written by Neda Darbeheshti, AIUB, 2020-12.
%%
clear all
close all

format longg;

filepath='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/res2016/';
year='16';
month='08';
apriori='0itr';
itr='D0';%'D3';%'d3';
did='0';%0,a,b
%from resiRMS_plot
%d=[ 183 184 185 209 210 211 ];
d=[32:35];
%d = [1:25,28:31];%01
%d = [1  3  4  5   6  8 11  18  19  20  21  22];%01
%d = [32    35    38    39    40    44    45    47    48];%02
%d = [61    67    68    69    70    71    74    77    78    79    84    90];%03
%d = [127:152];%05
%d = [127   128   129   130   131   132   135   139   141   147   149];%05
%d = [153   154   155   156   157   158   159   161   162   163   169   178   181];%06
%d = [183   186   189   204   205   207   208   209   210   211];%07
%d = [216   228   230   231   233   234   236   237   239   242   243   244];%08
%d = [221:244];%08
outliermethod='median';%'median','mean','quartiles','grubbs','gesd'
tol = 0.05;% % in hour for uniquetol
minarc=3;%minimum arc in hour
thrsh=3*10^(-2);%for plot
sesfilename= [filepath,'SES_',outliermethod,year,month];
%writing in a sesssion file
fidr = fopen(sesfilename,'w');
fprintf(fidr,'\n%s\n','LIST_OF_SESSIONS ');
for dn=1:length(d)
    %for dn=1:1
ds = sprintf('%03d',d(dn));
%% load GRACE A file  
file = [filepath,itr,'C',apriori,year,ds,did,'.RES'];
fileID = fopen(file);
input_a = textscan(fileID,'%f %f %f %f %f %f %f %f %s %f %f %f');
fclose(fileID);
fracga=cell2mat(input_a(:,1));
fracga= fracga/60;%minute to hour
xr_a=cell2mat(input_a(:,6));
ya_a=cell2mat(input_a(:,7));
zc_a=cell2mat(input_a(:,8));
%TFxr_a = isoutlier(xr_a,'movmedian',3,'SamplePoints',fracga);
TFxr_a = isoutlier(xr_a,outliermethod);
TFya_a = isoutlier(ya_a,outliermethod);
TFzc_a = isoutlier(zc_a,outliermethod);
%% load GRACE B file  
file = [filepath,itr,'D',apriori,year,ds,did,'.RES'];
fileID = fopen(file);
input_b = textscan(fileID,'%f %f %f %f %f %f %f %f %s %f %f %f');
fclose(fileID);
fracgb=cell2mat(input_b(:,1));
fracgb= fracgb/60;%minute to hour
xr_b=cell2mat(input_b(:,6));
ya_b=cell2mat(input_b(:,7));
zc_b=cell2mat(input_b(:,8));
TFxr_b = isoutlier(xr_b,outliermethod);
TFya_b = isoutlier(ya_b,outliermethod);
TFzc_b = isoutlier(zc_b,outliermethod);
%% load Range residuals file   
file = [filepath,itr,'KbV',apriori,year,ds,did,'.RES'];
% Counts header lines and removes them.
header=0;
fid = fopen(file);
while 1
    line = fgetl(fid);
    header = header+1;
    if (~isempty(strfind(line,'END OF HEADER')))
        break
    end
end
% Reads the desired values.
[~, fracgr, ~, ~, ~, ~ ,OC_range, ~, ~, ~, ~ ] = textread(file,'%f %f %f %f %f %f %f %f %f %f %f','headerlines',header);
fracgr= fracgr*24;%day fraction to hour
TFkbr = isoutlier(OC_range,outliermethod);
%TFkbr = isoutlier(OC_range,'movmedian',0.0083,'SamplePoints',fracgr);%30/3600=0.0083 is 30 sec as kin orbit
%% load Range rate residuals file
file = [filepath,itr,'Kb',apriori,year,ds,did,'.RES'];
% Counts header lines and removes them.
header=0;
fid = fopen(file);
while 1
    line = fgetl(fid);
    header = header+1;
    if (~isempty(strfind(line,'END OF HEADER')))
        break
    end
end
% Reads the desired values.
[MJD, fracgv, ~, ~, ~, ~ ,OC_range_rate, ~, ~, ~, ~ ] = textread(file,'%f %f %f %f %f %f %f %f %f %f %f','headerlines',header);
fracgv= fracgv*24;%day fraction to hour
TFkbv = isoutlier(OC_range_rate,outliermethod);
%% gap for each day
%totalgap=[fracga(TFxr_a) ;fracga(TFya_a) ;fracga(TFzc_a) ; fracgb(TFxr_b); fracgb(TFya_b); fracgb(TFzc_b);fracgr(TFkbr);fracgv(TFkbv)];
totalgap=[fracga(TFxr_a) ;fracga(TFya_a) ;fracga(TFzc_a) ; fracgb(TFxr_b); fracgb(TFya_b); fracgb(TFzc_b)];
totalgap=sort(totalgap);
totalgaputol=uniquetol(totalgap,.5);
sesu=totalgaputol+tol;
sesl=totalgaputol-tol;
sesu=[0 ;sesu];
sesl=[sesl; 23.9999];
ttu=hours(sesu);
ttl=hours(sesl);
% ses=[sesu sesl];
% %
% for i=1:length(ses)
%     if ses(i,2)-ses(i,1)<minarc
%         ses(i,:)=100;
%     end
% end
% %
% tt=hours(ses);
%tt.Format = 'hh:mm:ss';
% writing in a file 
%  for i =1: length(ses)
%      if ses(i,1)~=100
% fprintf(fidr,'  %s%03d%s %s%s %s %02d%s %s%s%s %s%s %s %02d%s %s%s%s\n','"',...
%             d(dn),'0"','"20',year,month,dn,'"','"',tt(i,1),'"','"20',year,month,dn,'"','"',tt(i,2),'"');
%      end 
%  end
%fclose(fidr);
ses_counter(dn)=0;
rdate=mjd2iso(MJD(1));
% % writing in a file 
 for i =1: length(sesu)
     %if ses(i,1)~=100
fprintf(fidr,'  %s%03d%s %s%s %s %02d%s %s%s%s %s%s %s %02d%s %s%s%s\n','"',...
            d(dn),'0"','"20',year,month,rdate(3),'"','"',datestr(ttu(i,:),'HH MM ss'),'"','"20',year,month,rdate(3),'"','"',datestr(ttl(i,:),'HH MM ss'),'"');
%writing on the command window
fprintf('  %s%03d%s %s%s %s %02d%s %s%s%s %s%s %s %02d%s %s%s%s\n','"',...
            d(dn),'0"','"20',year,month,rdate(3),'"','"',datestr(ttu(i,:),'HH MM ss'),'"','"20',year,month,rdate(3),'"','"',datestr(ttl(i,:),'HH MM ss'),'"');
        ses_counter(dn)=ses_counter(dn)+1;
     %end 
 end
%% plots
figure
subplot(4,2,1)
plot(fracga,xr_a,'r.',fracga(TFxr_a),xr_a(TFxr_a),'kx','MarkerSize',10)
yline(-thrsh,'k','LineWidth',1);
yline(thrsh,'k','LineWidth',1);
grid on
ylabel('$Radial[m]$','Interpreter','latex');
title ({[' Year ',year,' Day ',ds],' A '});
%
subplot(4,2,3)
plot(fracga,ya_a,'g.',fracga(TFya_a),ya_a(TFya_a),'kx','MarkerSize',10)
yline(-thrsh,'k','LineWidth',1);
yline(thrsh,'k','LineWidth',1);
grid on
ylabel('$Along-track[m]$','Interpreter','latex');
%
subplot(4,2,5)
plot(fracga,zc_a,'b.',fracga(TFzc_a),zc_a(TFzc_a),'kx','MarkerSize',10)
yline(-thrsh,'k','LineWidth',1);
yline(thrsh,'k','LineWidth',1);
grid on
ylabel('$Cross-track[m]$','Interpreter','latex');
%
subplot(4,2,2)
plot(fracgb,xr_b,'r.',fracgb(TFxr_b),xr_b(TFxr_b),'kx','MarkerSize',10)
yline(-thrsh,'k','LineWidth',1);
yline(thrsh,'k','LineWidth',1);
grid on
title ({[' Year ',year,' Day ',ds],' B '});
%
subplot(4,2,4)
plot(fracgb,ya_b,'g.',fracgb(TFya_b),ya_b(TFya_b),'kx','MarkerSize',10)
yline(-thrsh,'k','LineWidth',1);
yline(thrsh,'k','LineWidth',1);
grid on
%
subplot(4,2,6)
plot(fracgb,zc_b,'b.',fracgb(TFzc_b),zc_b(TFzc_b),'kx','MarkerSize',10)
yline(-thrsh,'k','LineWidth',1);
yline(thrsh,'k','LineWidth',1);
grid on
%
subplot(4,2,7)
plot(fracgr,OC_range,'m.',fracgr(TFkbr),OC_range(TFkbr),'kx','MarkerSize',10)
yline(-10^(-4),'k','LineWidth',1);
yline(10^(-4),'k','LineWidth',1);
grid on
xlabel('Time [hour]');
ylabel('$r[m]$','Interpreter','latex');
subplot(4,2,8)
plot(fracgv,OC_range_rate,'c.',fracgv(TFkbv),OC_range_rate(TFkbv),'kx','MarkerSize',10)
yline(-10^(-6),'k','LineWidth',1);
yline(10^(-6),'k','LineWidth',1);
grid on
ylabel('$\dot{r}[m/s]$','Interpreter','latex');
xlabel('Time [hour]');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% z1=zeros(1,length(fracga));
% z2=zeros(1,length(totalgap));
% z3=zeros(1,length(totalgaputol));
% figure
% plot(fracga,z1,'y.','MarkerSize',10)
% hold on 
% plot(totalgap,z2,'b.','MarkerSize',10)
% hold on 
% plot(totalgaputol,z3,'r.','MarkerSize',15)
%save the plots
saveas(gcf,[filepath,'plots/','orbitsOutlier',itr,apriori,'_',year,ds,did],'png');
clear xr_a xr_b ya_a ya_b zc_a zc_b TFxr_a Txr_b TFya_a TFya_b TFzc_a TFzc_b input_a input_b fracga fracgb totalgap ...
    fracgr TFkbr OC_range fracgv TFkbv OC_range_rate totalgaputol totalgap sesl sesu MJD
end

fprintf(fidr,'%s\n','  ## widget = uniline; check_strlen.1 = 4; numlines = 24');
fprintf(fidr,'%s\n','  ## check_type.3 = time; check_type.5 = time');
fprintf(fidr,'%s\n','        ');
fprintf(fidr,'%s\n','MSG_LIST_OF_SESSIONS 1  "List of sessions"   ');
fprintf(fidr,'%s\n','        ');
fprintf(fidr,'%s\n','        ');
fprintf(fidr,'%s\n','# BEGIN_PANEL NO_CONDITION #####################################################');
fprintf(fidr,'%s\n','# SESSION TABLE                                                                #');
fprintf(fidr,'%s\n','#                                                                              #');
fprintf(fidr,'%s\n','#                START EPOCH         END EPOCH                                 #');
fprintf(fidr,'%s\n','#    > ID__ yyyy_mm_dd hh_mm_ss yyyy_mm_dd hh_mm_ss     <                      #');
fprintf(fidr,'%s\n','LIST_OF_SESSIONS');
fprintf(fidr,'%s\n','#                                                                              #');
fprintf(fidr,'%s\n','# END_PANEL ####################################################################');
fclose(fidr);

disp(['LIST_OF_SESSIONS ',num2str(sum(ses_counter))])

