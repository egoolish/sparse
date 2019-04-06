interval = 10000;
Nrange = 125:125:1000;%:25:125;                    %What values of N we are testing
prange = 2;                       %What values of p we are testing
m=1;                                %Counter Variable
n=1;
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
        disp(N);
        y = y_full(1:N);
        range = 2^N.*pi;
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
        for m = n:length(Nrange)
            figure(m);
            plot(t, results, 'DisplayName', ['qn(s) N=', num2str(N)]);
            xlim([125 5000])
            hold on;
            xlabel(['concurrent quad qn']);
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
     print(h, '-dpdf', ['QuadTail', num2str(m), '.pdf']);
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
    result = 3;
    for each=y
        result = result + (sin((each+.5).*t))./(sin(.5.*t));
    end
end
