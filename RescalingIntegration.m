% w = warning('query','last');
% id = w.identifier;
% warning('off',id);

interval = 100000;
Nrange = 1000;
m=1;
n=2;

y_full = zeros(0, Nrange(end));
for each=1:Nrange(end)
    y_full(each) = each^2;
end
for N=Nrange
    disp(N);
    y = y_full(1:N);
    range = pi;
    t = linspace(-range,range,interval);
    results = zeros(size(t));
    results2 = zeros(size(t));
    results3 = zeros(size(t));
    count = 1;
    for each=t
        disp(count);
        results(count) = Qn(y, N, each);
        results2(count) = Qtilden(N, each);
        results3(count) = results(count) - results2(count);
        count = count+1;
    end
    figure(m);
    plot(t, results2, 'DisplayName', ['Qtilden N=', num2str(N)]);
    xlabel('integration quadratic qn');
    legend('show');
    hold on;
    figure(n);
    plot(t, results3, 'DisplayName', ['Qn - Qtilden N=', num2str(N)]);
    xlabel('integration quadratic qn');
    legend('show');
    hold on;
    figure(3);
    plot(t, results, 'DisplayName', ['Qn N=', num2str(N)]);
    xlabel('integration quadratic qn');
    legend('show');
    hold on;
end
h = figure(m);
set(h,'PaperOrientation','landscape');
set(h,'PaperUnits','normalized');
set(h,'PaperPosition', [0 0 1 1]);
print(h, '-dpdf', ['QuadIntegralConcurrent', num2str(Nrange), '.pdf']);
% l = figure(n);
% set(l,'PaperOrientation','landscape');
% set(l,'PaperUnits','normalized');
% set(l,'PaperPosition', [0 0 1 1]);
% print(l, '-dpdf', ['QuadIntegralConcurrent', num2str(Nrange), '.pdf']);

function result=Qn(y, N, t)
    result = (1./(2.*pi)).*(1./(N+1)).*func_sum(y, t);
end

function result = func_sum(y, t)
    result = 1;
    for each=y
        result = result + (sin((each+.5).*t))./(sin(.5.*t));
    end
end

function result=linearqn(y, N, s)
    %result = ((4*pi)/(N^3+N^2+2)).*(Qn(y, N, (s/(N^3)))); %Cubic
    result = ((6*pi)/(2*N*N+N+3)).*(Qn(y, N, (s/(N^2)))); %Quad
    %result = ((6*pi)/(2*N*N+N+3)).*(Qtilden(N, (s/(N^2)))); %QuadIntegral
    %result = (((2*pi)*(N+1))/(2^(N+2)+N-1)).*(Qn(y, N, (s*(N+1))/(2^(N+2)))); %2^N 
   
end

function result = Qtilden(N, t)
    f = @(z) sin(z.*t)./(2.*sqrt(z));
    result = 1/(2*pi*N*sin(0.5*t)) * integral(f, 1, N*N);
end
