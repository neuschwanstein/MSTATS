S0=100;
T=1;
mu=0.3;
r=0.02;
K=100;
sigma=0.2;
n=252;
N=10000;
put = 1;

gammaVariance = false;

if ~gammaVariance
    S = generateBSPrices(S0,mu,sigma,T,n,N);
else
    S = generateGammaPrices(S0,mu,sigma,T,n,N);
end

putValue = exp(-r*T)*max(K-S(end,:)',0);

deltaPutValue = hedging(S,K,r,T,mu,sigma,put);
optPutValue = optHedging(S,K,r,T,mu,sigma,put,gammaVariance);

[yDelta,xDelta] = ksdensity(putValue-deltaPutValue);
[yOpt,xOpt] = ksdensity(putValue-optPutValue);

hold on
plot(xDelta,yDelta);
plot(xOpt,yOpt);
legend('Delta-Hedging','Optimal Hedging')
