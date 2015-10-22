function V = optHedging(S,K,r,T,mu,sigma,put,gamma)
m = 2000;
[n,N] = size(S);
h = T/n;
beta = diag(exp(-r*linspace(0,T,n)));
S = beta*S;  
Delta = S(2:end,:) - S(1:end-1,:);

nTraining = 100;
if ~gamma
    % BMS 
    mean = h*(mu - r - sigma^2/2);
    vol = sqrt(h)*sigma;
    R = normrnd(mean,vol,nTraining,1);
else
    % Variance Gamma returns
    mean = h*(mu - r - sigma^2/2);
    V = gamrnd(h,1,nTraining,1);
    Z = normrnd(0,1,nTraining,1);
    G = sqrt(V).*Z;
    R = mean + sigma*G;
end

minS = min(min(S));
maxS = max(max(S));
[~,C,a,c1,~] = Hedging_IID_MC2012(R,T,K,r,n,put,minS,maxS,m);

V = zeros(N,1);
V0 = interpolation_1d(S(1,1),C(1,:)',minS,maxS);
    
for i=1:N
    pi = V0;
    
    for k=1:n-1
        ak = interpolation_1d(S(k,i),a(k,:)',minS,maxS);
        phi = (ak - c1*pi)/S(k,i);
        pi = pi + phi*Delta(k,i);
    end
    
    V(i) = pi;
end
end