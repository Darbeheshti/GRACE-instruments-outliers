clear all
close all

   % zero_tide GOCO*
   % MJD=[54466 53915];
   % MJD 53000 2003
   % MJD 60000 2023
    TMJD=53000:1000:60000;
   % from TIDPT2.f
   % LOVE NUMBERS FOR REMOVING PERMANENT TIDE
   K20r=0.30D0
   %  ! IZTID = 0: TIDE FREE; IZTID = 1: zero tide ZERO TIDE
   %  IF (IZTID.EQ.1) CPOT(4)=CPOT(4)+1.3914129D-8*K20r
   
%GG_name={'GOCO05Strend', 'GOCO05StrendAIUB53915','GOCO05S_trend_tidefree'}; 
GEOCOE=[  -.484169455273E-03 ; -.484165228242E-03; -.484165281034E-03];                                                       
GRDOTA=[  -.619410781658E-13 ; -.149592637994E-13; -.619410781658E-13];
% GEOCOE_zero=GEOCOE(1)+1.3914129D-8*K20r;
% figure(1)
% for i=1:length(GEOCOE)
% y=GEOCOE(i)+GRDOTA(i)*TMJD;
% plot(TMJD,y,'LineWidth',5)
% text(54466,GEOCOE(i),GG_name(i),'FontSize',20)
% hold on
% end

GG_name={'GOCO05Strend', 'GOCO05StrendAIUB53915','GOCO05S_trend_tidefree','AIUB7YA', 'AIUB7YC', 'AIUB7YT', 'AIUBAPRtrend', 'AIUBAPRtrendC'};      

GEOCOE=[ GEOCOE; -.484165220000E-03 
        -.484165220000E-03 
        -.484164394886E-03 
        -.484164394886E-03 
        -.484165220000E-03]; 

GRDOTA=[GRDOTA; -.149592637994E-13 
         -.149592637994E-13 
         0.351150232187E-12 
         0.351150232187E-12 
         -.149592637994E-13];
     
%inum=[1 2 3 6 7];
inum=[1 2 3];
%figure(2)
for i=1:length(inum)
y=GEOCOE(inum(i))+GRDOTA(inum(i))*TMJD;
plot(TMJD,y,'LineWidth',5)
text(54466,GEOCOE(inum(i)),GG_name(inum(i)),'FontSize',20)
%axis([53000 60000 min(y) max(y)])
hold on
end

