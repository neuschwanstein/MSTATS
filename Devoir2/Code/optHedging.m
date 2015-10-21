function V = optHedging(X,K,r,T,mu,sigma,put)
m = 2000;
[n,N] = size(X);
% h = T/n;
beta = diag(exp(-r*linspace(0,T,n)));
X = beta*X;  
Delta = X(2:end,:) - X(1:end-1,:);
R = log(X(2:end,:)./X(1:end-1,:));
% R = log(X(2:end,:)./X(1:end-1,:)) - h*r;

V = zeros(N,1);
for i=1:N
    minS = min(X(:,i));
    maxS = max(X(:,i));
    
    echo off;
    [~,C,a,c1,~] = Hedging_IID_MC2012(R(:,i),T,K,r,n,put,minS,maxS,m);
    echo on;
    fprintf('%d out of %d\n',i,N);
    
    V0 = interpolation_1d(X(1,i),C(1,:)',minS,maxS);
    pi = V0;    % Matlab is such a bad language, you can redefine pi
    
    for k=2:n-1
        ak = interpolation_1d(X(k-1,i),a(k-1,:)',minS,maxS);
        phi = (ak - c1*pi)/X(k-1,i);
        pi = phi*Delta(k,i);
    end
    
    V(i) = pi;
end
end