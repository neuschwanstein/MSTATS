S0=100;
T=1;
mu=0.0918;
r=0.05;
K=100;
sigma=0.06;
n=22;
N=10000;
put = 0;

gammaVariance = false;

if ~gammaVariance
    S = generateBSPrices(S0,mu,sigma,T,n,N);
else
    S = generateGammaPrices(S0,mu,sigma,T,n,N);
end

if ~put
    payoff = exp(-r*T)*max(S(end,:)'-K,0);
else
	payoff = exp(-r*T)*max(K-S(end,:)',0);
end

deltaPutValue = hedging(S,K,r,T,mu,sigma,put);
% optPutValue = optHedging(S,K,r,T,mu,sigma,put,gammaVariance);

[yDelta,xDelta] = ksdensity(deltaPutValue - payoff);
% [yOpt,xOpt] = ksdensity(putValue-optPutValue);

hold on
plot(xDelta,yDelta);
% plot(xOpt,yOpt);
% legend('Delta-Hedging','Optimal Hedging')
