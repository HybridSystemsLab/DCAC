function [tau, xi] = inv_refer(a, TSPAN)
%--------------------------------------------------------------------------
% Project: Hybrid Feedback Control book
% Description: DC/AC inverter
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: inv_refer.m
%--------------------------------------------------------------------------
% ideal trajectory integration
%--------------------------------------------------------------------------
% integration time domain
xi0 = [a, 0];
  
% ode solver
options = odeset('RelTol',1e-4,'MaxStep',1e-4);
[tau, xi] = ode15s(@it,TSPAN, xi0, options);
end

function xidot = it(t, xi)
global omega a b

xidot = zeros(2,1);

xidot(1) = -a/b*omega*xi(2);
xidot(2) = b/a*omega*xi(1);
end