f = figure(1);
hold on;
legend('show');
title('Linear Concurrent Epsilon=0');
xlabel('N');
ylabel('I_N(0)');

epsilonrange = 0;
Nrange = 0:150;
value_at = 1;
values = zeros(1, length(Nrange));
y_full = zeros(1, max(Nrange));
for each=1:length(Nrange)
    y_full(each) = each;
end
for epsilon=epsilonrange
    count = 1;
    for N=Nrange
        disp(N);
        y = [0, y_full(1:N)];
        f = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y, t));
        value = quadgk(f, 0, pi, 'MaxIntervalCount', 10000000);
        values(count) = value;
        count=count+1;
    end
    plot(Nrange, values, 'DisplayName', 'P = 1');
    value_at = value_at+1;
end

value_at = 1;
values = zeros(1, length(Nrange));
y_full = zeros(1, max(Nrange));
for each=1:length(Nrange)
    y_full(each) = 2*each;
end
for epsilon=epsilonrange
    count = 1;
    for N=Nrange
        disp(N);
        y = [0, y_full(1:N)];
        f = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y, t));
        value = quadgk(f, 0, pi, 'MaxIntervalCount', 10000000);
        values(count) = value;
        count=count+1;
    end
    plot(Nrange, values, 'DisplayName', 'P = 2');
    value_at = value_at+1;
end

value_at = 1;
values = zeros(1, length(Nrange));
y_full = zeros(1, max(Nrange));
for each=1:length(Nrange)
    y_full(each) = 3*each;
end
for epsilon=epsilonrange
    count = 1;
    for N=Nrange
        disp(N);
        y = [0, y_full(1:N)];
        f = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y, t));
        value = quadgk(f, 0, pi, 'MaxIntervalCount', 10000000);
        values(count) = value;
        count=count+1;
    end
    plot(Nrange, values, 'DisplayName', 'P = 3');
    value_at = value_at+1;
end

value_at = 1;
values = zeros(1, length(Nrange));
y_full = zeros(1, max(Nrange));
for each=1:length(Nrange)
    y_full(each) = 4*each;
end
for epsilon=epsilonrange
    count = 1;
    for N=Nrange
        disp(N);
        y = [0, y_full(1:N)];
        f = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y, t));
        value = quadgk(f, 0, pi, 'MaxIntervalCount', 10000000);
        values(count) = value;
        count=count+1;
    end
    plot(Nrange, values, 'DisplayName', 'P = 4');
    value_at = value_at+1;
end

value_at = 1;
values = zeros(1, length(Nrange));
y_full = zeros(1, max(Nrange));
for each=1:length(Nrange)
    y_full(each) = 5*each;
end
for epsilon=epsilonrange
    count = 1;
    for N=Nrange
        disp(N);
        y = [0, y_full(1:N)];
        f = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y, t));
        value = quadgk(f, 0, pi, 'MaxIntervalCount', 10000000);
        values(count) = value;
        count=count+1;
    end
    plot(Nrange, values, 'DisplayName', 'P = 5');
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
