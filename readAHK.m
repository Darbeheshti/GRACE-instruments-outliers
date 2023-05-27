function AHK1B = readAHK(file)
% Read GRACE AHK1B data
% cf. Fig. 3. Klinger et al.(2016)
%Fig. 3. (a) ACC1B accelerometer measurements in along-track (red),
%cross-track (blue) and radial (green) direction; (b) AHK1B accelerometer
%housekeeping data in terms of temperatures for sensor unit (SU)
%electronics (red), internal core (blue), interface control unit (ICU) power
%supply board (green) and ICU A/D converter (black), for 2007-01.
% this line is very inportant 
% Input:    file = file/path string to ascii file containing GRACE KBR1B data 
% 
% Output:   KBR1B = matrix containing GNV1B data
%
% Example: KBR1B = readACC('KBR1B_2002-12-02_A_02.asc')
%
%%
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
%[gps_time,r,q,p,n,m,l,k,j,temSU,temICU,temIC,a,b,c, temAD, d, e,f, g] = textread(file,'%u %*u %*c %*c %*f %*f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %*f %*u','headerlines',header);
[gps_time, ~, ~, ~, ~, ~,~,~,~,~,~,~,~,~,~,~,temIC,~, ~,~, ~, ~, ~,~, ~, ~, ~] = textread(file,'%f %f %s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','headerlines',header);
fclose(fid);% this line is very inportant, if eliminated matlab will crash  with reading larne numebr of files 
% Produces the matrix containing the desired values.
%AHK1B = [gps_time,r,q,p,n,m,l,k,j, temSU,temICU,a,b,c,temIC,temAD,d,e,f,g];
AHK1B = [gps_time, temIC];
end