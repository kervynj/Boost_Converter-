function tracking_MISO(A, B, C, D, ts, OS, input, IC); 

OSys = ss(A,B,C,D)
%% Find system response
OPoles = pole(OSys)
%% Stablize the system
% Calculate desired poles
zeta = -log2(OS/100)/sqrt(pi^2+log2(OS/100));
wn = 4/ts/zeta;
sigma   = -wn*zeta;
wd      =  wn*sqrt(1-zeta^2);
desP  = [sigma-wd ; sigma+wd];
% Claclulate control gain K
K = place(A,B,desP)

Ac = A - B*K; %Closed loop A
Gc = -1/(C*(Ac)^-1*B)
%% Closed loop System
CSys = ss(Ac,B*Gc,C,D);
step(CSys);
%% Finding response

dt = 0.0001;
t = 0:dt:10;
u = input*ones(1,length(t));
yo = lsim(OSys,u,t,IC);
yc  = lsim(CSys,u,t,IC);
% plot
figure
hold on
plot(t,yo,'r','linewidth',2)
plot(t,yc,'b','linewidth',2)
hold off
grid on
xlabel('time (sec)')
legend('yo','yc')
