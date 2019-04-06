divider = 10000000;
q=0;
s=0;
zoom = (divider/2);
k=[4:4:100];
m = 1;
for N=k
    t = linspace(-((16)*pi),((16)*pi),divider);
    x = [0:N];
    y = x.^3;
    for j = y
        q = q + (sin((j+.5).*(t.*(1/(N^3)))))./(sin(.5.*(t.*(1/(N^3)))));
    end
    b = (1./(N+1)).*q;
    s=(1/2)*(N^3);
    b=b./s;
% b = abs(b);
%     zoomfixm = (zoom-(3500000/(2^m)));
%     zoomfixp = (zoom+(3500000/(2^m)));
    h = figure(m);
    plot(t,b)
%     plot(t(zoomfixm:zoomfixp),b(zoomfixm:zoomfixp));
    xlabel(['n^3 scaled, t from -16pi to 16pi N=', num2str(((m*4)))])
    saveas(h,['n^3 scaled, t from -16pi to 16pi N=',num2str(((m*4))), '.pdf']);
    m = m+1;
    q=0;
    s=0;
end