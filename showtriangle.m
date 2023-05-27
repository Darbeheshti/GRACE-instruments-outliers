function showtriangle(xegm, n_max,cax, titleString)
%
% Visualization of the normal equation matrix. 
%
% --Input--
%   x           Parameter vector containing the estimated spherical 
%               harmonic coefficients (n x 4)
%   n_max       Maximum degree (1x1)
%
% --Output--
%   Triangle plot of the spherical harmonic coefficicients
%
% Author: Neda Darbeheshti
% Date:  2020-07
%
% Separate potential coefficients in cnm and snm
kk=0;
for i=1:n_max
    for j=1:n_max
    if j<=i
        kk=kk+1;
cnm(i,j)=xegm(kk,3);
snm(i,j)=xegm(kk,4);
    end
    end
end
% Sort potential coefficients into triangle matrix
triangle = zeros(length(cnm), 2*length(cnm)-1);
for i = 1:length(cnm)
    triangle(:,n_max+i) =snm(:,i);  
    triangle(:,n_max+2-i) =cnm(:,i);  
end
triangle=log10(abs(triangle));
fs = 12; % Fontsize
figure('Position',[1,1,500,300]);
set(gcf,'PaperPositionMode','auto')
set(gca,'YDir','reverse'); 
set(gca,'FontSize',fs);
hold on
imagesc(-n_max:1:n_max, 0:n_max,triangle),caxis(cax)
colormap(jet(256))
axis([-n_max n_max 0 n_max])
cb = colorbar;
set(get(cb,'label'),'string','log10');
%xlabel('sin <-- order m --> cos')
xlabel('Snm         order m          Cnm')
ylabel('degree n')
title(titleString);
set(gcf,'name',titleString)
end