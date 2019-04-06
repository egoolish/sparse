epsilon = 0;
prange = 1:5;
Nrange = 1:1000;
values = zeros(1, length(Nrange));
y_full = zeros(1, length(Nrange));
for p=prange
    count = 1;
%     for each=2:length(Nrange)+1
%         r = rand;
%         if(r<(1/3))
%             y_full(each)=(each-1)*p-1;
%         elseif(r>=(1/3) && (r<2/3))
%             y_full(each)=(each-1)*p+1;
%         else
%             y_full(each)=(each-1)*p;
%         end
%     end
%     for N=Nrange
%             disp(N);
% 
%            y = y_full(1:N+1);
%            f = @(t)abs((1./(N+1)).*(1/(2*pi)).*sum((sin((y+.5).*t))./(sin(.5.*t))));
%            value = integral(f, epsilon, pi,'ArrayValued',true);
%            values(count) = value;
%            count=count+1;
%     end
    for N=Nrange
        disp(N);
        f = @(t)abs((1./(2.*pi)).*(1./(N+1)).*(sin(((((p./2).*N)+0.5).*t)) .* sin((p./2).*(N+1).*t)./(sin(t./2) .* sin((p./2).*t))));
        %disp(integral(f, 0, pi));
        values(count) = integral(f, 0, pi);
        count = count+1;
    end
    dlmwrite(['EpsilonZero', 'P=', num2str(p), '.txt'], values,'delimiter','\n');
    %dlmwrite(['RandomEZeroValues', 'P=', num2str(p), '.txt'], y_full,'delimiter','\t');
end
