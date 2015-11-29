function X = garchSimulation(N,l,a0,a1,b1)

e = normrnd(0,1,N,1);
h = zeros(N,1);
h(1) = a0/(1-a1-b1);

for t=2:N
    h(t) = a0 + a1*h(t-1)*e(t-1)^2 + b1*h(t-1);
end

X = l*sqrt(h) - 0.5*h + sqrt(h).*e;
end