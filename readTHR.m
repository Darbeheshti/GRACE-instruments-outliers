function THR1B = readTHR(file)
% Read GRACE THR1B data
% cf. GRACE Level 1B Data Product User Handbook
%
% Input:    file = file/path string to ascii file containing GRACE THR1B data
%
% Output:   THR1B = matrix containing THR1B data
%
% Example: THR1B = readACC('THR1B_2002-12-02_A_02.asc')

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

% Reads the desired values from ACC1B data.
[gps_time, lin_acc_x, lin_acc_y, lin_acc_z, ang_acc_x, ang_acc_y, ang_acc_z] = textread(file,'%f %f %*s %*s  *%f *%f *%f *%f *%f *%f %*f %*f %*f %*f  *%f *%f *%f *%f *%f *%f %*f %*f %*f %*f ','headerlines',header);

% Produces the matrix containing the desired values.
THR1B = [gps_time, lin_acc_x, lin_acc_y, lin_acc_z, ang_acc_x, ang_acc_y, ang_acc_z];

end
