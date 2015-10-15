function V = hedging(S,K,r,T,mu,sigma,put)
n = length(S);                  % S: nxd
beta = diag(exp(-r*linspace(0,T,n))); % beta: nxn
S = beta*S;                     % Discounted prices.
Delta = S(2:end,:) - S(1:end-1,:);
T = linspace(T,0,n)';
[phiCall, phiPut] = blsdelta(S(1:end-1,:),K,r,T(1:end-1,:),sigma);
[V0Call, V0Put] = blsprice(S(1),K,r,T(1),sigma);

if ~put
    V = V0Call + diag(phiCall'*Delta);
else
    V = V0Put + diag(phiPut'*Delta);
end
end