interval = 1000000;
Nrange = 125:25:1000;%:25:125;                    %What values of N we are testing
m=1;                                %Counter Variable
%range = N*N*pi;
t = linspace(0, 125, interval);
tresults = zeros(length(Nrange)+1, length(t));
y_full = zeros(0, Nrange(end));
for each=1:Nrange(end)
    y_full(each) = 2^each;
end

count = 1;
for each = t
    disp(count);
    results = zeros(0, length(Nrange));
    count2 = 1;
    for N=Nrange
        y = y_full(1:N);
        if (each > (pi*(2^(N+2))/(N+1)))
            results(count2) = NaN;
            
        else
            results(count2) = abs(linearqn(N, each, y));
            %results(count2) = linearqn(N, each, y);
        end
        tresults(count2,count) = results(count2);
        count2 = count2+1;
    end
    tresults(length(Nrange)+1,count) = max(results);
    count = count + 1;
end
h = figure(1);
hold on;
for i = 1:length(Nrange)
   plot(t, tresults(i,:), 'DisplayName', ['N=', num2str(125+125*(i-1))]);
end
%plot(t, tresults(length(Nrange)+1,:), 'DisplayName', 'Maximizer');
xlabel('Maximized Abs 2^N');
title('N=125:25:1000');
%legend('show');
set(h,'PaperOrientation','landscape');
set(h,'PaperUnits','normalized');
set(h,'PaperPosition', [0 0 1 1]);

g = figure(2);
plot(t, tresults(length(Nrange)+1,:), 'DisplayName', 'Maximizer');
xlabel('Maximized Abs 2^N');
set(g,'PaperOrientation','landscape');
set(g,'PaperUnits','normalized');
set(g,'PaperPosition', [0 0 1 1]);

gg = figure(3);
plot(log(t), log(tresults(length(Nrange)+1,:)), 'DisplayName', 'Maximizer');
xlabel('Log Abs Maximized 2^N');
set(gg,'PaperOrientation','landscape');
set(gg,'PaperUnits','normalized');
set(gg,'PaperPosition', [0 0 1 1]);

a = polyfit(log(t(1000:end)), log(tresults(length(Nrange)+1,1000:end)), 1);
figure(8);
plot(log(t(10000:end-10)), log(tresults(length(Nrange)+1,10000:end-10)));
xlabel(['Maximized Log-Log 2^N End, a=', num2str(a(1)), ' b=', num2str(a(2))]);

function result=Qn(y, N, t)
    result = (1./(2.*pi)).*(1./(N+1)).*func_sum(y, t);
end

function result=linearqn(N, s, y)
    %result = ((4*pi)/(N^3+N^2+2)).*(Qn(y, N, (s/(N^3)))); %Cubic
    %result = ((6*pi)/(2*N*N+N+3)).*(Qn(y, N, (s/(N^2)))); %Quad
    result = (((2*pi)*(N+1))/(2^(N+2)+N-1)).*(Qn(y, N, (s*(N+1))/(2^(N+2)))); %2^N 
   
end

function result = func_sum(y, t)
    result = 1;
    for each=y
        result = result + (sin((each+.5).*t))./(sin(.5.*t));
    end
end
