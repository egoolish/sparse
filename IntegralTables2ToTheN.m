epsilonrange_1 = 0.05:0.005:0.1; 
epsilonrange_2 = 0.2:0.1:1;
epsilonrange = horzcat(epsilonrange_1, epsilonrange_2);
Nrange = 1:15;
vector = zeros(1, length(Nrange));
m=1;

a_values = zeros(length(epsilonrange), 1);
b_values = zeros(length(epsilonrange), 1);
e_values = zeros(length(epsilonrange), 1);
y_full = zeros(0, length(Nrange));

for each=1:length(Nrange)
    y_full(each) = 2^each;
end

value_at = 1;

for epsilon=epsilonrange
    count = 1;
    for N=Nrange
        disp(N);
        y = y_full(1:N);
        f = @(t)abs(Qn(y, N, t));
        value = integral(f, epsilon, pi,'ArrayValued',true);
        vector(count) = value;
        count=count+1;
    end   
    logNrange = log(Nrange);
    logVector = log(vector);
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
txt_title = uicontrol('Style', 'text', 'Position', [20 0 200 20], 'String', ['2^N for N=', num2str(max(Nrange))]);
f2 = figure;
plot(e_values, a_values, 'DisplayName', 'a values');
hold on;
plot(e_values, b_values, 'DisplayName', 'b values');
xlabel(['2^n for N = ', num2str(max(Nrange))]);
legend('show');


function result=Qn(y, N, t)
    result = (1./(2.*pi)).*(1./(N+1)).*func_sum(y, t);
end

function result = func_sum(y, t)
    result = 1;
    for each=y
        result = result + (sin((each+.5).*t))./(sin(.5.*t));
    end
end
    