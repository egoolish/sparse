interval = 1000000;
Nrange = 125:5:1000;
m=1;

t = linspace(75, 1000, interval);
tresults = zeros(length(Nrange)+1, length(t));
tresults2 = zeros(length(Nrange)+1, length(t));
y_full = zeros(1, Nrange(end));
y_fullrand = zeros(1, max(Nrange));

for each=1:Nrange(end)
    y_full(each) = each.^2;
end

y_fullrand(1) = 1;
y_fullrand(end) = y_full(end);
for each=2:max(Nrange)-1
    y_fullrand(each) = randi([y_full(each-1) y_full(each+1)]);
end

count = 1;
for each = t
    disp(count);
    results = zeros(1, length(Nrange));
    results2 = zeros(1, length(Nrange));
    count2 = 1;
    for N=Nrange
        y = [0, y_full(1:N)];
        yrand = [0, y_fullrand(1:N)];
        if (each > (pi*N*N))
            results(count2) = NaN;
            results2(count2) = NaN;
        else
            results(count2) = abs(quad_qn(N, each, y));
            results2(count2) = abs(quad_qn(N, each, yrand));
        end
        tresults(count2,count) = results(count2);
        tresults2(count2,count) = results2(count2);
        count2 = count2+1;
    end
    tresults(length(Nrange)+1,count) = max(results);
    tresults2(length(Nrange)+1,count) = max(results2);
    count = count + 1;
end

% h = figure(1);
% hold on;
% for i = 1:length(Nrange)
%    plot(t, tresults(i,:), 'DisplayName', ['N=', num2str(125+125*(i-1))]);
% end
% xlabel('Maximized Abs N^2');
% title('N=125:25:1000');

g = figure(2);
hold on;
plot(t, tresults(length(Nrange)+1,:), 'DisplayName', 'Maximizer');
plot(t, tresults2(length(Nrange)+1,:), 'DisplayName', 'RandMaximizer');
xlabel('Maximized Abs N^2');

a = polyfit(log(t(100000:300000)), log(tresults(length(Nrange)+1,100000:300000)), 1);
b = polyfit(log(t(100000:300000)), log(tresults2(length(Nrange)+1,100000:300000)), 1);
figure(3);
hold on;
plot(log(t(100000:300000)), log(tresults(length(Nrange)+1,100000:300000)));
plot(log(t(100000:300000)), log(tresults2(length(Nrange)+1,100000:300000)));
xlabel(['Maximized Log-Log N^2, a=', num2str(a(1)), ' b=', num2str(a(2))]);
title(['Maximized Log-Log N^2 Rand, a=', num2str(b(1)), ' b=', num2str(b(2))]);

function result=Qn(y, N, t)
    result = (1./(2.*pi)).*(1./(N+1)).*func_sum(y, t);
end

function result=quad_qn(N, s, y)
    result = ((6*pi)/(2*N*N+N+3)).*(Qn(y, N, (s/(N^2))));
end

function result = func_sum(y, t)
    result = 0;
    for each=y
        if(t == 0) result = result + (2*each+1);
        else result = result + (sin((each+.5).*t))./(sin(.5.*t));
        end
    end
end
