interval = 1000000;
Nrange = 28:29;
m=1;
t = linspace(500000000, 500100000, interval);
y_full = zeros(0, Nrange(end));
for each=1:Nrange(end)
    y_full(each) = 2^each;
end
results = zeros(1, length(t));
h = figure(1);
xlabel('Qn(s/2^{N})');
hold on;
legend('show');
for N=Nrange
    y = [1, y_full(1:N)];
    count2 = 1;
    for each=t
        disp(count2);
        if (each > (pi*(2^(N))))
            results(count2) = NaN;
        else
            results(count2) = abs(linearqn(N, each, y));
        end
        count2 = count2 +1;
    end
    figure(1);
    plot(t, results, 'DisplayName', ['N = ', num2str(N)]);
end

function result=Qn(y, N, t)
    result = (1./(2.*pi)).*(1./(N+1)).*func_sum(y, t);
end

function result=linearqn(N, s, y)
	result = (((2.*pi).*(N+1))./(2.^(N+2)+N-1)).*(Qn(y, N, (s/(2^(N))))); %2^N
end

function result = func_sum(y, t)
% result = 3;
% for each=y
%  result = result + (sin((each+.5).*t))./(sin(.5.*t));
% end
result = 0;
for each=y
    if(t == 0) result = result + (2*each+1);
    else result = result + (sin((each+.5).*t))./(sin(.5.*t));
    end
end
end
