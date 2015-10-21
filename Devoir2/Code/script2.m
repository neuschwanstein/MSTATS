S0=100;
T=1;
mu=0.3;
r=0.02;
K=100;
sigma=0.2;
n=252;
N=10000;
put = true;

putValue = exp(-r*T)*max(K-S(end,:)',0);

R = log(S(2:end,:)./S(1:end-1,:)) - r;
minS = 0.9*min(S(:,1));
maxS = 1.1*max(S(:,1));
m = 2000;
[~,optPutValue,~,~] = Hedging_IID_MC2012(R(:,1),T,K,r,n,put,minS,maxS,m);
optPutValue = optPutValue(1,:)';

x = linspace(minS,maxS,m);
plot(x,optPutValue);
