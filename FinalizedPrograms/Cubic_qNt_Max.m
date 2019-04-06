interval = 1000000;
Nrange = 125:125:1000;
m=1;

t = linspace(75, 400, interval);
tresults = zeros(length(Nrange)+1, length(t));
y_full = zeros(0, Nrange(end));

for each=1:Nrange(end)
    y_full(each) = each.^3;
end

count = 1;
for each = t
    disp(count);
    results = zeros(0, length(Nrange));
    count2 = 1;
    for N=Nrange
        y = [0, y_full(1:N)];
        if (each > (pi*N*N*N))
            results(count2) = NaN;
        else
            results(count2) = abs(cubic_qn(N, each, y));
        end
        tresults(count2,count) = results(count2);
        count2 = count2+1;
    end
    tresults(length(Nrange)+1,count) = max(results);
    count = count + 1;
end

% h = figure(1);
% hold on;
% for i = 1:length(Nrange)
%    plot(t, tresults(i,:), 'DisplayName', ['N=', num2str(125+125*(i-1))]);
% end
% xlabel('Maximized Abs N^3');
% title('N=125:25:1000');

g = figure(2);
plot(t, tresults(length(Nrange)+1,:), 'DisplayName', 'Maximizer');
xlabel('Maximized Abs N^3');

a = polyfit(log(t(1000:end)), log(tresults(length(Nrange)+1,1000:end)), 1);
figure(3);
plot(log(t(10000:end-10)), log(tresults(length(Nrange)+1,10000:end-10)));
xlabel(['Maximized Log-Log N^3 End, a=', num2str(a(1)), ' b=', num2str(a(2))]);

function result=Qn(y, N, t)
    result = (1./(2.*pi)).*(1./(N+1)).*func_sum(y, t);
end

function result=cubic_qn(N, s, y)
    result = ((4*pi)/(N^3+N^2+2)).*(Qn(y, N, (s/(N^3))));
end

function result = func_sum(y, t)
    result = 0;
    for each=y
        if(t == 0) result = result + (2*each+1);
        else result = result + (sin((each+.5).*t))./(sin(.5.*t));
        end
    end
end
