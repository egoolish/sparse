interval = 10000000;
t = linspace(-pi,pi,interval); %Creates time vector from -pi to pi (9 elements)
Nrange = 100:100:1000;                    %What values of N we are testing
prange = 1;                       %What values of p we are testing
m=1;                                %Counter Variable
for N=Nrange
    for p=prange 
%           f = @(t)abs((1./(2.*pi)).*(1./(N+1)).*Qn(p, N, t));
%           value = integral(f, -pi, pi);
%           disp(value);
        disp(N);
        q = (1./(2.*pi)).*(1./(N+1)).*Qn(p, N, t);
        figure(m);
        m = m+1;
        plot(t, q);
        xlabel(['N =', num2str(N), ' p = ', num2str(p)]);
        %print(['P=', num2str(p), 'N=', num2str(N)], '-dpdf');
    end
end
%close all;

function result=Qn(p, N, t)
    num = sin(((((p./2).*N)+0.5).*t)) .* sin((p./2).*(N+1).*t);
    den = sin(t./2) .* sin((p./2).*t);
    result = num./den;
end