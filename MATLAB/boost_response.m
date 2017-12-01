function boost_response(a, b, c, d, vin, din, IC)

    global vc_eqm;
    global il_eqm;

    Lsys = ss(a,b,c,d);

    [il_eqm, vc_eqm] = boost_eqb();

    dt = 0.000001;
    T = 0:dt:5;
    L = length(T);
    smallsig = [vin 0; 0 din];
    U = (smallsig*(ones(L,2).')).';



    [Y,T,X] = lsim(Lsys,U,T,IC);
    
    % Add steady state back to output
    y = Y + 15;

    figure;
    subplot(2,1,1)
    plot(T,y,'r','linewidth',2);
    xlabel('Time(sec)')
    ylabel('Output');
    legend('Output, Y = Vout')
    title('Output vs time')
    grid on
    hold on
    subplot(2,1,2)
    plot(T,X(:,1),'y','linewidth',2);
    hold on
    plot(T,X(:,2),'g','linewidth',2);
    xlabel('Time(Sec)');
    ylabel('States');
    legend('X1delta, Inductor Current','X2delta, Capacitor Voltage');
    title('States vs time');
    hold off
    grid on

    

end
