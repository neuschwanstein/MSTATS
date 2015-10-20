function V = hedging(S,K,r,T,mu,sigma,put)
[n,~] = size(S);                  % S: nxN
beta = diag(exp(-r*linspace(0,T,n))); % beta: nxn
discountS = beta*S;                     % Discounted prices.
Delta = discountS(2:end,:) - discountS(1:end-1,:);
T = linspace(T,0,n)';

[phiCall, phiPut] = blsdeltam(S(1:end-1,:),K,r,T(1:end-1),sigma);
[V0Call, V0Put] = blspricem(S(1),K,r,T(1),sigma);

if ~put
%     V = V0Call + diag(phiCall'*Delta);
    V = V0Call + sum(phiCall.*Delta,1)';
else
%     V = V0Put + diag(phiPut'*Delta);
    V = V0Put + sum(phiPut.*Delta,1)';
end
end