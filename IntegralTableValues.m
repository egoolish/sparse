epsilonrange_1 = 0.05:0.005:0.1; 
epsilonrange_2 = 0.1:0.1:1;
epsilonrange = horzcat(epsilonrange_1, epsilonrange_2);
prange = 5;
Nrange = 1:1000;
vector = zeros(1, length(Nrange));
count = 1;
for p=prange
    a_values = zeros(length(epsilonrange), 1);
    b_values = zeros(length(epsilonrange), 1);
    e_values = zeros(length(epsilonrange), 1);
 
    
    value_at = 1;
    figure(1);
    title(['P = ', num2str(p)]);
    xlabel('log N');
    ylabel('log integral from epsilon to pi');
    for epsilon=epsilonrange
        count = 1;
        for N=Nrange
           disp(N);
           f = @(t)abs((1./(2.*pi)).*(1./(N+1)).*Qn(p, N, t));
           value = integral(f, epsilon, pi);
           vector(count) = double(value);
           count=count+1;
        end
        logNrange = log(Nrange);
        logVector = log(vector);
        figure(1);
        hold on;
        plot(logNrange, logVector, 'DisplayName', ['Eps = ', num2str(epsilon)]);
        legend('show');
        %disp(["Epsilon = ," num2str(epsilon), " , p= ", num2str(p)]);
        %disp(polyfit(logNrange, logVector, 1));
        %disp(polyfit(logNrange(int64(8*end/10):end), logVector(int64(8*end/10):end), 1));
        poly = polyfit(logNrange(int64(4*end/5):end), logVector(int64(4*end/5):end), 1);
        a_values(value_at) = poly(1);
        b_values(value_at) = poly(2);
        e_values(value_at) = epsilon;
        value_at = value_at+1;
    end
    figure(1);
    print('-f1', ['P=', num2str(p), 'ConcurrentLogLogGraph'], '-dpdf', '-fillpage')
    f = figure;
    t = uitable(f);
    d = [e_values, a_values,b_values];
    t.Data = d;
    t.Position = [20 20 400 400];
    t.ColumnName = {'Epsilon', 'a_value', 'b_value'};
    txt_title = uicontrol('Style', 'text', 'Position', [20 0 200 20], 'String', ['P=', num2str(p)]);
    f2 = figure;
    plot(e_values, a_values, 'DisplayName', 'a values');
    hold on;
    plot(e_values, b_values, 'DisplayName', 'b values');
    xlabel(['P = ', num2str(p)]);
    legend('show');
    %     f2 = figure;
%     plot(e_values, b_values);
%     f3 = figure;
%     logb = log(b_values);
%     loge = log(e_values);
%     plot(loge, logb);
%     bestfit = polyfit(loge, logb, 1);
%     disp(bestfit);
%     bestfit2 = polyfit(loge(int64(4*end/5):end), logb(int64(4*end/5):end), 1);
%     disp(bestfit2);
    %writetable(t,['P=', num2str(p), '_table.txt'],'WriteRowNames',true);
        %     figure(m);
    %     m=m+1;

%          loglog(Nrange, vector);
%         xlabel(['LOG N vs LOG Integral p=', num2str(p), ' e=',num2str(epsilon)]);
%         print(['LOG_N_vs_LOG_Integral_p=', num2str(p), '_e=',num2str(epsilon)],'-dpdf');
% 
%         figure(m);
%         m=m+1;
%         plot(Nrange, vector);
%         xlabel(['N vs Integral p=', num2str(p), ' e=',num2str(epsilon)]);
%         print(['N_vs_Integral_p=', num2str(p), '_e=',num2str(epsilon)],'-dpdf');
% 
%         dlmwrite(['integral_p=',num2str(p), '_e=',num2str(epsilon),'.txt'],vector, '\n');
end

function result=Qn(p, N, t)
    num = sin(((((p./2).*N)+0.5).*t)) .* sin((p./2).*(N+1).*t);
    den = sin(t./2) .* sin((p./2).*t);
    result = num./den;
end