function h = estH(h1,a0,a1,b1,T)

h = zeros(T,1);
h(1) = h1;

for t=2:T
    h(t) = a0 + 0.5*a1*h(t-1) + b1*h(t-1);
end
end