epsilonrange_1 = 0.01:0.01:0.05; 
epsilonrange_2 = 0.2:0.2:1;
epsilonrange = horzcat(epsilonrange_1, 0.1, epsilonrange_2);
Nrange = 1:10;
value_at = 1;

a_values = zeros(length(epsilonrange), 1);
b_values = zeros(length(epsilonrange), 1);
e_values = zeros(length(epsilonrange), 1);
values = zeros(1, length(Nrange));

truensquared = zeros(1, length(Nrange)+1);
truensquared(1) = 2;

nsquared = zeros(1, length(Nrange));
nsquared(1) = 2;
for each=2:length(truensquared)
    truensquared(each) = each.^3;
end

for each=2:length(nsquared)
    nsquared(each) = 2^(1+truensquared(each));
end
figure(1);
title('2tothe(1+k^3)');
xlabel('log N');
ylabel('log integral from epsilon to pi');
    
for epsilon=epsilonrange
    count = 1;
    for N=Nrange
        disp(N);
        y = nsquared(1:N);
        f = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y, t));
        value = integral(f, epsilon, pi,'ArrayValued',true);
        values(count) = value;
        count=count+1;
    end
    logNrange = log(Nrange);
    logVector = log(values);
    figure(1);
    hold on;
    plot(logNrange, logVector, 'DisplayName', ['Eps = ', num2str(epsilon)]);
    legend('show');
    %disp(["Epsilon = ," num2str(epsilon), " , p= ", num2str(p)]);
    %disp(polyfit(logNrange, logVector, 1));
    %disp(polyfit(logNrange(int64(8*end/10):end), logVector(int64(8*end/10):end), 1));
    poly = polyfit(logNrange(int64(4*end/5):end), logVector(int64(4*end/5):end), 1);
    a_values(value_at) = poly(1);
    b_values(value_at) = poly(2);
    e_values(value_at) = epsilon;
    value_at = value_at+1;
    
end
f = figure;
t = uitable(f);
d = [e_values, a_values,b_values];
t.Data = d;
t.Position = [20 20 400 400];
t.ColumnName = {'Epsilon', 'a_value', 'b_value'};
txt_title = uicontrol('Style', 'text', 'Position', [20 0 200 20], 'String', '2tothe(1+k^3)');

f2 = figure;
plot(e_values, a_values, 'DisplayName', 'a values');
hold on;
plot(e_values, b_values, 'DisplayName', 'b values');
xlabel('2tothe(1+k^3)');
legend('show');
dlmwrite('2totheonepluskcubed.txt',nsquared,'delimiter','\t');

f3 = figure;
log_e = log(1./e_values);
poly = polyfit(b_values, log_e, 1);
a_v = poly(1);
b_v = poly(2);
plot(b_values, log_e, 'DisplayName', '2tothe(1+k^3)');
xlabel(['b vs log(1/epsilon) ', 'a=', num2str(a_v), ' b=', num2str(b_v)]);
legend('show');

function result = func_sum(y, t)
    result = 0;
    for each=y
        result = result + (sin((each+.5).*t))./(sin(.5.*t));
    end
end
