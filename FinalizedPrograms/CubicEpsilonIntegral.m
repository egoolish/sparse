f = figure(1);
hold on;
legend('show');
title('N^3');
xlabel('log N');
ylabel('log integral from epsilon to pi');

epsilonrange = [0.01:0.01:0.1];
Nrange = 0:50;
value_at = 1;
values = zeros(1, length(Nrange));
y_full = zeros(0, max(Nrange));
for each=1:length(Nrange)
    y_full(each) = each.^3;
end
for epsilon=epsilonrange
    count = 1;
    for N=Nrange
        disp(N);
        y = [0, y_full(1:N)];
        f = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y, t));
        value = quadgk(f, epsilon, pi, 'MaxIntervalCount', 10000000);
        values(count) = value;
        count=count+1;
    end
    plot(log(Nrange), log(values), 'DisplayName', ['e =', num2str(epsilon)]);
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
