epsilonrange = 0;
Nrange = 0:150;
value_at = 1;
nsquared = zeros(1, length(Nrange));
nsquared(1) = 1;
for each=2:length(nsquared)
    nsquared(each) = each;
end
figure(1);
title('Random Concurrent Epsilon=0');
xlabel('N');
ylabel('integral from epsilon to pi');

values = zeros(1, length(Nrange));
for epsilon=epsilonrange
    count = 1;
    y_full = zeros(1, length(Nrange));
    for each=2:length(Nrange)+1
%         r = rand;
%         if(r<(1/3))
%             y_full(each)=(each-1)*p-1;
%         elseif(r>=(1/3) && (r<2/3))
%             y_full(each)=(each-1)*p+1;
%         else
%             y_full(each)=(each-1)*p;
%         end
        y_full(each) = each*p;
    end
    for N=Nrange
        disp(N);
         y = y_full(1:N);
        f = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y, t));
        %f = @(t)abs((1./(2.*pi)).*(1./(N+1)).*Qn(p, N, t));
        value = integral(f, epsilon, pi,'ArrayValued',true);
        values(count) = value;
        count=count+1;
    end
    figure(1);
    hold on;
    plot(Nrange, values, 'DisplayName', 'Linear');
    legend('show');
    value_at = value_at+1;
end

value_at = 1;
values = zeros(1, length(Nrange));
truensquared = zeros(1, length(Nrange)+1);
for each=2:length(truensquared)+1
    truensquared(each) = each^2;
end
for epsilon=epsilonrange
    count = 1;
    y_full = zeros(1, length(Nrange));
    y_full(1) = 1;
    for each=2:length(Nrange)+1
        y_full(each) = randi([truensquared(each-1), truensquared(each+1)]);
    end
    for N=Nrange
        disp(N);
        y = y_full(1:N);
        f = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y, t));
        value = integral(f, epsilon, pi,'ArrayValued',true);
        values(count) = value;
        count=count+1;
    end
    figure(1);
    hold on;
    plot(Nrange, values, 'DisplayName', 'Quadratic');
    legend('show');
    value_at = value_at+1;
end

value_at = 1;
values = zeros(1, length(Nrange));
truensquared = zeros(1, length(Nrange)+1);
for each=2:length(truensquared)+1
    truensquared(each) = each^3;
end
for epsilon=epsilonrange
    count = 1;
    y_full = zeros(1, length(Nrange));
    y_full(1) = 1;
    for each=2:length(Nrange)+1
        y_full(each) = randi([truensquared(each-1), truensquared(each+1)]);
    end
    for N=Nrange
        disp(N);
        y = y_full(1:N);
        f = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y, t));
        value = integral(f, epsilon, pi,'ArrayValued',true);
        values(count) = value;
        count=count+1;
    end
    figure(1);
    hold on;
    plot(Nrange, values, 'DisplayName', 'Cubic');
    legend('show');
    value_at = value_at+1;
    
end

value_at = 1;
values = zeros(1, length(Nrange));
truensquared = zeros(1, length(Nrange)+1);
for each=2:length(truensquared)+1
    truensquared(each) = 2^each;
end
for epsilon=epsilonrange
    count = 1;
    y_full = zeros(1, length(Nrange));
    y_full(1) = 2;
    for each=2:length(Nrange)+1
        if(each<50)
            y_full(each) = randi([truensquared(each-1), truensquared(each+1)]);
        else
            r = randi([-(2^50), 2^50]);
            y_full(each) = truensquared(each) + r;
        end
    end
    for N=Nrange
        disp(N);
        y = y_full(1:N);
        f = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y, t));
        value = integral(f, epsilon, pi,'ArrayValued',true);
        values(count) = value;
        count=count+1;
    end
    figure(1);
    hold on;
    plot(Nrange, values, 'DisplayName', '2^n');
    legend('show');
    value_at = value_at+1;
    
end


Nrange = 1:25;
value_at = 1;
values = zeros(1, length(Nrange));
truensquared = zeros(1, length(Nrange)+1);
for each=2:length(truensquared)+1
    truensquared(each) = 2^(each^2);
end
for epsilon=epsilonrange
    count = 1;
    y_full = zeros(1, length(Nrange));
    y_full(1) = 1;
    for each=2:length(Nrange)+1
        if(truensquared(each+1) < 2^50)
            y_full(each) = randi([truensquared(each-1), truensquared(each+1)]);
        else
            r = randi([-(2^50), 2^50]);
            y_full(each) = truensquared(each) + r;
        end
    end
    for N=Nrange
        disp(N);
        y = y_full(1:N);
        f = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y, t));
        value = integral(f, epsilon, pi,'ArrayValued',true);
        values(count) = value;
        count=count+1;
    end
    figure(1);
    hold on;
    plot(Nrange, values, 'DisplayName', '2tothe(n^2)');
    legend('show');
    value_at = value_at+1;
    
end

Nrange = 1:10;
value_at = 1;
values = zeros(1, length(Nrange));
truensquared = zeros(1, length(Nrange)+1);
for each=2:length(truensquared)+1
    truensquared(each) = 2^(1+each^3);
end
for epsilon=epsilonrange
    count = 1;
    y_full = zeros(1, length(Nrange));
    y_full(1) = 2;
    for each=2:length(Nrange)+1
        if(truensquared(each+1) < 2^50)
            y_full(each) = randi([truensquared(each-1), truensquared(each+1)]);
        else
            r = randi([-(2^50), 2^50]);
            y_full(each) = truensquared(each) + r;
        end
    end
    for N=Nrange
        disp(N);
        y = y_full(1:N);
        f = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y, t));
        value = integral(f, epsilon, pi,'ArrayValued',true);
        values(count) = value;
        count=count+1;
    end
    figure(1);
    hold on;
    plot(Nrange, values, 'DisplayName', '2tothe(1+n^3)');
    legend('show');
    value_at = value_at+1;
    
end
function result = func_sum(y, t)
    result = 1;
    for each=y
        result = result + (sin((each+.5).*t))./(sin(.5.*t));
    end
end
