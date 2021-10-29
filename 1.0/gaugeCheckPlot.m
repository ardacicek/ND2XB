function gaugeCheckPlot(fileName,outputFileNames,gaugeFile)

gauges = readtable(gaugeFile);
WGS84coordinatesString = string(table2array(gauges(:,1:2)));
Lon = str2double(WGS84coordinatesString(:,1));
Lat = str2double(WGS84coordinatesString(:,2));
[xGauge,yGauge,~] = deg2utm(Lat,Lon);
[xGrid, yGrid, ~,~,~,~] = xBeachGridCreator(fileName, outputFileNames,0);

scatter(xGauge,yGauge)
hold on
scatter(xGrid(:,1),yGrid(:,1))
xlabel("X (km)")
ylabel("Y (km)")
title("Check if XBeach Boundary is in the range of gauges!")
legend("ND Gauges","XBeach Boundary")

end