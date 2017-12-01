close all
clc 
clear all

vin = 0.01; %V
din = 0.01;


%% generate state space equations
[a, b, c, d, i, v] = boost_ss();

IC = [0.01; 0];

ccf = canon(ss(a,b,c,d), 'companion'); % convert to CCF realization

A = ccf.a;
B = ccf.b;
C = ccf.c;
D = ccf.d;

%% controller design
ts = 0.01;
OS = 1;

% determine response to large signal input voltage
%boost_response(a, b, c, d, vin, din, IC);
% generate regulator response
Boost_regulator(ccf.a, ccf.b, ccf.c, ccf.d, ts, OS, IC);

% pick apart system to isolate transfer functions
s = ss(A, B, C, D);

inputs = [1, 0.01];

% Generate Tracker for each SISO transfer function as part of MISO system
for j = 1:2
    [num, den] = tfdata(s(j), 'v');
    
    a2 = den(1);
    a1 = den(2);
    a0 = den(3);
    
    b2 = num(1);
    b1 = num(2);
    b0 = num(3);
    
    A = [0 1; -a0 -a1];
    B = [0 ; 1];
    C = [b0 b1];
    D = 0;
    
    %tracking_MISO(A, B, C, D, ts, OS, inputs(j), IC)

    
end



