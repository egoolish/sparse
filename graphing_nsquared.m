interval = 10000000;
t = linspace(-pi,pi,interval); %Creates time vector from -pi to pi (9 elements)
Nrange = 10:10:100;                    %What values of N we are testing
nsquared = zeros(1, 100);
for each=1:length(nsquared)
    nsquared(each) = each.^2;
end                     
m=1;                                
for N=Nrange
    y = nsquared(1:N);
    f = @(t) (1./(N+1)).*(1/(2*pi)).*sum((sin((y+.5).*t))./(sin(.5.*t)));
    fplot(f);
    figure(m);
    m = m+1;
    %plot(t, q);
    %xlabel(['N =', num2str(N), ' N^2 Case']);
    %print(['NsquaredCase', 'N=', num2str(N)], '-dpdf');
end
%close all;