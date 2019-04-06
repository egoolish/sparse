interval = 10000000;
Nrange = 1:5;                    %What values of N we are testing
prange = 5;                       %What values of p we are testing
m=1;                                %Counter Variable
for p=prange
    figure(m)
    for N=Nrange
        disp(N);
        %t = linspace(-sqrt(N),sqrt(N),interval);
        t = linspace(-20.*pi,20.*pi,interval);
        results = zeros(size(t));
        results2 = zeros(size(t));
        count = 1;
        for each=t
           results(count) = linearqn(p, N, each);
           %results2(count) = ((sin(p.*each)./(p.*each))).^2;
           count = count+1;
        end
%         figure(m);
        plot(t, results, 'DisplayName', ['qn(s) for N= ', num2str(N)]);
        hold on;
        %plot(t, results2, 'DisplayName', '(sin(ps)/ps)^2');
        xlabel(['concurrent qn for p = ', num2str(p)]);
        %xlabel(['qn vs sin(ps)/ps for N = ', num2str(N), ' p = ', num2str(p)]);
        legend('show');
%         print(figure(m), '-dpdf', ['ConcurrentforN=', num2str(N), 'p=', num2str(p), '.pdf']);
%         m = m+1;
%         figure(m);
%         plot(t, results2 - results);
%         xlabel(['sin(ps)/ps - qn(s) for N = ', num2str(N), ' p = ', num2str(p)]);
%         print(figure(m), '-dpdf', ['DifferenceforN=', num2str(N), 'p=', num2str(p), '.pdf']);
%         m = m+1;
    end
    h = figure(m);
    set(h,'PaperOrientation','landscape');
    set(h,'PaperUnits','normalized');
    set(h,'PaperPosition', [0 0 1 1]);
    %print(h, '-dpdf', ['Concurrentp=', num2str(p), '.pdf']);
    m = m+1;
end
%close all;
% function result=LinearQn(p, N, t)
%     result = (1./(2.*pi)).*((N.*p)+1);
% end
function result=Qn(p, N, t)
    num = sin(((((p./2).*N)+0.5).*t)) .* sin((p./2).*(N+1).*t);
    den = sin(t./2) .* sin((p./2).*t);
    result = (1./(2.*pi)).*(1./(N+1)).*(num./den);
end

function result=linearqn(p, N, s)
    result = ((2.*pi)./(N.*p+1)).*(Qn(p, N, (2.*s)./(N+1)));
end

