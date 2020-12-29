function inside = D(x) 
%--------------------------------------------------------------------------
% Project: Hybrid Feedback Control book
% Description: DC/AC inverter
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: D.m
%--------------------------------------------------------------------------
% Return 0 if outside of D, and 1 if inside D
%--------------------------------------------------------------------------
global V qua co ci c3 e1 a b
% states
  iL = x(1);
  vC = x(2);
  p = x(3);
  q = x(4);
  
% useful expressions
  V = (iL/a)^2 + (vC/b)^2;
  qua = quadrant(iL, vC); 

% jump set
  if p == 1
      if q * iL <= 0 && V <= ci  % switch for Si
         inside = 1;
      elseif q * iL >= 0 && V >= co && V <= c3 % switch for So
         inside = 1;
      elseif qua == 2 && q == 1 && iL >= - e1 % switch for vc axis, up
         inside = 1;
      elseif qua == 4 && q == -1 && iL <= e1 % switch for vc axis, low
         inside = 1;
      else
         inside = 0;
      end
  elseif p == 2
      if q ~= 0 && V >= ci % Hg switch for outside Si
         inside = 1;
      elseif q == 0 && V <= co % Hg switch for inside So
         inside = 1;
      else
         inside = 0;
      end
  else 
      inside = 0;
  end
  
end