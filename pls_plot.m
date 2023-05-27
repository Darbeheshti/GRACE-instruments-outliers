clear all
close all
format longg;
year='11';
filepath=['/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/res20',year,'/'];
filepathNeda='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/';
d=[244];
%d = [244:273];%09 249 254 255 260 266
%d = [274:293,297,299:304];%10 eliminate from SES1110.SES 294 295 296 298
itr='dpar';
stepname='d0'; %just d0 here
head_no=2;
% for dn=1:length(d)
% ds = sprintf('%03d',d(dn));
%% load ACC file
%GRACE A
file = [filepath,'pls_',stepname,'C',itr,year,'_w'];
FID=fopen(file);
datacella = textscan(FID, '%s%f%f%s%s%f',  'CollectOutput', 1);
fclose(FID);
a_mtime =datacella{1,2}(:,1);
a_agl=datacella{1,2}(:,2);
a_Out=datacella{1,4}(:,1);
%acca_lin = datacella{1};
%GRACE B
% file = [filepath,stepname,'D',itr,year,ds,'0.PLS'];
% FID=fopen(file);
% datacellb = textscan(FID, '%f%f%f%s%s', 'HeaderLines', head_no, 'CollectOutput', 1);
% aglb=datacellb{1,1}(:,2);
% fclose(FID);
% end
lb=1;
ub=96;
figure
plot(a_mtime,a_Out,'.g','MarkerSize',10)
ylabel('$Radial[m/s^2]$','Interpreter','latex');
title (['PLS GRACE A piecewise ACC ']);
%
figure
plot(a_agl,a_Out,'.g','MarkerSize',10)
ylabel('$Radial[m/s^2]$','Interpreter','latex');
title (['PLS GRACE A piecewise ACC ', ]);


%figure
%mesh(a_Out)
figure
plot3(a_mtime,a_agl,a_Out,'.g')

figure
x = a_mtime(lb:ub) ; y = a_agl(lb:ub) ; z = a_Out(lb:ub) ;
dt = delaunayTriangulation(x,y) ;
tri = dt.ConnectivityList ;
xi = dt.Points(:,1) ; 
yi = dt.Points(:,2) ; 
F = scatteredInterpolant(x,y,z);
zi = F(xi,yi) ;
trisurf(tri,xi,yi,zi) 
view(2)
shading interp




