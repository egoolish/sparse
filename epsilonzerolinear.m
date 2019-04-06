prange = 2:5;
Nrange = 0:150;
figure(1);
h=open('random.fig');
handles=findobj(h,'Type','axes');
axes(handles(1));
hold on;
% 
% title('Concurrent Random Linear Epsilon=0');
% xlabel('N');
% ylabel('integral from epsilon to pi');



for p=prange
    y_full = zeros(1, length(Nrange));
    y_full(1) = p;
    for each=2:length(Nrange)+1
%         r = rand;
%         if(r<(1/3))
%             y_full(each)=(each-1)*p-1;
%         elseif(r>=(1/3) && (r<2/3))
%             y_full(each)=(each-1)*p+1;
%         else
%             y_full(each)=(each-1)*p;
%         end
        y_full(each) = each*p;
    end
    disp(y_full);
    count = 1;
    values = zeros(1, length(Nrange));
    for N=Nrange
        disp(N);
        y = y_full(1:N);
        f = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y, t));%sum((sin((y+.5).*t))./(sin(.5.*t))));
        %f = @(t)abs((1./(2.*pi)).*(1./(N+1)).*Qn(p, N, t));
        value = integral(f, 0, pi,'ArrayValued',true);
        values(count) = value;
        count=count+1;
    end
    figure(1);
    hold on;
    plot(Nrange, values, 'DisplayName', ['TrueP=', num2str(p)]);
    legend('show');
end

function result=Qn(p, N, t)
    num = sin(((((p./2).*N)+0.5).*t)) .* sin((p./2).*(N+1).*t);
    den = sin(t./2) .* sin((p./2).*t);
    result = num./den;
end

function result = func_sum(y, t)
    result = 1;
    for each=y
        result = result + (sin((each+.5).*t))./(sin(.5.*t));
    end
end
