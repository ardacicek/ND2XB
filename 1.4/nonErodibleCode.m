function nonErodibleCode(nonErodibleFileName)
%NONERODIBLE Summary of this function goes here
%   Detailed explanation goes here
fid = fopen(nonErodibleFileName);
griddedData = textscan(fid, '%s', 'CollectOutput',true, 'Delimiter', ' ');
fclose(fid);

ncols = str2double(char(griddedData{1,1}(2,1)));
nrows = str2double(char(griddedData{1,1}(4,1)));

zNonReshaped = str2num(char(griddedData{1,1}(15:end,:)));
zReshaped = reshape(zNonReshaped,ncols,nrows)';
writematrix(zReshaped, "XBeachFiles\sediThickness.txt", "Delimiter"," ");
extension = ".dep";
outputFileNames = "XBeachFiles\sediThickness";
for i = 1:length(outputFileNames)

    nameExisting = outputFileNames(i,1)+'.txt';
    changedName = strrep(nameExisting,'.txt',extension(i,1));
    copyfile(nameExisting,changedName);
    delete(nameExisting);
end
end

