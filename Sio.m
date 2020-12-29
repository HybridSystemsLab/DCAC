function [si, so] = Sio(a, b, ci, co)
%--------------------------------------------------------------------------
% Project: Hybrid Feedback Control book
% Description: DC/AC inverter
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: Sio.m
%--------------------------------------------------------------------------
elipse = @(c, bx) sqrt((c - (bx./a).^2) * b^2);

sampled = 80;
  % inner boundary
  bxi = linspace(- a*sqrt(ci),a*sqrt(ci),sampled)';
  byi1 = elipse(ci, bxi);
  byi2 = -elipse(ci, bxi);
  si = [bxi, byi1, byi2];

  % outer boundary
  bxo = linspace(- a*sqrt(co),a*sqrt(co),sampled)';
  byo1 = elipse(co, bxo);
  byo2 = -elipse(co, bxo);
  so = [bxo, byo1, byo2];
end