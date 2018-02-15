function integrals()
% x-axis parameters
    hbar=1;
    m=1e3;
    k=1;
    omega=sqrt(k/m);

    % Initial amplitude and phase of the coherent state.
    alpha0 = 5*exp(-i*pi/2);


    x = linspace(-10,10,1000)
    % energies
    avgE = hbar*omega*(abs(alpha0)^2+1/2);
    V = k*x.^2/2;
    % time-evolving parameters
    alpha = @(t) alpha0*exp(-i*omega*t);
    avgx = @(t) sqrt(2*hbar/(m*omega))*real(alpha(t));
    % probability density
    rho = @(t) sqrt(m*omega/(pi*hbar))*exp(-(m*omega/hbar)*(x-avgx(t)).^2);

    % animation
    clear M;
    periods = 3;
    for t = 1:periods*2*pi/omega;
        plot(x,ones(size(x))*avgE,x,V,x,rho(t)+avgE);
        axis([-3,3,0,5]);
        M(t) = getframe;
    end

    %v = VideoWriter('CoherentState.avi');
    %open(v);
    %writeVideo(v,M);
    %close(v);

    %figure
    %movie(M)

end
