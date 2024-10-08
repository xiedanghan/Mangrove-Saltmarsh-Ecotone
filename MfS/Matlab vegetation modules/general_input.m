%% Overview
% Initial module 'general_input' calls veg module and defines run paths.
% Here different keywords need to be set to start a simulation with/without vegetation, with morphology, or from restart files.
% If restart, the trim-files are necessary (trim-*model name*.dat and trim-*model name*.def) 
%% Initialisation
clear
close all
clc

% Define run directory
directory_head          = 'd:\model\'; % Link to the folders with modules and initial files
name_model_original1    = '360x1'; % original name of model grid coarse
name_model              = 'MfS'; % folder of scenario run
bat_file                = 'Startrun.bat'; % Windows; or: 'run_flow2d3d_eejit.sh'; % Linux exe file
directory = strcat(directory_head, name_model,'\'); % main directory
cd(strcat(directory, 'initial files\')); % directory initial files
% add paths with functions and scripts of modules
addpath(strcat(directory,'Matlab vegetation modules'));
addpath(strcat(directory,'Matlab functions'));
% turn this on in case of older matlab version (f.e. in GIS-lab)
addpath('d:\d3d\delft3d\win64\delft3d_matlab')  % code for pcs with older version of matlab

%% User defined parameters for Vegetation model
% Veg
VegPres             = 1;   % 1 = vegetation present, 0 = no vegetation present
Root                = 1;   % 1 = Mangrove root included, 0 = mangrove root excluded
Static              = 0;   % 1 = static vegetation (no growth and mortality) but dynamic colonisation at certain timestep(a la Nicholas & Crosato)
Veg_WStag           = 0;   % 1 = assign vegetation when water stagnation occurs in upperland
f                   = 0.3; % Constant of roots number increase% Barend: 0.3(40cm stem); Danghan: 0.1(~1m stem) and 0.5(18cm stem)
% Bnd
Wave                = 0;   % 1 = Roller wave, 0 = no wave
TauThres            = 0.2; % Bed shear stress Threshold for mangrove colonization
Restart             = 0;   % 1 = hot start from work file, 0 = run from pristine conditions
Storage             = 1;   % 1 = save the user-defined output file, 0 = save the delft3D output file 
SedThres            = 0.01;% sedimentation threshold for ColonisationStrategy 2B (in m) - defined in veg.txt-file
mor                 = 1;   % 1= include morphology, 0 = exclude morphology
morf                = 30;  % give manual morfac in case without morphological development
fl_dr               = 0.1; % Boundary for water flooding/drying (m)
t_eco_year          = 12;  % number of ecological time-steps (ets)  per year
t_days_year         = 360; % number days per year to guarantee no integers in time-scales
silt                = 0;   % 1 = include silt, 0 = not include silt (not updated yet)
mort_grad           = 0;   % switch for mortality interval;2 to use flooding per tide[fraction], 1 to use dts-steps for mortality; 0 uses ets
num0                = 750; % initial individuals of plants in one cell
num_all             = 1e5; % The max number of columns in one cell incl. plants and roots
S_cell              = 2500;% Cell size area
Mort_plant          = 10;  % Number of plants need to be removed at one time
Grow_plant          = 10;  % Number of plants need to be grown at one time
G2                  = 10;  % Growth constant 2, G2 (-)

% Saltmarsh
marsh               = 1;                % 1 = With marsh, 0 = without marsh
dx                  = 50;				% grid resolution in x direction (m)
dy                  = 50;				% grid resolution in y direction (m)
Seed                = 0.05;				% chance of establishment of seedlings in a grid cell
K1                  = 370;				% max. carrying capacity of plant density (stems/m2) 
K2                  = 2;                % max. plant height (m)
P0                  = 0.1.*K1;			% initial plant density of seedlings (stems/m2)
H0                  = 0.1.*K2;          % initial plant height of seedlings (m)
r1                  = 1;				% intrinsic growth rate of plant density (per yr)
r2                  = K2;               % intrinsic growth rate of plant height (per yr)
tau_mincrp          = 0.2;        		% minmum threshold of critical bed shear stress for plant erosion (N/m2)
tau_maxcrp          = 0.26;             % maxmum threshold of critical bed shear stress for plant erosion (N/m2)
a_marsh             = -9.47;            % Stress inundation constant, a
b_marsh             = 6.15;             % Stress inundation constant, b
c_marsh             = 0;                % Stress inundation constant, c

% Biotic interactions
Competition         = 1;                % 1 = with interspecific competition between mangroves and saltmarshes, 0 = without interspecific competition
Predation           = 0;                % 1 = with herbivory predation, 0 = without herbivory predation
%% run vegetation model
Vegetation_model

