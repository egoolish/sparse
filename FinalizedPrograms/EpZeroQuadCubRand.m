f = figure(1);
hold on;
legend('show');
title('Concurrent Epsilon=0');
xlabel('N');
ylabel('I_N(0)');

epsilonrange = 0;

Nrange = 0:50;
value_at = 1;
values = zeros(1, length(Nrange));
values2 = zeros(1, length(Nrange));
y_full = zeros(1, max(Nrange));
for each=1:length(Nrange)
    y_full(each) = each.^2;
end
y_fullrand(1) = 1;
y_fullrand(end) = y_full(end);
for each=2:max(Nrange)-1
    y_fullrand(each) = randi([y_full(each-1) y_full(each+1)]);
end
for epsilon=epsilonrange
    count = 1;
    for N=Nrange
        disp(N);
        y = [0, y_full(1:N)];
        y_rand = [0, y_fullrand(1:N)];
        f = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y, t));
        g = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y_rand, t));
        value = quadgk(f, 0, pi, 'MaxIntervalCount', 10000000);
        value2 = quadgk(g, 0, pi, 'MaxIntervalCount', 10000000);
        values(count) = value;
        values2(count) = value2;
        count=count+1;
    end
    plot(Nrange, values, 'DisplayName', 'n^2');
    plot(Nrange, values2, 'DisplayName', 'Rand n^2');
    value_at = value_at+1;
end

Nrange = 0:50;
value_at = 1;
values = zeros(1, length(Nrange));
values2 = zeros(1, length(Nrange));
y_full = zeros(1, max(Nrange));
for each=1:length(Nrange)
    y_full(each) = each.^3;
end
y_fullrand(1) = 1;
y_fullrand(end) = y_full(end);
for each=2:max(Nrange)-1
    y_fullrand(each) = randi([y_full(each-1) y_full(each+1)]);
end
for epsilon=epsilonrange
    count = 1;
    for N=Nrange
        disp(N);
        y = [0, y_full(1:N)];
        y_rand = [0, y_fullrand(1:N)];
        f = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y, t));
        g = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y_rand, t));
        value = quadgk(f, 0, pi, 'MaxIntervalCount', 10000000);
        value2 = quadgk(g, 0, pi, 'MaxIntervalCount', 10000000);
        values(count) = value;
        values2(count) = value2;
        count=count+1;
    end
    plot(Nrange, values, 'DisplayName', 'n^3', 'color', [0.6350    0.0780    0.1840]);
    plot(Nrange, values2, 'DisplayName', 'Rand n^3');
    value_at = value_at+1;
end


function result = func_sum(y, t)
    result = 0;
    for each=y
        if(t == 0) result = result + (2*each+1);
        else result = result + (sin((each+.5).*t))./(sin(.5.*t));
        end
    end
end
