function gaussianWave()
% x0 = maximum of gauss     p0 = initial momentum     L = width of well
% a = width of gaussian
% t = duration of simulation     dt = time step

% sample input:
% gauss2(, , , , ,)
    
    x0 = 5;
    p0 = 5;
    L = 50;
    a = 8;
    t = 10;
    dt = .1;

    ts = 0:dt:t;
    
    p_well = zeros(1, L);
    x_axis = linspace(0,L);
    psi_n = NaN(1,length(p_well));
    
    %constants
    hbar = 1.0545718e-34; %planck's constant / 2pi
    mass = 9.10938356e-28; %mass of electron in grams
    
%     N = 10; %number of energy states
    N = [1:10];

    psi_nArray = NaN(1,length(N));
    t_evolArray = NaN(1,length(N));
    
    for xp = 1:length(p_well)
        psi_nx = 0;
        for n = 1:length(N)
            dCn = @(x) sqrt(2/L).* sin((x.* n * pi)/L).* (1/sqrt(sqrt(pi)*a).* exp(-1*(x - x0).^2/(2 * a^2) - (x.*1i*p0)/hbar));
            cn = integral(dCn, 0, L);
            psi_nx = psi_nx + sqrt(2/L) * sin((xp * n * pi)/L);
        end
        psi_n(xp) = cn * psi_nx;
    end
    figure(1)
    plot(conj(psi_n).*psi_n)
    
    time_evol = NaN(1,length(ts));
    for t = 1:length(ts)
        for n = 1:length(N)
            t_evolArray(n) = exp((-1i * ((n^2 * pi^2)/(2 * mass * L^2)) * t)/hbar);
        end
        time_evol(t) = sum(t_evolArray(n));
    end
    
    for t = 1:length(ts)
        psi_t = psi_n.*time_evol(t);
        prob_amp = conj(psi_t).*psi_t;
        figure(2)
        plot(p_well, prob_amp); hold on;
        getframe;
    end
    

%     psi_xtArray = NaN(1,length(N));
%     
%     cnArray = NaN(1,length(N));
    
%     for n = 1:length(N)
%         dCn = @(x) sqrt(2/L).* sin((x.* n * pi)/L).* (1/sqrt(sqrt(pi)*a).* exp(-1*(x - x0).^2/(2 * a^2) - (x.*1i*p0)/hbar));
%         cn = integral(dCn, 1, L);
%         cnArray(n) = cn;
%     end
%     
% %     for xp = 1:length(p_well)
%         for t = 1:length(ts)
%             for n = 1:length(N);
%                 psi_nArray(n) = sqrt(2/L) * sin((x_axis.* n * pi)/L);
%                 t_evolArray(n) = exp((-1i * (n^2 * pi^2)/(2 * mass * L^2) * t)/hbar);
%                 
%                 psi_xtArray(n) = cnArray(n) * t_evolArray(n) * psi_nArray(n);
%             end
%             psi_xt_at_t = sum(psi_xtArray);
%             prob_amp = conj(psi_xt_at_t).*psi_xt_at_t;
%             plot(x_axis, prob_amp)
% %             f(t) = getframe;
%         end
% %     end
%     length(x_axis)
%     length(p_well)
end


%                 dCn = @(x) sqrt(2/L).* sin((x.* n * pi)/L).* (1/sqrt(sqrt(pi)*a).* exp(-1*(x - x0).^2/(2 * a^2) - (x.*1i*p0)/hbar));
%                 cn = integral(dCn, 1, L);
%                 psi_nx = psi_nx + sqrt(2/L) * sin((xp * n * pi)/L);
%                 t_evol = exp((-1i * (n^2 * pi^2)/(2 * mass * L^2) * t)/hbar);
%                 
%                 psi_xt = cn * t_evol * psi_nx;
%                 p_amp = conj(psi_xt).*psi_xt;
%                 plot(p_well, p_amp); hold on;
%                 getframe;
