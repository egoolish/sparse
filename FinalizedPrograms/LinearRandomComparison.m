interval = 10000;
Nrange = 125;                  
n=1;
p = 5;

y_full = zeros(1, max(Nrange));
y_fullrand = zeros(1, max(Nrange));

for each=1:Nrange(end)
    y_full(each) = each.*p;
end

y_fullrand(1) = p;
y_fullrand(end) = y_full(end);
for each=2:Nrange(end)
    r = rand;
    if(r<(1/3))
        y_fullrand(each)=(each)*p-1;
    elseif(r>=(1/3) && (r<2/3))
        y_fullrand(each)=(each)*p+1;
    else
        y_fullrand(each)=(each)*p;
    end
end


for N=Nrange
    
    y = [0 y_full(1:N)];
    yrand = [0 y_fullrand(1:N)];
    t = linspace(-25,600,interval);
    results = zeros(size(t));
    resultsrand = zeros(size(t));
    
    count = 1;
    for each=t
        disp(count);
        results(count) = lin_qn(N, each, y, p);
        resultsrand(count) = lin_qn(N, each, yrand, p);
        count = count+1;
    end
    
    for m = n:length(Nrange)
        figure(m);
        hold on;
        plot(t, results, 'DisplayName', ['Qn(s) N=', num2str(N)]);
        plot(t, resultsrand, 'DisplayName', ['randQn(s) N=', num2str(N)]);
        xlabel(['random v deterministic linear Qn']);
        legend('show');
    end
    
    n=n+1;
    
end

function result=Qn(y, N, t)
    result = (1./(2.*pi)).*(1./(N+1)).*func_sum(y, t);
end

function result=lin_qn(N, s, y, p)
    result = ((2*pi)/(p*N+1)).*(Qn(y, N, (s/(p*N)))); 
end

function result = func_sum(y, t)
    result = 0;
    for each=y
        if(t == 0) result = result + (2*each+1);
        else result = result + (sin((each+.5).*t))./(sin(.5.*t));
        end
    end
end
