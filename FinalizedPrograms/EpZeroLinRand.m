f = figure(1);
hold on;
legend('show');
title('Random Linear Concurrent Epsilon=0');
xlabel('N');
ylabel('I_N(0)');
Nrange = 0:150;
epsilonrange = 0;
value_at = 1;
values = zeros(1, length(Nrange));
p = 3;
y_fullrand = zeros(1, length(Nrange));
y_fullrand(1) = p;
y_fullrand(end) = p*Nrange(end);
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
for epsilon=epsilonrange
    count = 1;
    for N=Nrange
        disp(N);
        y = [0, y_fullrand(1:N)];
        f = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y, t));
        value = quadgk(f, 0, pi, 'MaxIntervalCount', 10000000);
        values(count) = value;
        count=count+1;
    end
    plot(Nrange, values, 'DisplayName', 'Random P = 3');
    value_at = value_at+1;
end

value_at = 1;
values = zeros(1, length(Nrange));
p = 4;
y_fullrand = zeros(1, length(Nrange));
y_fullrand(1) = p;
y_fullrand(end) = p*Nrange(end);
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
for epsilon=epsilonrange
    count = 1;
    for N=Nrange
        disp(N);
        y = [0, y_fullrand(1:N)];
        f = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y, t));
        value = quadgk(f, 0, pi, 'MaxIntervalCount', 10000000);
        values(count) = value;
        count=count+1;
    end
    plot(Nrange, values, 'DisplayName', 'Random P = 4');
    value_at = value_at+1;
end

value_at = 1;
values = zeros(1, length(Nrange));
p = 5;
y_fullrand = zeros(1, length(Nrange));
y_fullrand(1) = p;
y_fullrand(end) = p*Nrange(end);
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
for epsilon=epsilonrange
    count = 1;
    for N=Nrange
        disp(N);
        y = [0, y_fullrand(1:N)];
        f = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y, t));
        value = quadgk(f, 0, pi, 'MaxIntervalCount', 10000000);
        values(count) = value;
        count=count+1;
    end
    plot(Nrange, values, 'DisplayName', 'Random P = 5', 'color', [0.4940    0.1840    0.5560]);
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

