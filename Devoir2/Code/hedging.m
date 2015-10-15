function V = hedging(S,K,r,T,mu,sigma,put)
n = length(S);
beta = exp(-r*linspace(0,T,n));
S = beta.*S;
Delta = S(2:end) - S(1:end-1);
T = linspace(T,0,n);
phi = blsdelta(S(1:end-1),K,r,T(1:end-1),sigma);
V0 = blsprice(S(1),K,r,T(1),sigma);

V = V0' + phi'*Delta;
V = V(put + 1);                 % Illegal hack !!
end