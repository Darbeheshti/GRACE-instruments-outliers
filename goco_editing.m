clear all
close all

format longg;

filepath='/Users/neda/Documents/ubuntu_backup26092019/code/mfiles_variational/gracetools-master/plotting/aiub_plotting/aiub_out/';
file = [filepath,'GOCO06sbern.txt'];
%(A6,2I5,4(1X,1E18.12),1X,A4,F7.1)

delimiterIn = ' ';
A = importdata(file,delimiterIn);

fid = fopen('GOCO06sbern.','wt');
fprintf(fid, '  BERN-1\n');
fprintf(fid, '\n');
fprintf(fid, 'product_type                  gravity_field\n');
fprintf(fid, 'modelname                     BERN-1\n');
fprintf(fid, 'earth_gravity_constant        0.3986004415E+15\n');
fprintf(fid, 'radius                        0.6378137000E+07\n');
fprintf(fid, 'max_degree                    300\n');
fprintf(fid, 'norm\n');
fprintf(fid, 'tide_free\n');
fprintf(fid, 'reference_date\n');
fprintf(fid, '\n');
fprintf(fid, 'key       n    m Cnm                Snm                SigCnm             SigSnm\n');
for i = 1:106345
            fprintf(fid,A.textdata{i});
            fprintf(fid,'%5i%5i %19.12E %19.12E %18.12E %18.12E',A.data(i,:));
            fprintf(fid,' yyyy 55197.0\n ');
end
         fclose(fid);