function xdot = f(x)
%--------------------------------------------------------------------------
% Project: Hybrid Feedback Control book
% Description: DC/AC inverter
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: f.m
%--------------------------------------------------------------------------
global R L Cap Vdc Rl
% states
  iC = x(1);
  vC = x(2);
  p = x(3);
  q = x(4);

% flow map
  iCdot = -(R/L + 1/Cap/Rl)*iC - (1/L + 1/L/Rl)*vC + Vdc/L*q;
  vCdot = iC/Cap;
  pdot = 0;
  qdot = 0;

xdot = [iCdot; vCdot; pdot; qdot];
end

%% pplane equations:

% R = 100; % resistance ||Ohms||
% L = 0.2; % inductance ||Henry's||
% Cap = 6.63e-5;  % capacitance ||Farads||
% Vdc = 220;

% without load
% xdot = -100/0.2*x - 1/0.2*y + 220/0.2;
% ydot = 1/0.0000663*x;

% with load
% xdot = -100/0.2*x - 1/0.2*y + 220/0.2;
% ydot = 1/0.0000663*x - 1/(0.0000663*1000)*y;

% R = 0.7; % resistance ||Ohms||
% L = 0.106; % inductance ||Henry's||
% Cap = 6.63e-5;  % capacitance ||Farads||
% Vdc = 220;

% without load
% xdot = -0.7/0.106*x - 1/0.106*y + 220/0.106;
% ydot = 1/0.0000663*x;

% with load
% xdot = -0.7/0.106*x - 1/0.106*y + 220/0.106;
% ydot = 1/0.0000663*x - 1/(0.00663)*y;