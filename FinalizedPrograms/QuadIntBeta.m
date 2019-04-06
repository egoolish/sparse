epsilonrange = 0.001:0.0005:0.1;
Nrange = 25:25:125;
alpha = 0.5;

a_values = zeros(length(epsilonrange), 1);
b_values = zeros(length(epsilonrange), 1);
e_values = zeros(length(epsilonrange), 1);
y_full = zeros(1, max(Nrange));
y_fullrand = zeros(1, max(Nrange));

for each=1:Nrange(end)
    y_full(each) = each.^2;
end

y_fullrand(1) = 1;
y_fullrand(end) = y_full(end);
for each=2:max(Nrange)-1
    y_fullrand(each) = randi([y_full(each-1) y_full(each+1)]);
end

value_at = 1;

figure(1);
hold on;
legend show;
title('Quadratic I_N(\epsilon)');
ylabel('\alpha log(N) + log(I_N(\epsilon))');
xlabel('log(1/\epsilon)');

figure(2);
hold on;
legend show;
title('Quadratic Random I_N(\epsilon)');
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
        value = integral(f, epsilon, pi,'ArrayValued',true);
        rand_value = integral(f2, epsilon, pi,'ArrayValued',true);
        lhs(count) = alpha*log(N) + log(value);
        rhs(count) = log(1./epsilon);
        lhs_rand(count) = alpha*log(N) + log(rand_value);
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
