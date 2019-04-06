interval = 1000000;
Nrange = 15:5:30;
m=1;
t = linspace(-0.01, 0.01, interval);
y_full = zeros(0, Nrange(end));
for each=1:Nrange(end)
    y_full(each) = 2^each;
end
results = zeros(1, length(t));
results2 = zeros(1, length(t));
h = figure(1);
xlabel('Qn(s/2^{N})');
hold on;
legend('show');
for N=Nrange
    y = y_full(1:N);
    count2 = 1;
    for each=t
        disp(count2);
        if (each > (pi*(2^(N))))
            results(count2) = NaN;
            results2(count2) = NaN;
        else
            results(count2) = abs(linearqn(N, each, y));
            results2(count2) = abs(linearqn2(N, each, y));
        end
        count2 = count2 +1;
    end
    figure(1);
    plot(t, results, 'DisplayName', ['Qn(2s)','N = ', num2str(N)]);
    plot(t, results2, 'DisplayName', ['c*Qn(s)', 'N = ', num2str(N)]);
end

function result=Qn(y, N, t)
    result = (1./(2.*pi)).*(1./(N+1)).*func_sum(y, t);
end

function result=linearqn(N, s, y)
	result = (((2*pi)*(N+1))/(2^(N+2)+N-1)).*Qn(y, N, (2.*s)); %2^N
end

function result=linearqn2(N, s, y)
	result = (((2*pi)*(N+1))/(2^(N+2)+N-1)).*cos(s).*(sin(0.5.*s)./sin(s)).*Qn(y, N, s); %2^N
end

function result = func_sum(y, t)
result = 1;
for each=y
    result = result + (sin((each+.5).*t))./(sin(.5.*t));
end
end
