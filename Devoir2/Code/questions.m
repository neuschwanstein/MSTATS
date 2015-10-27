%% Results helper functions.
gammaOptResults = containers.Map('KeyType','double','ValueType','any');
gammaDeltaResults = containers.Map('KeyType','double','ValueType','any');

%% Question 2.
r=0.02;
Ks = [95,100,105];
S0=100;
T=1;
mu=0.5;
sigma=0.2;
ns=[5,21,63,252];
put = 1;
N = 10000;

gammaVariance = true;
for n=ns 
    interOptResults = containers.Map('KeyType','double','ValueType','any');
    interDeltaResults = containers.Map('KeyType','double','ValueType','any');
    
    for K=Ks     
        S = generateBSPrices(S0,mu,sigma,T,n,N);
        putPayoff = exp(-r*T)*max(K-S(end,:)',0);
        
        deltaPutValue = hedging(S,K,r,T,mu,sigma,put);
        optPutValue = optHedging(S,K,r,T,mu,sigma,put,gammaVariance);

        interOptResults(K) = optPutValue - putPayoff;   % Bank position: what I have gained - what I owe you.
        interDeltaResults(K) = deltaPutValue - putPayoff;
    end
    
    gammaOptResults(n) = interOptResults;
    gammaDeltaResults(n) = interDeltaResults;
end

