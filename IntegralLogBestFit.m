epsilonrange = [0, 0.5, 1, 2];
p = 4;
Nrange = 5:1000;
vector = zeros(1, length(Nrange));
count = 1;
m=1;
for epsilon=epsilonrange
    count = 1;
    for N=Nrange
       f = @(t)abs(1/(N+1).*1/(2*pi).*sin(((((p./2).*N)+0.5).*t)) .* sin((p./2).*(N+1).*t)./sin(t./2) .* sin((p./2).*t));
       value = integral(f, epsilon, pi);
       vector(count) = value;
       count=count+1;
    end
    logNrange = log(Nrange);
    logVector = log(vector);
    disp(["Epsilon = ," num2str(epsilon), " , p= ", num2str(p)]);
    disp(polyfit(logNrange, logVector, 1));
    f=figure;
    t=uitable(f);
    T = table('P', 'Epsilon', 'a', 'b');
    t.ColumnEditable = true;
    
%     figure(m);
%     m=m+1;
%     
%     loglog(Nrange, vector);
%     xlabel(['LOG N vs LOG Integral p=', num2str(p), ' e=',num2str(epsilon)]);
%     print(['LOG_N_vs_LOG_Integral_p=', num2str(p), '_e=',num2str(epsilon)],'-dpdf');
%     
%     figure(m);
%     m=m+1;
%     plot(Nrange, vector);
%     xlabel(['N vs Integral p=', num2str(p), ' e=',num2str(epsilon)]);
%     print(['N_vs_Integral_p=', num2str(p), '_e=',num2str(epsilon)],'-dpdf');
%     
%     dlmwrite(['integral_p=',num2str(p), '_e=',num2str(epsilon),'.txt'],vector, '\n');
end



