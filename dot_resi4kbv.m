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
d=56;
%d = [1:25,28:31];%01
%d = [1  3  4  5   6  8 11  18  19  20  21  22];%1
%d = [32:60];%02
%d = [32    35    38    39    40    44    45    47    48];%02
%d = [40,41 42,43,44,45,46,48,49];%02 to test if gap file works
%d = [61:91];%03
%d = [61    67    68    69    70    71    74    77    78    79    84    90];%03
%d = [128:152];%05
%d = [221:244];%08
outliermethod='percentiles';%'median','mean','quartiles','grubbs','gesd','percentiles'
tol = 2.5/(24*60*60);% in seconds 
tolmin=2*tol*24*60; %in minuts
minarc=1.5;%minimum arc in hour
thrsh=10^(-6);%for plot
perthrsh=.05;% for percentiles 
%writing in a gap file
gapfilename= [filepath,'K_OUTL_',outliermethod,year,month,'RL3'];
fidg = fopen(gapfilename,'w');
for dn=1:length(d)
    %for dn=1:1
ds = sprintf('%03d',d(dn));
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
%MJD(1)=MJD(1)+1;
if any(MJD ~= MJD(1))
    disp('MJD error for day')
end
switch outliermethod
    case 'percentiles'
        TFkbv = isoutlier(OC_range_rate,outliermethod,[perthrsh 100-perthrsh]);
    otherwise
        TFkbv = isoutlier(OC_range_rate,outliermethod);
end
%% gap for each day
totalgap=fracgv(TFkbv);
gapu=totalgap+tol;
gapl=totalgap-tol;
%
% % writing in a file 
 for i =1: length(gapl)  
 fprintf(fidg,'   %s       %12.7f       %12.7f    %3.1f \n','909',MJD(1)+gapl(i),MJD(1)+gapu(i),tolmin);
 %writing on the command window
 %fprintf('   %s       %12.7f       %12.7f    %3.1f \n','909',MJD(1)+sesl(i),MJD(1)+sesu(i),(MJD(1)+sesu(i)-MJD(1)-sesl(i))*24*60); 
 end
%% plots
%totalgaputol=uniquetol(totalgap,tol*5);
fhour=fracgv*24;
%utol=zeros(1,length(totalgaputol));
figure
plot(fhour,OC_range_rate,'c.',fhour(TFkbv),OC_range_rate(TFkbv),'kx','MarkerSize',5)
% hold on
% plot(totalgaputol*24,utol,'*r','LineWidth',2)
yline(-thrsh,'k','LineWidth',1);
yline(thrsh,'k','LineWidth',1);
grid on
ylabel('$\dot{r}[m/s]$','Interpreter','latex');
xlabel('Time [hour]');
title ({[' Year ',year,' Day ',ds,outliermethod]});
% figure
% plot(fhour,OC_range_rate,'c.',fhour(~TF),B,'kx','MarkerSize',1)
% legend('Input Data','Output Data')
%save the plots
saveas(gcf,[filepath,'plots/','dotKbvOutlier',itr,apriori,'_',year,ds,did,outliermethod],'png');
clear  MJD fracgv TFkbv OC_range_rate totalgaputol totalgap gapl gapu ses sesl sesu
end

 %% session for each day
% sesu=24*[0 ;gapu];
% sesl=24*[gapl; 1];
%ses=[sesu sesl];
%
% for i=1:length(ses)
%     if ses(i,2)-ses(i,1)<minarc
%         ses(i,:)=100;
%     end
% end
%
% ttu=hours(sesu);
% ttl=hours(sesl);
%tt.Format = 'hh:mm:ss';
% test1=datestr(ttu,'HH MM ss');
% test2=datestr(ttl,'HH MM ss');
%
% ses_counter(dn)=0;
% rdate=mjd2iso(MJD(1));
% % % writing in a file 
%  for i =1: length(sesu)
%      %if ses(i,1)~=100
% fprintf(fids,'  %s%03d%s %s%s %s %02d%s %s%s%s %s%s %s %02d%s %s%s%s\n','"',...
%             d(dn),'0"','"20',year,month,rdate(3),'"','"',datestr(ttu(i,:),'HH MM ss'),'"','"20',year,month,rdate(3),'"','"',datestr(ttl(i,:),'HH MM ss'),'"');
% %writing on the command window
% fprintf('  %s%03d%s %s%s %s %02d%s %s%s%s %s%s %s %02d%s %s%s%s\n','"',...
%             d(dn),'0"','"20',year,month,rdate(3),'"','"',datestr(ttu(i,:),'HH MM ss'),'"','"20',year,month,rdate(3),'"','"',datestr(ttl(i,:),'HH MM ss'),'"');
%         ses_counter(dn)=ses_counter(dn)+1;
%      %end 
%  end
% fclose(fidg);
% fprintf(fids,'%s\n','  ## widget = uniline; check_strlen.1 = 4; numlines = 24');
% fprintf(fids,'%s\n','  ## check_type.3 = time; check_type.5 = time');
% fprintf(fids,'%s\n','        ');
% fprintf(fids,'%s\n','MSG_LIST_OF_SESSIONS 1  "List of sessions"   ');
% fprintf(fids,'%s\n','        ');
% fprintf(fids,'%s\n','        ');
% fprintf(fids,'%s\n','# BEGIN_PANEL NO_CONDITION #####################################################');
% fprintf(fids,'%s\n','# SESSION TABLE                                                                #');
% fprintf(fids,'%s\n','#                                                                              #');
% fprintf(fids,'%s\n','#                START EPOCH         END EPOCH                                 #');
% fprintf(fids,'%s\n','#    > ID__ yyyy_mm_dd hh_mm_ss yyyy_mm_dd hh_mm_ss     <                      #');
% fprintf(fids,'%s\n','LIST_OF_SESSIONS');
% fprintf(fids,'%s\n','#                                                                              #');
% fprintf(fids,'%s\n','# END_PANEL ####################################################################');
% fclose(fids);
% disp(['LIST_OF_SESSIONS ',num2str(sum(ses_counter))])

%
%TFkbv = isoutlier(OC_range_rate,outliermethod,[perthrsh 100-perthrsh]);
% [B,TF] = rmoutliers(OC_range_rate,'percentiles',[perthrsh 100-perthrsh]);
%
% figure
% plot(MJD)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  fprintf(fids,'  %s%03d%s %s%s %s %02d%s %s%s%s %s%s %s %02d%s %s%s%s\n','"',...
%              d(dn),'0"','"20',year,month,dn,'"','"',tt(i,1),'"','"20',year,month,dn,'"','"',tt(i,2),'"');