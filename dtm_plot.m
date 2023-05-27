close all
clear all
%from drag_new_2018.m
filepathNeda='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/';
%load('AP2000_2015.mat')
year='11';
load('F107_2000_2015.mat')
time_dtm=datetime(F107Pmat(:,1),F107Pmat(:,2),F107Pmat(:,3));
ltime=round(str2num(year)*365);
utime=round((str2num(year)+.99)*365);
figure
plot(time_dtm(ltime:utime),F107Pmat(ltime:utime,5),'.r')
ylabel('$(sfu)$','Interpreter','latex');
ylim([60 230])
%xlim([2000 2013])
grid on
legend('81-day mean F10.7');
saveas(gcf,[filepathNeda,'plots/20',year,'/sfu',year,'_mean_f107'],'png')


% figure
% plot(F107Pmat(732:end,4))
% figure
% plot(F107Pmat(:,5))
% % % % f107
% f107daily = F107Mat(files_line,4);
% f107Average = F107Mat(files_line,5);
% % % % 
% 
% % % % smooth AP
% if seconds < 43200
%     APmat_smooth = APmat(files_line - 1,:) + ( 1/2 + seconds/86400 )*( APmat(files_line,:) - APmat(files_line - 1,:) );
% else
%     APmat_smooth = APmat(files_line,:) + ( seconds/86400 - 1/2 )*( APmat(files_line + 1,:) - APmat(files_line,:) );
% end
% % % % 
% 
% % % % aph
% DayMagnIndex = sum(APmat_smooth(4:11))/8;
% col_inds = [file_col, file_col + 8, file_col + 16, file_col + 24, file_col + 32, file_col + 40];
% aph = [DayMagnIndex, APmat_smooth(col_inds)];
% % % % 
% 
% % % % density
% [~,rho] = atmosnrlmsise00(lla(3), lla(1), lla(2), year, doy, seconds, f107Average, f107daily, aph);
% emd = rho(6);