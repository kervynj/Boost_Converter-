function boost_MISO_regulator(A, B, C, D, ts, OS, IC);


OSys = ss(A,B,C,D);
%% Find system response
OPoles = pole(OSys)
step(OSys)

%% Stablize the system
% desired response:
% Calculate desired poles
zeta = -log2(OS/100)/sqrt(pi^2+log2(OS/100));
wn = 4/ts/zeta;
sigma   = -wn*zeta;
wd      =  wn*sqrt(1-zeta^2);
desP  = [sigma-wd ; sigma+wd];
% Claclulate control gain K
K = place(A,B,desP);

%% Closed loop System
Ac = A - B*K;
CSys = ss(Ac,B*0,C,D);
%% Finding response
dt = 0.0001;
t = 0:dt:5;
u = zeros(2,length(t));
yo = lsim(OSys,u,t,IC);
yc = lsim(CSys,u,t,IC);
%boost_response(A, B, C, D, 0.0, 0.0, IC);
%boost_response(Ac, B*0, C, D, 0.0, 0.0, IC);
% plot
figure
hold on
%plot(t,yo,'r','linewidth',2)
plot(t,yc,'b','linewidth',2)
hold off
grid on
xlabel('time (sec)')
legend('y-open','y-closed')
