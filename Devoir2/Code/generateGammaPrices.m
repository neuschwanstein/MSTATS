function S = generateGammaPrices(S0,mu,sigma,T,n,N)
h = T/n;
mean = h*(mu - sigma^2/2);
V = gamrnd(h,1,n,N);
Z = normrnd(0,1,n,N);
G = sqrt(V).*Z;
X = mean + sigma*G;
X = [zeros(1,N); X];
S = S0*exp(cumsum(X));
end