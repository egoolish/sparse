interval = 10000000;
t = linspace(-pi,pi,interval); %Creates time vector from -pi to pi (9 elements)
Nrange = 5:5:20;                    %What values of N we are testing
prange = 2:5;                       %What values of p we are testing
m=1;
q=0;
for N=Nrange
    for p=prange
        x = 0:N;
        y = zeros(0, N);
        for each=1:N+1
           r = rand;
           if(r<(1/3))
               y(each)=(each-1)*p-1;
           elseif((r>=(1/3)) &&(r<2/3))
               y(each)=(each-1)*p+1;
           else
               y(each)=(each-1)*p;
           end
        end
        for j = y
            q = q + (sin((j+.5).*t))./(sin(.5.*t));
        end
        disp(q);
        b = (1./(N+1)).*(1/(2*pi)).*q;
        figure(m);
        plot(t, b);
        xlabel(['Qn Random for p =', num2str(p), ', N= ', num2str(N)]);
        print(['Qn Random for p =', num2str(p), ', N= ', num2str(N)], '-dpdf');
        m=m+1;
        q=0;  
    end
end
close all;