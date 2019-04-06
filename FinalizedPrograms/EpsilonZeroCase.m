f = figure(1);
hold on;
legend('show');
title('Concurrent Epsilon=0');
xlabel('N');
ylabel('integral from epsilon to pi');

epsilonrange = 0;
Nrange = 0:50;
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
    plot(Nrange, values, 'DisplayName', 'Linear');
    value_at = value_at+1;
end

Nrange = 0:50;
value_at = 1;
values = zeros(1, length(Nrange));
y_full = zeros(1, max(Nrange));
for each=1:length(Nrange)
    y_full(each) = each.^2;
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
    plot(Nrange, values, 'DisplayName', 'n^2', 'color', [0.6350    0.0780    0.1840]);
    value_at = value_at+1;
end

Nrange = 0:50;
value_at = 1;
values = zeros(1, length(Nrange));
y_full = zeros(1, max(Nrange));
for each=1:length(Nrange)
    y_full(each) = each.^3;
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
    plot(Nrange, values, 'DisplayName', 'n^3');
    value_at = value_at+1;
end

Nrange = 0:37;
value_at = 1;
values = zeros(1, length(Nrange));
y_full = zeros(1, max(Nrange));
for each=1:length(Nrange)
    y_full(each) = 2^each;
end
for epsilon=epsilonrange
    count = 1;
    for N=Nrange
        disp(N);
        y = [1, y_full(1:N)];
        f = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y, t));
        value = quadgk(f, 0, pi, 'MaxIntervalCount', 10000000);
        values(count) = value;
        count=count+1;
    end
    plot(Nrange, values, 'DisplayName', '2^n');
    value_at = value_at+1;
end

Nrange = 0:6;
value_at = 1;
values = zeros(1, length(Nrange));
y_full = zeros(1, max(Nrange));
for each=1:length(Nrange)
    y_full(each) = 2^(each^2);
end
for epsilon=epsilonrange
    count = 1;
    for N=Nrange
        disp(N);
        y = [1, y_full(1:N)];
        f = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y, t));
        value = quadgk(f, 0, pi, 'MaxIntervalCount', 10000000);
        values(count) = value;
        count=count+1;
    end
    plot(Nrange, values, 'DisplayName', '2^{n^2}');
    value_at = value_at+1;
end


Nrange = 0:10;
value_at = 1;
values = zeros(1, length(Nrange));
y_full = zeros(1, max(Nrange));
for each=1:length(Nrange)
    y_full(each) = 2^(1+each^3);
end
for epsilon=epsilonrange
    count = 1;
    for N=Nrange
        disp(N);
        y = [2, y_full(1:N)];
        f = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y, t));
        value = quadgk(f, 0, pi, 'MaxIntervalCount', 10000000);
        values(count) = value;
        count=count+1;
    end
    plot(Nrange, values, 'DisplayName', '2^{1+n^3}');
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
