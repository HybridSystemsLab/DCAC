%--------------------------------------------------------------------------
% Project: Hybrid Feedback Control book
% Description: DC/AC inverter
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: postprocessing.m
%--------------------------------------------------------------------------
% postprocessing for the DC/AC inverter
%--------------------------------------------------------------------------
%% getting data from workspace
% x = ans.get('x');
% t = ans.get('t');
% j = ans.get('j');
Tend = max(t);
Jend = max(j);

%% data for reference and Si*, So*
  [si, so] = Sio(a, b, ci, co); % Si* and So* trajecotry
  [tref, xref] = inv_refer(a, TSPAN); % ideal trajecotry

%% reduce data points for plots
m = max(size(x));
s = floor(linspace(1,m,m))';
xs = x(s,:);
ts = t(s);

% q0 = find(x(:,2)==0);

%% trajetories and boundaries for ideal case
% ideal case trajectory
if Tend >= 1
    refcyc = floor(length(tref)/Tend/(f-5));
else 
    refcyc = length(xref);
end

figure(1)
fig = gcf;
% ideal case trajectory
subplot(5,2,[1,2,3,4,5,6]);
% ideal case trajectory
plot(xref(1:refcyc,1),xref(1:refcyc,2),'Linewidth',2); hold on
  
% plot outer and inner boundaries
plot(so(:,1),so(:,2:3),'g-.','Linewidth',2); hold on
plot(si(:,1),si(:,2:3),'g-.','Linewidth',2); hold on

% resulting trajectory w/controller
plot(xs(:,1),xs(:,2),'r'); hold on
set(gca,'Xlim', [-a*sqrt(co)*1.1,a*sqrt(co)*1.1])
set(gca,'Ylim', [-b*sqrt(co)*1.1,b*sqrt(co)*1.1])
set(gca,'FontSize', 10)
grid on
xlabel('$i_L$','Interpreter','latex')
ylabel('$v_{C_a}$','Interpreter','latex')
hYLabel = get(gca,'YLabel');
set(hYLabel, 'FontSize', 14)
set(hYLabel,'rotation',0)
hold off
%axis equal


subplot(5,2,[7,8]);
plot(ts,xs(:,2));
set(gca,'FontSize', 10)
set(gca,'Xlim', [0,Tend])
set(gca,'Ylim', [-130,130],'YAxisLocation','left')
ylabel('$v_{C_a}$','Interpreter','latex')
hYLabel = get(gca,'YLabel');
set(hYLabel, 'FontSize', 14)
set(hYLabel,'rotation',0)
grid on

subplot(5,2,[9,10]);
plot(ts,xs(:,4));
set(gca,'FontSize', 10)
set(gca,'Xlim', [0,Tend])
set(gca,'Ylim', [-2,2],'YAxisLocation','left')
ylabel('$q$','Interpreter','latex')
xlabel('$t\, [s]$','Interpreter','latex')
hYLabel = get(gca,'YLabel');
set(hYLabel, 'FontSize', 14)
set(hYLabel,'rotation',0)
grid on

%fig.PaperPosition = [0 0 12 4];

print -depsc -tiff -r300 Matlab-DCACinverter
print -dpdf Matlab-DCACinverter


figure(2)
fig = gcf;
% ideal case trajectory
%subplot(5,2,[1,2,3,4,5,6]);
% ideal case trajectory
plot(xref(1:refcyc,1),xref(1:refcyc,2),'Linewidth',2); hold on
  
% plot outer and inner boundaries
plot(so(:,1),so(:,2:3),'g-.','Linewidth',2); hold on
plot(si(:,1),si(:,2:3),'g-.','Linewidth',2); hold on

% resulting trajectory w/controller
plot(xs(:,1),xs(:,2),'r'); hold on
set(gca,'Xlim', [-a*sqrt(co)*1.1,a*sqrt(co)*1.1])
set(gca,'Ylim', [-b*sqrt(co)*1.1,b*sqrt(co)*1.1])
set(gca,'FontSize', 10)
grid on
xlabel('$i_L$','Interpreter','latex')
ylabel('$v_{C_a}$','Interpreter','latex')
hYLabel = get(gca,'YLabel');
set(hYLabel, 'FontSize', 14)
set(hYLabel,'rotation',0)
hold off
%axis equal

print -depsc -tiff -r300 Matlab-DCACinverter-Planar
%print -dpdf Matlab-DCACinverter-Planar


figure(3)
clf
subplot(2,1,1);
plot(ts,xs(:,2));
set(gca,'FontSize', 10)
set(gca,'Xlim', [0,Tend])
set(gca,'Ylim', [-130,130],'YAxisLocation','left')
ylabel('$v_{C_a}$','Interpreter','latex')
xlabel('$t\, [s]$','Interpreter','latex')
hYLabel = get(gca,'YLabel');
set(hYLabel, 'FontSize', 14)
set(hYLabel,'rotation',0)
grid on

subplot(2,1,2);
%subplot(5,2,[9,10]);
plot(ts,xs(:,4));
set(gca,'FontSize', 10)
set(gca,'Xlim', [0,Tend])
set(gca,'Ylim', [-2,2],'YAxisLocation','left')
ylabel('$q$','Interpreter','latex')
xlabel('$t\, [s]$','Interpreter','latex')
hYLabel = get(gca,'YLabel');
set(hYLabel, 'FontSize', 14)
set(hYLabel,'rotation',0)
grid on

print -depsc -tiff -r300 Matlab-DCACinverter-Signals
%print -dpdf Matlab-DCACinverter-Signals

figure(4)
clf
subplot(1,2,1);
%fig = gcf;
% ideal case trajectory
%subplot(5,2,[1,2,3,4,5,6]);
% ideal case trajectory
plot(xref(1:refcyc,1),xref(1:refcyc,2),'Linewidth',2); hold on
  
% plot outer and inner boundaries
plot(so(:,1),so(:,2:3),'g-.','Linewidth',2); hold on
plot(si(:,1),si(:,2:3),'g-.','Linewidth',2); hold on

% resulting trajectory w/controller
plot(xs(:,1),xs(:,2),'r'); hold on
set(gca,'Xlim', [-a*sqrt(co)*1.1,a*sqrt(co)*1.1])
set(gca,'Ylim', [-b*sqrt(co)*1.1,b*sqrt(co)*1.1])
set(gca,'FontSize', 11)
grid on
xlabel('$i_L$','Interpreter','latex')
ylabel('$v_{C_a}$','Interpreter','latex')
hYLabel = get(gca,'YLabel');
set(hYLabel, 'FontSize', 18)
set(hYLabel,'rotation',0)
hXLabel = get(gca,'XLabel');
%set(hXLabel,'rotation',0)
set(hXLabel, 'FontSize', 18)
%hold off
%axis equal

subplot(1,2,2);
tslim = floor(length(ts)/5*2)-190;
plot(ts(1:tslim),xs(1:tslim,2));
set(gca,'FontSize', 11)
set(gca,'Xlim', [0,ts(tslim)])
set(gca,'Ylim', [-130,130],'YAxisLocation','left')
ylabel('$v_{C_a}$','Interpreter','latex')
xlabel('$t\, [s]$','Interpreter','latex')
hYLabel = get(gca,'YLabel');
set(hYLabel,'rotation',0)
set(hYLabel, 'FontSize', 18)
hXLabel = get(gca,'XLabel');
%set(hXLabel,'rotation',0)
set(hXLabel, 'FontSize', 18)
grid on

print -depsc -tiff -r300 Matlab-DCACinverter-PlanarAndVoltage
