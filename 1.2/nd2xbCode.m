function [gaugeMessage] = nd2xbCode(uFile,etaFile,gaugeFile,prefix,vectorOrScalar,gaugeNoForScalar,fileName,outputFileNames, interpolationMethod, extrapolationMethod)
% A MATLAB routine to couple NAMI DANCE and XBeach.
% 
% This function creates bed.dep, x.grd and y.grd using an .asc formatted
% bathymetry file.
%
% This function creates params.txt and updates xfile, yfile, nx, ny and
% depfile keywords in params.txt. All other parameters can be changed
% manually later.
%
% This function interpolates the NAMI DANCE output results to create XBeach
% Boun_U.bcf file for XBeach boundary grid points. See ReadMe.txt for
% more.
% 
% Inputs
% uFile: OUT-TIME-HISTORIES_U.dat (from NAMI DANCE, .dat extension) (str)
% etaFile: OUT-TIME-HISTORIES_ETA.dat (from NAMI DANCE, .dat extension) (str)
% gaugeFile: gauges.dat (NAMI DANCE format, long.-lat., .dat extension) (str)
% prefix: String that defines XBeach outputs. E.g. XB -> XB1, 2, ..., n (str)
% vectorOrScalar: Keyword for defining vector or scalar B.C. in Boun_U.bcf
%   (you can use "vector" or "scalar") (str)
% gaugeNoForScalar: Gauge number for scalar Boun_U.bcf (integer)
% fileName: Name of .asc file to create bed.dep, x.grd and y.grd (str)
% outputFileNames: Name of .dep and .grd files (str array)


% Specify xb domain direction,
u = readtable(uFile);
eta = readtable(etaFile);
gauges = readtable(gaugeFile);

mkdir XBeachFiles
paramsCreator(fileName, outputFileNames, 0);
%% Checking the first line of results (Bazen ND sonuçlarının ilk lineında zaman 12908390 gibi bir değerden başlıyor)
if table2array(u(1,1))>0
    u(1,:) = [];
end

if table2array(eta(1,1))>0
    eta(1,:) = [];
end


uND = [];
etaND = [];
gaugeNames = strings;
for i = 3:size(eta,2)
    name = (eta.Properties.VariableNames{i});
    if name(1:2) == prefix
        uND = [uND table2array(u(:,i))];
        etaND = [etaND table2array(eta(:,i))];
        gaugeNames(1,i-2) = extractBefore(string(name),"_");
    end
end



timeSeconds = str2double(string(table2array(u(:,2))));

if vectorOrScalar == "Vector"
    gaugeMessage = "Success!";
    %% Converting gauge coordinates from WGS1984 to UTM
    WGS84coordinatesString = string(table2array(gauges(:,1:2)));
    Lon = str2double(WGS84coordinatesString(:,1));
    Lat = str2double(WGS84coordinatesString(:,2));
    [xGauge,yGauge,~] = deg2utm(Lat,Lon);

    [xGrid, yGrid, ~,~,~,~] = xBeachGridCreator(fileName, outputFileNames,1);

    uXB = [];
    etaXB = [];


    for i = 1:size(uND,1)
        uInterpolant = scatteredInterpolant(xGauge, yGauge,uND(i,:)');
        uInterpolant.Method = interpolationMethod;
        uInterpolant.ExtrapolationMethod = extrapolationMethod;
        etaInterpolant = scatteredInterpolant(xGauge, yGauge,etaND(i,:)'); 
        etaInterpolant.Method = interpolationMethod;
        etaInterpolant.ExtrapolationMethod = extrapolationMethod;
        uXB(i,:) = uInterpolant(xGrid(:,1), yGrid(:,1))';
        etaXB(i,:) = etaInterpolant(xGrid(:,1), yGrid(:,1))';
    end
    
    BounU = repmat("",[size(uXB,1)+3,2*size(uXB,2)+1]);
    BounU(1,1) = "vector";
    BounU(2,1) = 3;
    BounU(3,1:3) = ["t", "U", "z"];
    BounU(4:end,1: end) = horzcat(timeSeconds, uXB, etaXB);
    writematrix(BounU, "Boun_U.txt","Delimiter"," ");
    nameExisting = "Boun_U.txt";
    changedName = strrep(nameExisting,'.txt',".bcf");
    copyfile(nameExisting,changedName);
    delete(nameExisting);
    
    
%     scatter(xGauge,yGauge)
%     hold on
%     scatter(xGrid(:,1),yGrid(:,1))
%     xlabel("X (km)")
%     ylabel("Y (km)")
%     title("Check if XBeach Boundary is in the range of gauges!")
%     legend("ND Gauges","XBeach Boundary")
elseif vectorOrScalar == "Scalar"
    [xGrid, yGrid, ~,~,~,~] = xBeachGridCreator(fileName, outputFileNames,1);
    gaugeWanted = "XB" + string(gaugeNoForScalar);
    checkGaugeExists = strcmp(gaugeNames,gaugeWanted);
    if sum(checkGaugeExists) == 0
        gaugeMessage = "No such gauge named " + gaugeWanted +"!";
    else
        gaugeMessage = "Gauge " + gaugeWanted + " exists!\nSuccess!";
        BounU = repmat("",[size(uND,1)+3,3]);
        BounU(1,1) = "scalar";
        BounU(2,1) = 3;
        BounU(3,1:3) = ["t", "U", "z"];
        BounU(4:end,1:end) = horzcat(timeSeconds, uND(:,gaugeNoForScalar), etaND(:,gaugeNoForScalar));
        writematrix(BounU, "Boun_U.txt","Delimiter"," ");
        nameExisting = "Boun_U.txt";
        changedName = strrep(nameExisting,'.txt',".bcf");
        copyfile(nameExisting,changedName);
        delete(nameExisting);
    end
end

extensions = [".dep"; ".grd"; ".grd"];

movefile("params.txt","XBeachFiles\"+"params.txt");
movefile("Boun_U.bcf","XBeachFiles\"+"Boun_U.bcf");
for i = 1:length(outputFileNames)
    nameExistingGrid = outputFileNames(i,1)+'.txt';
    changedNameGrid = strrep(nameExistingGrid,'.txt',extensions(i,1));
    movefile(changedNameGrid,"XBeachFiles\"+changedNameGrid);
end

winopen("XBeachFiles\");
if exist("latestBackup","dir")
    winopen("latestBackup\");
end
end

% [gaugeMessage] = nd2xbCode(uFile,etaFile,gaugeFile,prefix,vectorOrScalar,gaugeNoForScalar,fileName,outputFileNames, 'linear', 'none');
% figure(1)
% plot(timeSeconds,uXB(:,1));
% hold on
% for i = 2: size(uXB,2)
%     plot(timeSeconds,uXB(:,i));
% end
% title('Linear')
% 
% [gaugeMessage] = nd2xbCode(uFile,etaFile,gaugeFile,prefix,vectorOrScalar,gaugeNoForScalar,fileName,outputFileNames, 'nearest', 'none');
% figure(2)
% plot(timeSeconds,uXB(:,1));
% hold on
% for i = 2: size(uXB,2)
%     plot(timeSeconds,uXB(:,i));
% end
% title('Nearest')
% 
% [gaugeMessage] = nd2xbCode(uFile,etaFile,gaugeFile,prefix,vectorOrScalar,gaugeNoForScalar,fileName,outputFileNames, 'natural', 'none');
% figure(3)
% plot(timeSeconds,uXB(:,1));
% hold on
% for i = 2: size(uXB,2)
%     plot(timeSeconds,uXB(:,i));
% end
% title('Natural')
% 
% figure(4)
% plot(timeSeconds,uND(:,1));
% hold on
% for i = 2: size(uND,2)
%     plot(timeSeconds,uND(:,i));
% end
% title('ND')