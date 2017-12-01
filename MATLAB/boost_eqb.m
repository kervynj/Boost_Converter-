function [il_eqm, vc_eqm] = boost_eqb()
    % Compute equilibrium values based on passive values
    
    global l;
    global c;
    global r;
    global d;
    global Vin;
    
    il_eqm = Vin/(r*(1-d)^2);
    vc_eqm = Vin/(1-d);
end