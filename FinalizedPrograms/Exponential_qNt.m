interval = 1000000;
Nrange = 5:5:30;                  
n=1;
y_full = zeros(0, max(Nrange));


for each=1:max(Nrange)
    y_full(each) = 2^each;
end


for N=Nrange
    
    y = [1, y_full(1:N)];
    t = linspace(5,min(2^N*pi, 3000),interval);
    results = zeros(size(t));
    
    count = 1;
    for each=t
        disp(count);
        results(count) = exp_qn(N, each, y);
        count = count+1;
    end
    
    for m = n:length(Nrange)
        figure(m);
        plot(t, results, 'DisplayName', ['qn(s) N=', num2str(N)]);
        xlim([100 3000])
        hold on;
        xlabel(['concurrent 2^N qn']);
        legend('show');
    end
    
    n=n+1;
    
end

function result=Qn(y, N, t)
    result = (1./(2.*pi)).*(1./(N+1)).*func_sum(y, t);
end

function result=exp_qn(N, s, y)
    result = (((2.*pi).*(N+1))./(2.^(N+2)+N-1)).*(Qn(y, N, (s/(2^(N)))));
end

function result = func_sum(y, t)
    result = 0;
    for each=y
        if(t == 0) result = result + (2*each+1);
        else result = result + (sin((each+.5).*t))./(sin(.5.*t));
        end
    end
end
