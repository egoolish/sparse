divider = 1000000;
t = linspace(-pi,pi,divider);
q=0;
zoom = (divider/2);
N = 4;
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
p = 0;
for j = y
    q = q + (sin((j+.5).*t))./(sin(.5.*t));
end
b = (1./(N+1)).*q;
% b = abs(b);
zoomfixm = (zoom-(100000/(m^.8)));
zoomfixp = (zoom+(100000/(m^2.8)));
h = figure(m);
plot(t,b)