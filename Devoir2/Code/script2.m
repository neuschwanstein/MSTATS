S0=100;
T=1;
mu=0.3;
r=0.02;
K=100;
sigma=0.2;
n=252;
N=50000;
put = true;

nExperiments=100;
meanResults = zeros(nExperiments,1);

for i = 1:nExperiments
    S = generatePrices(S0,mu,sigma,T,n,N);
    V = hedging(S,K,r,T,mu,sigma,put);
    putValue = exp(-r*T)*max(K-S(end,:)',0);
    meanResults(i) = mean(putValue-V);
end
% [~,putPrice] = blspricem(S(end,:)',K,r,T,sigma);
% putPrice = exp(-r*T)*putPrice;
% 
% hist(V-putPrice)