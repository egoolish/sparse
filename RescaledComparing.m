interval = 10000000;
Nrange = 25:50:125;                    %What values of N we are testing
prange = 2:5;                       %What values of p we are testing
m=1;                                %Counter Variable
for p=prange
    figure(m)
    y_full = zeros(0, Nrange(end));
    for each=1:Nrange(end)
        r = rand;
        if(r<(1/3))
            y_full(each)=p*each-1;
        elseif(r>=(1/3) && (r<2/3))
            y_full(each)=p*each+1;
        else
            y_full(each)=each*p;
        end
    end
    for N=Nrange
        disp(N);
        figure(m);
        t = linspace(1,0.9*pi,interval);
        results = zeros(size(t));
        results2 = zeros(size(t));
        y = y_full(1:N);
        count = 1;
        for each=t
           results(count) = Qn(p, N, each);
           results2(count) = randQn(y, N, each);
           count = count+1;
        end
%         figure(m);
        plot(t, results, 'DisplayName', ['Linear N= ', num2str(N)]);
        hold on;
        plot(t, results2, 'DisplayName', ['RandLinear N= ', num2str(N)]);
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
    h = figure(m);
    set(h,'PaperOrientation','landscape');
    set(h,'PaperUnits','normalized');
    set(h,'PaperPosition', [0 0 1 1]);
    print(h, '-dpdf', ['PartialP=', num2str(p), 'RandomValuesN=', num2str(N), '.pdf']);
    dlmwrite(['PartialP=', num2str(p), 'RandomValuesN=', num2str(N), '.txt'],y_full,'delimiter','\t');
    m = m+1;
    end
    
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


function result=randomlinearqn(N, s, y, p)
    result = ((2.*pi)./(N.*p+1)).*(randQn(y, N, ((2.*s)./(N+1))));
end

function result=randQn(y, N, t)
    result = (1./(2.*pi)).*(1./(N+1)).*func_sum(y, t);
end


function result = func_sum(y, t)
    result = 0;
    for each=y
        result = result + (sin((each+.5).*t))./(sin(.5.*t));
    end
end