epsilonrange = 0.0005:0.0005:0.1;
Nrange = 200:10:250;
alpha = 0.93;
rand_alpha = 0.6;
p = 5;

a_values = zeros(length(epsilonrange), 1);
b_values = zeros(length(epsilonrange), 1);
e_values = zeros(length(epsilonrange), 1);
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
value_at = 1;

figure(1);
hold on;
legend show;
title('Linear p = 5, I_N(\epsilon): 0.0005 \leq \epsilon \leq 0.1');
ylabel('\alpha log(N) + log(I_N(\epsilon))');
xlabel('log(1/\epsilon)');

figure(2);
hold on;
legend show;
title('Linear Random p = 5, I_N(\epsilon): 0.0005 \leq \epsilon \leq 0.1');
ylabel('\alpha log(N) + log(I_N(\epsilon))');
xlabel('log(1/\epsilon)');
for N = Nrange
    count = 1;
    y = [0, y_full(1:N)];
    y_rand = [0, y_fullrand(1:N)];
    lhs = zeros(1, length(epsilonrange));
    rhs = zeros(1, length(epsilonrange));
    lhs_rand = zeros(1, length(epsilonrange));
    rhs_rand = zeros(1, length(epsilonrange));
    for epsilon = epsilonrange
        disp(epsilon);
        f = @(t)abs(Qn(y, N, t));
        f2 = @(t)abs(Qn(y_rand, N, t));
        value = quadgk(f, epsilon, pi, 'MaxIntervalCount', 10000000);
        rand_value = quadgk(f2, epsilon, pi, 'MaxIntervalCount', 10000000);
        lhs(count) = alpha*log(N) + log(value);
        rhs(count) = log(1./epsilon);
        lhs_rand(count) = rand_alpha*log(N) + log(rand_value);
        count = count + 1;
    end
    fit = polyfit(rhs, lhs, 1);
    figure(1);
    plot(rhs, lhs, 'DisplayName', ['N=', num2str(N), ' \beta=', num2str(fit(1))]);
    figure(2);
    rand_fit = polyfit(rhs, lhs_rand, 1);
    plot(rhs, lhs_rand, 'DisplayName', ['N=', num2str(N), ' \beta=', num2str(rand_fit(1))]);
end
    
function result=Qn(y, N, t)
    result = (1./(2.*pi)).*(1./(N+1)).*func_sum(y, t);
end

function result = func_sum(y, t)
    result = 0;
    for each=y
        if(t == 0) result = result + (2*each+1);
        else result = result + (sin((each+.5).*t))./(sin(.5.*t));
        end
    end
end
