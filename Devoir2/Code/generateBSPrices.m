function S = generateBSPrices(S0,mu,sigma,T,n,N)
% T: length of the observation
% n: number of observations
% N: number of trajectories

h = T/n;
mean = h*(mu - sigma^2/2);
vol = sqrt(h)*sigma;
X = normrnd(mean,vol,n,N);
X = [zeros(1,N); X];
S = S0*exp(cumsum(X));
end