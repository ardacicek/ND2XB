function [xGrid, yGrid, zReshaped, ncols, nrows,outputFileNames] = xBeachGridCreator(fileName, outputFileNames, writeToFile)

% Inputs: fileName, fileNames
% params.txt içinde: nx = ncols - 1 ; ny = nrows - 1
% fileName = "cropped-UTMtest-dx-5m.asc";
fid = fopen(fileName);
griddedData = textscan(fid, '%s', 'CollectOutput',true, 'Delimiter', ' ');
fclose(fid);

xCorner = str2double(char(griddedData{1,1}(6,1)));
yCorner = str2double(char(griddedData{1,1}(8,1)));
dx = str2double(char(griddedData{1,1}(10,1)));
dy = str2double(char(griddedData{1,1}(12,1)));
ncols = str2double(char(griddedData{1,1}(2,1)));
nrows = str2double(char(griddedData{1,1}(4,1)));

zNonReshaped = str2num(char(griddedData{1,1}(15:end,:)));
zReshaped = reshape(zNonReshaped,ncols,nrows)';


xStart = xCorner+dx/2;
yStart = yCorner+dy/2;

xGrid = zeros(nrows,ncols);
yGrid = zeros(nrows,ncols);

for i = 1:nrows
    for j = 1:ncols
        xGrid(i,j) = xStart + (j-1)*dx;
        yGrid(i,j) = yStart + (i-1)*dy;
    end
end
yGrid = flip(yGrid);

% mkdir XBeachFiles
% cd XBeach

if writeToFile == 1
    writematrix(zReshaped, "bed.txt", "Delimiter"," ");
    writematrix(xGrid, "x.txt", "Delimiter"," ");
    writematrix(yGrid, "y.txt", "Delimiter"," ");

    % fileNames = ["bed"; "x"; "y"];
    extensions = [".dep"; ".grd"; ".grd"];

    for i = 1:length(outputFileNames)
        
        nameExisting = outputFileNames(i,1)+'.txt';
        changedName = strrep(nameExisting,'.txt',extensions(i,1));
        copyfile(nameExisting,changedName);
        delete(nameExisting);
    end
end
end
