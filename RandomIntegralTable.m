epsilonrange_1 = 0.05:0.005:0.1; 
epsilonrange_2 = 0.1:0.1:1;
epsilonrange = horzcat(epsilonrange_1, epsilonrange_2);
prange = 3:5;
Nrange = 1:300;
vector = zeros(1, length(Nrange));
count = 1;
m=1;
for p=prange
    a_values = zeros(length(epsilonrange), 1);
    b_values = zeros(length(epsilonrange), 1);
    e_values = zeros(length(epsilonrange), 1);
    y_full = zeros(0, length(Nrange));
    for each=2:length(Nrange)+1
        r = rand;
        if(r<(1/3))
            y_full(each)=(each-1)*p-1;
        elseif(r>=(1/3) && (r<2/3))
            y_full(each)=(each-1)*p+1;
        else
            y_full(each)=(each-1)*p;
        end
    end
    value_at = 1;
    for epsilon=epsilonrange
        count = 1;
        for N=Nrange
            disp(N);

           y = y_full(1:N);
           f = @(t)abs((1./(N+1)).*(1/(2*pi)).*func_sum(y, t));%sum((sin((y+.5).*t))./(sin(.5.*t))));
           value = integral(f, epsilon, pi,'ArrayValued',true);
           vector(count) = value;
           count=count+1;
        end
        logNrange = log(Nrange);
        logVector = log(vector);
        %disp(["Epsilon = ," num2str(epsilon), " , p= ", num2str(p)]);
        %disp(polyfit(logNrange, logVector, 1));
        %disp(polyfit(logNrange(int64(8*end/10):end), logVector(int64(8*end/10):end), 1));
        poly = polyfit(logNrange(int64(4*end/5):end), logVector(int64(4*end/5):end), 1);
        a_values(value_at) = poly(1);
        b_values(value_at) = poly(2);
        e_values(value_at) = epsilon;
        value_at = value_at+1;
        
    end
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
    dlmwrite(['P=', num2str(p), 'RandomValuesN=200.txt'],y_full,'delimiter','\t');
    
%     figure(m);
%     m=m+1;
%     loglog(Nrange, vector);
%     xlabel(['LOG N vs LOG Integral p=', num2str(p), ' e=',num2str(epsilon)]);
%     print(['LOG_N_vs_LOG_Integral_p=', num2str(p), '_e=',num2str(epsilon)],'-dpdf');
%     
%     figure(m);
%     m=m+1;
%     plot(Nrange, vector);
%     xlabel(['N vs Integral p=', num2str(p), ' e=',num2str(epsilon)]);
%     print(['N_vs_Integral_p=', num2str(p), '_e=',num2str(epsilon)],'-dpdf');
end



function result = func_sum(y, t)
    result = 0;
    for each=y
        result = result + (sin((each+.5).*t))./(sin(.5.*t));
    end
end
    