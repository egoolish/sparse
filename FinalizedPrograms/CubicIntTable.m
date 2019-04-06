epsilonrange_1 = 0.05:0.005:0.1; 
epsilonrange_2 = 0.2:0.1:1;
epsilonrange = horzcat(epsilonrange_1, epsilonrange_2);
Nrange = 1:55;
vector = zeros(1, length(Nrange));
randvector = zeros(1, length(Nrange));
m=1;

a_values = zeros(length(epsilonrange), 1);
arand_values = zeros(length(epsilonrange), 1);
e_values = zeros(length(epsilonrange), 1);
y_full = zeros(1, max(Nrange));
y_fullrand = zeros(1, max(Nrange));

for each=1:Nrange(end)
    y_full(each) = each.^3;
end

y_fullrand(1) = 1;
y_fullrand(end) = y_full(end);
for each=2:max(Nrange)-1
    y_fullrand(each) = randi([y_full(each-1) y_full(each+1)]);
end

value_at = 1;
fig1 = figure(1);
    xlabel('Log N');
    ylabel('Log I_N(\epsilon)');
    title('Cubic Deterministic');
    hold on;
    legend on;
fig2 = figure(2);
    xlabel('Log N');
    ylabel('Log I_N(\epsilon)');
    title('Cubic Random');
    hold on;
    legend on;
for epsilon=epsilonrange
    count = 1;
    for N=Nrange
        disp(epsilon);
        disp(N);
        y = [0, y_full(1:N)];
        yrand = [0, y_fullrand(1:N)];
        f = @(t)abs(Qn(y, N, t));
        f2 = @(t)abs(Qn(yrand, N, t));
        vector(count) = quadgk(f, epsilon, pi, 'MaxIntervalCount', 10000000);
        randvector(count) = quadgk(f2, epsilon, pi, 'MaxIntervalCount', 10000000);
        count=count+1;
    end   
    logNrange = log(Nrange);
    logVector = log(vector);
    lograndVector = log(randvector);
    poly = polyfit(logNrange(int64(3*end/5):end), logVector(int64(3*end/5):end), 1);
    randpoly = polyfit(logNrange(int64(3*end/5):end), lograndVector(int64(3*end/5):end), 1);
    a_values(value_at) = -1*poly(1);
    arand_values(value_at) = -1*randpoly(1);
    e_values(value_at) = epsilon; 
    
    
    figure(1);
    plot(logNrange, logVector, 'DisplayName', ['Eps = ', num2str(epsilon)]);
    figure(2);
    plot(logNrange, lograndVector, 'DisplayName', ['Eps = ', num2str(epsilon)]);
    
    value_at = value_at+1;
end

f = figure;
t = uitable(f);
d = [e_values, a_values, arand_values];
t.Data = d;
t.ColumnName = {'Epsilon', 'Determ: alpha', 'Rand: alpha'};
txt_title = uicontrol('Style', 'text', 'String', ['N^3 for N=', num2str(max(Nrange))]);
    
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
