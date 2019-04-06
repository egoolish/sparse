interval = 1000;
Nrange = 125:125:1000;                  
n=1;
y_full = zeros(0, max(Nrange));


for each=1:max(Nrange)
    y_full(each) = each^2;
end


for N=Nrange
    
    y = [0, y_full(1:N)];
    t = linspace(0,N*N*pi,interval);
    results = zeros(size(t));
    
    count = 1;
    for each=t
        results(count) = quad_qn(N, each, y);
        count = count+1;
    end
    
    for m = n:length(Nrange)
        figure(m);
        plot(t, results, 'DisplayName', ['qn(s) N=', num2str(N)]);
        xlim([125 5000])
        hold on;
        xlabel(['concurrent quad qn']);
        legend('show');
    end
    
    n=n+1;
    
end

function result=Qn(y, N, t)
    result = (1./(2.*pi)).*(1./(N+1)).*func_sum(y, t);
end

function result=quad_qn(N, s, y)
    result = ((6*pi)/(2*N*N+N+3)).*(Qn(y, N, (s/(N^2)))); 
end

function result = func_sum(y, t)
    result = 0;
    for each=y
        if(t == 0) result = result + (2*each+1);
        else result = result + (sin((each+.5).*t))./(sin(.5.*t));
        end
    end
end
