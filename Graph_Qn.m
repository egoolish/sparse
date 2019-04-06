interval = 100000000;
t = linspace(-pi,pi,interval); %Creates time vector from -pi to pi (9 elements)
Nrange = 5:5:20;                    %What values of N we are testing
prange = 2;                       %What values of p we are testing
m=1;                                %Counter Variable
for N=Nrange
    for p=prange
        for j = 1:p/2
            zoom = (2*pi*j)/(p);
            t=linspace(zoom - (5/p)*(pi/8), zoom + (5/p)*(pi/8), interval);
            q = (1./(2.*pi)).*(1./(N+1)).*Qn(p, N, t);
            figure(m);
            m = m+1;
            plot(t, q);
            xlabel(['Qn for N =', num2str(N), ', p = ', num2str(p*j), ', Zoom ', num2str(j*2), 'pi/', num2str(p)]);
            %print(['Qn for N =', num2str(N), ', p = ', num2str(p), ', Zoom ', num2str(j*2), 'pi:', num2str(p)], '-dpdf');
        end     
    end
end


function result=Qn(p, N, t)
    num = sin(((((p./2).*N)+0.5).*t)) .* sin((p./2).*(N+1).*t);
    den = sin(t./2) .* sin((p./2).*t);
    result = num./den;
end