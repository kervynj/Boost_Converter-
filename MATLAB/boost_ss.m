%% boost simulation API
% helper functions for analysis
function [A, B, C, D, il_eqm, vc_eqm]= boost_ss()
    % Linearized matricies for weighted small-signal state space model
    % around EQM point
    % config
    % boost converter parameters
    global l;
    global c;
    global r;
    global d;
    global Vin;
    

    l = 22e-3;
    c = 22e-3;
    r = 0.1;
    d = 0.667;
    Vin = 5;
    
    % eqb points
    [il_eqm, vc_eqm] = boost_eqb();
    
    A = [0 -(1-d)/l; (1-d)/c -1/r*c];
    B = [1/l vc_eqm/l; 0 -il_eqm/c];
    C = [0 1];
    D = [0];
end


