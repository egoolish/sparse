divider = 10000000;
t = linspace(.5,pi,divider);
q=0;
k = [1:100];
q=0;
maxarr = zeros(1,100);
for N = k
    x = [0:N];
    y = zeros(1,N+1);
    var = 1;
        while var < N+2;
            a = rand;
            r = floor((4*a*(var-1))+1);
            if var == 1 
                y(var) = 0;
            else
                y(var) = y(var) + (y(var-1)+r);
            end
        var = var + 1;
        end
    for j = y
        q = q + (sin((j+.5).*t))./(sin(.5.*t));
    end
    b = (1./(N+1)).*q;
    m = max(b);
    maxarr(N) = maxarr(N) + m; 
    q = 0;
end
plot(k,maxarr)
h=figure(1);
% saveas(h,['random tails max values', '.pdf']);

% q=0;
% for j = y
%     z = [1:j];
%    for k = z
%        p = p + cos(k.*t);
%    end
%     p = (2.*p);
%     p = p+1;
%     q = q + p;
%     p=0;
% end
% b= q./(N+1);
% plot(t,b);