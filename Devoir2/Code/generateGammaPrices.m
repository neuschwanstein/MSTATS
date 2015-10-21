function S = generateGammaPrices(S0,mu,sigma,T,n,N)
h = T/n;
mean = h*(mu - sigma^2/2);
vol = sqrt(h)*sigma;
V = gamrnd(h,1,n,N);
Z = normrnd(0,1,n,N);
X = 
end