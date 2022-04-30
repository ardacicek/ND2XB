function paramsCreator(fileName, outputFileNames, writeToFile)

[~,~,~, ncols, nrows,~] = xBeachGridCreator(fileName, outputFileNames, writeToFile);
%% Change the input values if you desire (DO NOT DELETE A LINE OR CHANGE LINE ORDER!)

%% Backing-up existing files to the folder named \oldFiles
backupDate = string(datetime('now'));
backupDate = strrep(backupDate,":","-");

if isfile("XBeachFiles\"+"params.txt") || isfile("XBeachFiles\"+outputFileNames(1,1)+".dep") || isfile("XBeachFiles\"+outputFileNames(2,1)+".grd") || isfile("XBeachFiles\"+outputFileNames(3,1)+".grd") || isfile("XBeachFiles\"+"Boun_U.bcf")
    mkdir latestBackup
end

if isfile("XBeachFiles\"+"\params.txt")
    namePARAMS = "params.txt";
    newNamePARAMS = backupDate+namePARAMS;
    movefile("XBeachFiles\"+namePARAMS,"latestBackup\"+newNamePARAMS);
end

if isfile("XBeachFiles\"+outputFileNames(1,1)+".dep")
    nameDEP = outputFileNames(1,1)+".dep";
    newNameDEP = backupDate+outputFileNames(1,1)+".grd";
    movefile("XBeachFiles\"+nameDEP,"latestBackup\"+newNameDEP);
end

if isfile("XBeachFiles\"+outputFileNames(2,1)+".grd")
    nameXGRD = outputFileNames(2,1)+".grd";
    newNameXGRD = backupDate+outputFileNames(2,1)+".grd";
    movefile("XBeachFiles\"+nameXGRD,"latestBackup\"+newNameXGRD);
end

if isfile("XBeachFiles\"+outputFileNames(3,1)+".grd")
    nameYGRD = outputFileNames(3,1)+".grd";
    newNameYGRD = backupDate+outputFileNames(3,1)+".grd";
    movefile("XBeachFiles\"+nameYGRD,"latestBackup\"+newNameYGRD);
end

if isfile("XBeachFiles\"+"Boun_U.bcf")
    nameBOUN = "Boun_U.bcf";
    newNameBOUN = backupDate+nameBOUN;
    movefile("XBeachFiles\"+nameBOUN,"latestBackup\"+newNameBOUN);
end

paramstxt = ["%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%";
    "%%% XBeach parameter settings input file                                     %%%";
    "%%% This file is created for NAMIDANCE - XBeach Coupling                     %%%";
    "%%% Editted parameters: xfile, yfile, nx, ny, depfile                        %%%";
    "%%% Other parameters should be edited manually                               %%%";
    "%%% Date: 18-Oct-2021 15:05:36                                               %%%";
    "%%% Function: params.m                                                       %%%";
    "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%";
    "";
    "wavemodel = nonh"; % To activate non-hydrostatic module (do not change!)
    "";
    "%%% Bed composition parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%";
    "";
    "rhos = 2600"; % Density of sediment (kg/m3)
    "por = 0.400000"; % Sediment porosity
    "D50 = 0.00018"; % Median grain size (m)
    "";
    "%%% Flow boundary condition parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%";
    "";
    "epsi = 0"; % Ratio of mean current to time varying current through offshore boundary
    "secorder = 1"; % Use second order corrections to advection/non-linear terms based on maccormack scheme (suggested by nonh manual)
    "solver = sip"; % Solver used to solve the linear system (for 1D simulations -> tridiag, for 2D simulations -> sip suggested by nonh manual)
    "";
    "%%% Flow numerics parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%";
    "";
    "eps = 0.000001"; % Threshold water depth above which cells are considered wet (m)
    "umin = 0"; % Threshold velocity for upwind velocity detection and for vmag2 in equilibrium sediment concentration (m/s)
    "hmin = 0."; % Threshold water depth above which stokes drift is included (m)
    "";
    "%%% Flow parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%";
    "";
    "bedfriction = manning"; % Bed friction formulation ([chezy, cf, white-colebrook, manning, white-colebrook-grainsize])
    "bedfriccoef = 0.005"; % Bed friction coefficient
    "nuh = 0.100000"; % Horizontal background viscosity (m2/s)
    "nuhfac = 1"; % Viscosity switch for roller induced turbulent horizontal viscosity
    "gwflow = 0"; % Turn on groundwater flow
    "maxbrsteep = 0.4"; % Maximum wave steepness criterium
    "nhbreaker = 0"; % Non-hydrostatic breaker model
    "";
    "%%% Grid parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%";
    "";
    "gridform = xbeach"; % Grid definition format
    "vardx = 1"; % Switch for variable grid spacing
    "xfile = x.grd"; % Name of the file containing x-coordinates of the calculation grid
    "yfile = y.grd"; % Name of the file containing y-coordinates of the calculation grid
    "%%% dx = 1";
    "%%% dy = 1";
    "nx = 430"; % Number of computational cell corners in x-direction (defined automatically by params.m)
    "ny = 43"; % Number of computational cell corners in y-direction (defined automatically by params.m)
    "nz = 0"; % Number of computational cells in z-direction
    "depfile = bed.dep"; % Name of the input bathymetry file (defined automatically by params.m)
    "posdwn = 1"; % Bathymetry is specified positive down (1) or positive up (-1)
    "%%% thetamin = -80";
    "%%% thetamax = 80";
    "%%% dtheta = 160";
    "";
    "%%% Model time %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%";
    "";
    "tstop = 720"; % Stop time of simulation, in morphological time (s)
    "dtset = 0.0001"; % Fixed timestep, overrides use of CFL (s)
    "%%% CFL = 0.01"; % Maximum courant-friedrichs-lewy number
    "";
    "%%% Morphology parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%";
    "";
    "morfac = 1"; % Morphological acceleration factor
    "morfacopt  = 1"; % Switch to adjusting output times for morfac
    "morstart   = 30"; % Start time morphology, in morphological time (s)
    "wetslp = 0.3"; % Critical avalanching slope under water (dz/dx and dz/dy) (default: 0.3) (this value can generate water disturbances if too small)
    "dryslp = 1"; % Critical avalanching slope above water (dz/dx and dz/dy) (default: 1.0)
    "hswitch = 0.1"; % Water depth at which is switched from wetslp to dryslp
    "dzmax = 0.05"; % Maximum bed level change due to avalanching
    "%%% struct = 1"; % Switch for enabling hard structures
    "%%% ne_layer = sediThickness.dep"; % Name of file containing thickness of the erodible layer (struct = 1)
    "";
    "%%% Physical constants %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%";
    "";
    "g = 9.810000"; % Gravitational constant (m/s2)
    "rho = 1025"; % Density of water (kg/m3)
    "";
    "%%% Roller parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%";
    "";
    "%%% roller = 1";
    "beta = 0.100000"; % Breaker slope coefficient in roller model
    "%%% rfb = 1";
    "";
    "%%% Sediment transport parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%";
    "";
    "%%% waveform = vanthiel";
    "form = soulsby_vanrijn"; % Equilibrium sediment concentration formulation [soulsby_vanrijn, vanthiel_vanrijn, vanrijn1993]
    "%%% facua  = 0.100000";
    "%%% turb = 2";
    "Tsmin  = 1"; % Minimum adaptation time scale in advection diffusion equation sediment (default: 0.5)
    "";
    "%%% Tide boundary conditions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%";
    "";
    "%%%% tideloc = 1";
    "%%%% zs0file = tide.txt";
    "";
    "%%% Wave boundary condition parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%";
    "";
    "wbctype = ts_nonh"; % New wave boundary condition type (do not change!)
    "front = nonh_1d"; % Switch for seaward flow boundary (suggested by nonh manual)
    "arc = 1"; % Switch for active reflection compensation at seaward boundary (suggested by nonh manual)
    "";
    "%%% Wave breaking parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%";
    "";
    "%%% break = 3";
    "%%% gamma = 0.78";
    "%%% alpha = 1";
    "%%% n = 10";
    "%%% delta = 0";
    "";
    "%%% Wave-spectrum boundary condition parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%";
    "";
    "%%% bcfile = filelist.txt";
    "";
    "%%% Output variables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%";
    "";
    "tintp = 0.001"; % Interval time of point and runup gauge output (s)
    "tintg = 10"; % Interval time of global output (s)
    "tstart = 0"; % Start time of output, in morphological time
    "outputformat = netcdf"; % Output file format
    "";
    "%%% Point Coordinates %%%";
    "";
    "%%% Point Variables %%%";
    "npointvar = 10"; % Number of point output variables (should be compatible with the number of variables given below)
    "zs"; % Water level
    "u"; % Glm velocity in cell centre, x-component
    "zb"; % Bed level
    "ccg"; % Depth-averaged suspended concentration for each sediment fraction
    "cctot"; % Sediment concentration integrated over bed load and suspended and for all sediment grains
    "sedero"; % Cum. sedimentation/erosion
    "ue"; % Eulerian velocity in cell centre, x-component
    "ur"; % Reflected velocity at bnds in u-points
    "ust"; % Stokes drift
    "uu"; % Glm velocity in u-points, x-component
    "";
    "%%% Global Variables %%%";
    "nglobalvar = 4"; % Number of global output variables (should be compatible with the number of variables given below)
    "zs"; % Water level
    "u"; % Glm velocity in cell centre, x-component
    "zb"; % Bed level
    "sedero"; %Cum. sedimentation/erosion
    "%%% End of File %%%";
    ""];

date = string(datetime('now'));
paramstxt(6,1) = "%%% date: "+date+"                                               %%%";
paramstxt(44,1) = "xfile = " + outputFileNames(2,1) + ".grd";
paramstxt(45,1) = "yfile = " + outputFileNames(3,1) + ".grd";
paramstxt(48,1) = "nx = " + string(ncols - 1);
paramstxt(49,1) = "ny = " + string(nrows - 1);
paramstxt(51,1) = "depfile = " + outputFileNames(1,1) + ".dep";


writematrix(paramstxt, "params.txt",'QuoteStrings',0)

end
% paramstxt(45,1)