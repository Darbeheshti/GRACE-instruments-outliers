function gfc = readGFC4yaml(filename, verbosity)

%------------------------------------------------------------------------------
%
% READGFC(FILENAME, VERBOSITY) loads a global gravity field model in form of a
% spherical harmonic expansion (gcf-file).
%
% Input:
%
%   filename:  path to a .gfc file
%   verbosity: if set to true additional output to command window. Default is
%              false.
%
% Output:
%
%   gfc:        matrix containing l,m,C,S
%
% Usage:
%
%               readGFC('filename')
%               readGFC('filename', true)
%
%------------------------------------------------------------------------------
% Authors:
% Axel Schnitger, AEI, Leibniz University Hannover
%------------------------------------------------------------------------------
% Revision History
% 2018-08-20: AS, intitial version
%------------------------------------------------------------------------------

% Input arguments
if nargin < 2 || verbosity == false
    verbosity = false;
elseif verbosity
    tic
    fprintf('\nStart reading:\t%s\n', filename)
end

fileID = fopen(filename);
line = fgetl(fileID);
if contains(line, 'gfc')
    hasHeader = false;
else
    hasHeader = true;
end

formatSpec = '%s %f %f %f %f %f %f';

if hasHeader
    headerLines = 1;
    while ~contains(line, '# End of YAML header')
        line = fgetl(fileID);
        if isempty(line)
            headerLines = headerLines + 1;
            continue
        end

        keyword = textscan(line,'%s',1);
        if(strcmp(keyword{1}, 'max_degree'))
            tmp = textscan(line,'%s%d',1);
            maxDegree = tmp{2};
        end
        if(strcmp(keyword{1}, 'radius'))
            tmp = textscan(line,'%s%f',1);
            radius = tmp{2};
        end
        if(strcmp(keyword{1}, 'earth_gravity_constant'))
            tmp = textscan(line,'%s%f',1);
            GM = tmp{2};
        end
        headerLines = headerLines + 1;
    end
    fclose(fileID);

    fileID = fopen(filename);
    gfcData = textscan(fileID, formatSpec, 'HeaderLines', headerLines);
    fclose(fileID);

elseif ~hasHeader
    headerLines = 0;
    fileID = fopen(filename);
    gfcData = textscan(fileID, formatSpec);
    fclose(fileID);
    maxDegree=max(gfcData{2});
end

if verbosity
    if hasHeader
        fprintf('Headerlines:\t%u\n', headerLines)
        fprintf('Size data:\t%u\n', length(gfcData{3}))
        fprintf('max. Degree:\t%u\n', maxDegree)
        fprintf('Radius:\t\t%f\n', radius)
        fprintf('GM:\t\t%f\n', GM)
    elseif ~hasHeader
        fprintf('No header found.\n');
        fprintf('Size data:\t%u\n', length(gfcData{3}))
        fprintf('max. Degree:\t%u\n', maxDegree)
    end
    toc
end

gfc = [gfcData{2}, gfcData{3}, gfcData{4}, gfcData{5}];

end

