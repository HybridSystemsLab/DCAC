%--------------------------------------------------------------------------
% Project: Hybrid Feedback Control book
% Description: DC/AC inverter
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: run.m
% Set of simulation files created and edited by 
% Jun Chai and Ricardo Sanfelice
%--------------------------------------------------------------------------
close all
clear all

%% useful constants
global omega R L Cap Vdc co ci e1 c3 V qua a b Rl
fs = 60; % frequency ||Hz||
omega = fs*2*pi; % angular freqency ||rad/sec||
Rl = 100;  % load ||Ohms||
Vdc = 220; % dc voltage ||Volt||

Cap = 6.66e-5;  % capacitance ||Farads||
R = 1;  % resistance ||Ohms||
L = 0.1; % inductance ||Henry's||

Vout = 120;
%Cap = 1/(L*omega^2)*(Vdc/Vout + 1);

%% ideal trajectory generator

% amax = abs(Vdc*sqrt(...
%        R^2+(1/(Cap*omega)-L*omega)^2)/(R^2-(1/(Cap*omega)-L*omega)^2));
% bmax = amax/(omega*Cap);

b = Vout; % min(Vout,bmax);
a = b*Cap*omega;

%% controller constants/variables
% % controlable band
 k1 = Vdc/R;
 k2 = Vdc/(1- L*Cap*omega^2);

% Initialize control 
V = 0;
qua = 0;

% control band info based on ideal trajectory
%c = (Vout/(omega*Cap))^2*...
%(1 - (omega^2*Cap^2 - 1)*cos(-atan((L*Cap*omega^2 - 1)/(R*Cap*omega))));
%c = (Vout/(omega*Cap))^2;
c = 1;
e = 0.1; % control band width percentage
e3 = 0.01*a; % thin band width percentage
e1 = 0.01*a; % error value for q = 0  condition around iL = 0
co = c*(1+e); % outer boundray V(iL, Vc) value, So
ci = c*(1-e); % inner boundray V(iL, Vc) value, Si
c3 = c*(1+e+e3); % thinband outside of outer boundray V(iL, Vc) value, S3


%% initial conditions
 iL0 = a;
 vC0 = 0;
 p0 = 2;
 q0 = 1; 
 x0 = [iL0; vC0; p0; q0];

%% simulation horizon
TSPAN=[0 0.3];
%JSPAN = [0 3e10];
JSPAN = [0 190];

% rule for jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

%solver tolerances
% paramNameValStruct.RelTol = '1e-10';
% paramNameValStruct.MaxStep = '1e-7';
options = odeset('RelTol',1e-5,'MaxStep',1e-5);
%% 
% %% simulate
[t,j,x] = HyEQsolver(@f,@g,@C,@D,x0,TSPAN,JSPAN,rule,options);

%% plot solution
postprocessing;