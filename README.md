# ND2XB - NAMI DANCE + XBeach Coupling Interface
An interface to create params.txt and relevant files for XBeach Non-hydrostatic module.

Developed by Yagiz Arda Cicek, 2021 (METU)

[NAMI DANCE]: Bora Yalciner, Ahmet Cevdet Yalciner, Andrey Zaytsev, Efim Pelinovsky,
Alessandro Annunziato

[XBeach]: Deltares

[Description]:

This software intends to couple NAMI DANCE and XBeach by taking the outputs from
NAMI DANCE simulations and transform them to a form such that non-hydrostatic module
of XBeach can use. 

[How to use?]:

(0) You need to have MATLAB Runtime 9.9 (or higher) installed on your computer.

(1) While performing NAMI DANCE simulations take gauge points whose coordinates covers
	the XBEach boundary. To check if this is the case, press the Plot button and load
	the XBeach domain (.asc format) and gauge file (.dat, in NAMI DANCE format). Check
	manually if the XBeach boundary points are within the limits of NAMI DANCE gauges
	for better interpolation. You should name all the gauges (for NAMI DANCE), that will
	be used in XBeach, with the same prefix (e.g. if the prefix is XB, then the gauge names 
	are XB1, XB2, ..., XB#).
	
(2) Load grid file (.asc), U file (.dat, NAMI DANCE output format), eta file (.dat, NAMI DANCE
	output format) and gauge file (.dat in NAMI DANCE format).
	
(3) Write prefix you used for NAMI DANCE gauges to be used in XBeach (see step (1)).

(4) Determine if you will use Vector boundary condition (different eta and U values in each 
	XBeach grid) or Scalar boundary condition (same eta and U values are used along the boundary).
	
(5) If Vector is selected, you can specify the interpolation and extrapolation method while transforming
	NAMI DANCE output files to XBeach Boundary file.
	
(6) If Scalar is selected, you can specify the gauge number (from NAMI DANCE) whose results will be used
	along the XBeach boundary.
	
(7) After specifying these, press Run! to create bed.dep, x.grd, y.grd, Boun_U.bcf and params.txt. In 
	XBeachFiles\params.txt; xfile, yfile, nx, ny, depfile, tstop keywords are updated according to the created files. The 
	files are saved to XBeachFiles\ folder in the direction where you run the ND2XB.exe file (not the shortcut).
	If there are existing files in this folder, backup of them will be created immediately and located in
	latestBackup\ folder in the direction where you run the ND2XB.exe file (not the shortcut).
	
(8) After creating these files with the interface now several other buttons are activated:
	Edit Output Gauges (XBeach) (XBeach Output Editor v1.0): 
		
		Global Outputs v1.0:
		You can specify start time of output (tstart) and interval time of global
		output here. You also might one to add global output parameters in addition to the ones specified by
		the interface in default (zs, zb, u, sedero). To do so press "Click to add global output variables"
		and add the parameters line by line. To see the available output parameters use the button "Click here
		to see the list of output variables". After completing press "Complete & Save" and wait for the process.
		
		Gauge Output Points v1.0 and Gauge Outputs v1.0:
		To obtain outputs in specific points (gauges) check the "Gauge output?" check-box. Now several elements 
		are activated in the interface. To specify the gauge point coordinates, press "Click to add gauge output
		points". Add the coordinates (X-Y pairs) line by line and press "Complete & Save". To specify which output
		parameters will be written press "Click to add gauge output variables" and add the parameters line by line.
		To see the available output parameters use the button "Click here to see the list of output variables". After 
		completing press "Complete & Save" and wait for the process.
		
		Click "Update params.txt" to over-write the XBeachFiles\params.txt file. Also, XBeachFiles\params.txt file is 
		updated each time you click a button in the interfaces mentioned in step (8).
		
		NOTE: Keywords tstart, tintg, tintp, nglobalvar, npointvar and npoints are determined automatically by the inputs
		you specify in step (8).
		
(9) To edit the last saved XBeachFiles\params.txt, click "Edit params.txt" to open it in text editor. After editting
	save the file. 
	NOTE: You need to edit other parameters (not above-mentioned ones and sedtrans) manually since they are based on 
	experience.

(10) Use Non-Erodible v1.0 to convert a sediment thickness file (in .asc format) to .dep file and add corresponding keywords (struct = 1
	and ne_layer = sediThickness.dep) to the XBeachFiles\params.txt. Check the checkbox to select .asc sediment thickness file 
	and save the file using "Click to update params.txt" button. If you do not check the checkbox and click the update button, 
	ne_layer and struct keywords are removed.
	
(10)You can use hydrodynamics only or hydrodynamics + sediment transport modes of the XBeach. In the first case just the
	the wave propagation is solved and the bottom is fixed. In the letter case, bottom is updated in each time step with
	respect to wave propagation (bed is movable).
	
(11)To run the XBeach simulation, simply click on the "Run XBeach Simulation!" button. Then you will see the XBeach execution
	window and follow the progress of the simulation. Outputs are saved to xb-simulationOutput\ folder.
	NOTE: Please check XBerror.txt, XBlog.txt and XBwarning.txt files regularly, especially if the XBeach simulation window 
	closes unexpectedly.
	
(12)You can always check Online XBeach Manual by clicking on "Click for XBeach Manual" and non-hydrostatic manual by clicking
	on "Click for Non-hydrostatic Manual" which opens the .pdf file.

[What's new?]:

1.0: Initial release
1.1: Edit Output Gauges support
1.2: Added Interpolation and Extrapolation Method selection for Vector boundary condition.
	 Added to switch between Hydrodynamics Only and Hydrodynamics + Sediment modes.
	 Added a button to run xbeach.exe with the created input files.
	 Added non-erodible file generator and enable option
1.3: Automatic update of tstop in params.txt using U.dat file.
	 
[Tips]:

- You do not need to use this software just to couple NAMIDANCE and XBeach only. As long as you have the grid file (.asc), and 
	gauge, u and eta files (.dat, all of them in NAMI DANCE output format) you can perform other simulations with the non-hydrostatic
	mode of XBeach.
- Quasi3D mode is activated by default for better results. Sometimes Q3D mode finishes faster than 2D one. You can deactivate it with nonhq3d = 0.
- Please wait while the interface performs actions. If you click another button while execution, the interface will face with errors.
- Please see the sample params.txt file, parameter definitions and suggested values of them below:


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%% XBeach parameter settings input file                                     %%%  
%%% This file is created for NAMIDANCE - XBeach Coupling                     %%%  
%%% Editted parameters: xfile, yfile, nx, ny, depfile                        %%%  
%%% Other parameters should be edited manually                               %%%  
%%% Date: 18-Oct-2021 15:05:36                                               %%%  
%%% Function: params.m                                                       %%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

wavemodel = nonh   % To activate non-hydrostatic module (do not change!)

%%% Bed composition parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

rhos = 2600   % Density of sediment (kg/m3)
por = 0.400000   % Sediment porosity
D50 = 0.00018   % Median grain size (m)

%%% Flow boundary condition parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

nonhq3d = 1; % Turn on or off the the reduced two-layer nonhydrostatic model, default = 0 (= 1 is better for ridiculous fluctuations)
epsi = 0   % Ratio of mean current to time varying current through offshore boundary
secorder = 1   % Use second order corrections to advection/non-linear terms based on maccormack scheme (suggested by nonh manual)
solver = sip   % Solver used to solve the linear system (for 1D simulations -> tridiag, for 2D simulations -> sip suggested by nonh manual)

%%% Flow numerics parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

eps = 0.000001   % Threshold water depth above which cells are considered wet (m)
umin = 0   % Threshold velocity for upwind velocity detection and for vmag2 in equilibrium sediment concentration (m/s)
hmin = 0.   % Threshold water depth above which stokes drift is included (m)

%%% Flow parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

bedfriction = manning   % Bed friction formulation ([chezy, cf, white-colebrook, manning, white-colebrook-grainsize])
bedfriccoef = 0.005   % Bed friction coefficient
nuh = 0.100000   % Horizontal background viscosity (m2/s)
nuhfac = 1   % Viscosity switch for roller induced turbulent horizontal viscosity
gwflow = 0   % Turn on groundwater flow
maxbrsteep = 0.4   % Maximum wave steepness criterium
nhbreaker = 0   % Non-hydrostatic breaker model

%%% Grid parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

gridform = xbeach   % Grid definition format
vardx = 1   % Switch for variable grid spacing
xfile = x.grd   % Name of the file containing x-coordinates of the calculation grid
yfile = y.grd   % Name of the file containing y-coordinates of the calculation grid
%%% dx = 1  
%%% dy = 1  
nx = 430   % Number of computational cell corners in x-direction (defined automatically by params.m)
ny = 43   % Number of computational cell corners in y-direction (defined automatically by params.m)
nz = 0   % Number of computational cells in z-direction
depfile = bed.dep   % Name of the input bathymetry file (defined automatically by params.m)
posdwn = 1   % Bathymetry is specified positive down (1) or positive up (-1)
%%% thetamin = -80  
%%% thetamax = 80  
%%% dtheta = 160  

%%% Model time %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

tstop = 720   % Stop time of simulation, in morphological time (s)
dtset = 0.0001   % Fixed timestep, overrides use of CFL (s)
%%% CFL = 0.01   % Maximum courant-friedrichs-lewy number

%%% Morphology parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

morfac = 1   % Morphological acceleration factor
morfacopt  = 1   % Switch to adjusting output times for morfac
morstart   = 30   % Start time morphology, in morphological time (s)
wetslp = 0.3   % Critical avalanching slope under water (dz/dx and dz/dy) (default: 0.3) (this value can generate water disturbances if too small)
dryslp = 1   % Critical avalanching slope above water (dz/dx and dz/dy) (default: 1.0)
hswitch = 0.1   % Water depth at which is switched from wetslp to dryslp
dzmax = 0.05   % Maximum bed level change due to avalanching
%%% struct = 1   % Switch for enabling hard structures
%%% ne_layer = sediThickness.dep   % Name of file containing thickness of the erodible layer (struct = 1)

%%% Physical constants %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

g = 9.810000   % Gravitational constant (m/s2)
rho = 1025   % Density of water (kg/m3)

%%% Roller parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

%%% roller = 1  
beta = 0.100000   % Breaker slope coefficient in roller model
%%% rfb = 1  

%%% Sediment transport parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

%%% waveform = vanthiel  
sedtrans = 0   % Turn on/off sediment transport
form = soulsby_vanrijn   % Equilibrium sediment concentration formulation [soulsby_vanrijn, vanthiel_vanrijn, vanrijn1993]
%%% facua  = 0.100000  
%%% turb = 2  
Tsmin  = 1   % Minimum adaptation time scale in advection diffusion equation sediment (default: 0.5)

%%% Tide boundary conditions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

%%%% tideloc = 1  
%%%% zs0file = tide.txt  

%%% Wave boundary condition parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

wbctype = ts_nonh   % New wave boundary condition type (do not change!)
front = nonh_1d   % Switch for seaward flow boundary (suggested by nonh manual)
arc = 1   % Switch for active reflection compensation at seaward boundary (suggested by nonh manual)

%%% Wave breaking parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

%%% break = 3  
%%% gamma = 0.78  
%%% alpha = 1  
%%% n = 10  
%%% delta = 0  

%%% Wave-spectrum boundary condition parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

%%% bcfile = filelist.txt  

%%% Output variables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

tintp = 0.001   % Interval time of point and runup gauge output (s)
tintg = 10   % Interval time of global output (s)
tstart = 0   % Start time of output, in morphological time
outputformat = netcdf   % Output file format

%%% Point Coordinates %%%  

%%% Point Variables %%%  
%%%      npointvar = 10   % Number of point output variables (should be compatible with the number of variables given below)
%%%      zs   % Water level
%%%      u   % Glm velocity in cell centre, x-component
%%%      zb   % Bed level
%%%      ccg   % Depth-averaged suspended concentration for each sediment fraction
%%%      cctot   % Sediment concentration integrated over bed load and suspended and for all sediment grains
%%%      sedero   % Cum. sedimentation/erosion
%%%      ue   % Eulerian velocity in cell centre, x-component
%%%      ur   % Reflected velocity at bnds in u-points
%%%      ust   % Stokes drift
%%%  uu   % Glm velocity in u-points, x-component

%%% Global Variables %%%  
nglobalvar = 4   % Number of global output variables (should be compatible with the number of variables given below)
zs   % Water level
u   % Glm velocity in cell centre, x-component
zb   % Bed level
sedero   %Cum. sedimentation/erosion
%%% End of File %%%  
