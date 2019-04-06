interval = 1000000;
Nrange = 125:125:1000;%:25:125;                    %What values of N we are testing
prange = 2;                       %What values of p we are testing
m=1;                                %Counter Variable
n=1;
c = 'r';
for p=prange
    %figure(m)
    y_full = zeros(0, max(Nrange));%Nrange(end));
    for each=1:max(Nrange)%Nrange(end)
        y_full(each) = 2^each;
%         r = rand;
%         if(r<(1/3))
%             y_full(each)=(each-1)*p-1;
%         elseif(r>=(1/3) && (r<2/3))
%             y_full(each)=(each-1)*p+1;
%         else
%             y_full(each)=(each-1)*p;
%         end
    end
    for N=Nrange
        if(rem(n, 8) == 1) c = [0.6350, 0.0780, 0.1840];
        elseif (rem(n, 8) == 2) c = [0.8500, 0.3250, 0.0980]	;
        elseif (rem(n, 8) == 3) c = [0.9290, 0.6940, 0.1250]	;
        elseif (rem(n, 8) == 4) c = [0.4660, 0.6740, 0.1880];
        elseif (rem(n, 8) == 5) c = [0.3010, 0.7450, 0.9330]
        elseif (rem(n, 8) == 0) c = [0.75, 0, 0.75]
        elseif (rem(n, 8) == 6) c = [0, 0.4470, 0.7410];
        elseif (rem(n, 8) == 7) c = [0.4940, 0.1840, 0.5560];
        end
        disp(N);
        y = y_full(1:N);
        range = 5000;
%         if (N == 500) t = linspace(250,range,interval); 
%         else t = linspace(250,392699100,interval); end
        t = linspace(0,range,interval);
        results = zeros(size(t));
        results2 = zeros(size(t));
        count = 1;
        for each=t
           disp(count);
           results(count) = linearqn(N, each, y);
           count = count+1;
        end
        for m = 1:n
            figure(m);
            plot(t, results, 'DisplayName', ['qn(s) N=', num2str(N)], 'Color', c);
            xlim([125 5000])
            ylim([-4E-4 10E-4])
            %ylim([-2e-4 14e-4])
            hold on;
            xlabel(['concurrent 2totheN qn']);
            legend('show');
        end 
%         figure(m);
%         plot(t, results, 'DisplayName', ['qn(s) N=', num2str(N)]);
%         %plot(t, results, 'DisplayName', 'qn(s)');
%         hold on;
%         %plot(t, results2, 'DisplayName', '(sin(ps)/ps)^2');
%         xlabel(['concurrent cubic qn']);
%         %xlabel(['2totheN qn vs sin(ps)/ps for N = ', num2str(N)]);
%         legend('show');
         %print(figure(m), '-dpdf', ['2totheNCompareforN=', num2str(N), '.pdf']);
         %m = m+1;
         %figure(m);
%          plot(t, results2 - results);
%          xlabel(['2totheN sin(ps)/ps - qn(s) for N = ', num2str(N)]);
%          print(figure(m), '-dpdf', ['2totheNDifferenceforN=', num2str(N), '.pdf']);
          %m = m+1;
          n=n+1;
    end
%     h = figure(m);
%     set(h,'PaperOrientation','landscape');
%     set(h,'PaperUnits','normalized');
%     set(h,'PaperPosition', [0 0 1 1]);
%     %print(h, '-dpdf', ['CubicConcurrent', num2str(Nrange), '.pdf']);
%     m = m+1;
    %f = fit(t, results, 'smoothingspline');
    %disp(f);
end
for m = 1:8
    h = figure(m);
     set(h,'PaperOrientation','landscape');
     set(h,'PaperUnits','normalized');
     set(h,'PaperPosition', [0 0 1 1]);
     print(h, '-dpdf', ['2nTail', num2str(m), '.pdf']);
end
% close all;

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
