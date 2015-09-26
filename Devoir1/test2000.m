% Test.m
d = 2;
n = 5000;
h = 1/252;

if d == 5
    mu = [0.1;0.2;0.15;0.12;0.08];
    vol = [0.2;0.3;0.25;0.15;0.2];
    corr = [0.5 0.1 0.05 0.08 0.02;
              0 0.5 0.03 0.07  0.1;
              0   0  0.5 0.01 0.02;
              0   0   0   0.5 0.03;
              0   0   0   0   0.5];
    corr = corr + corr';
    Sigma = diag(vol)*corr*diag(vol);
elseif d == 1
    mu = 0.1;
    Sigma = 0.2^2;
    vol = 0.2;
elseif d == 2
    mu = [0.08;0.12];
    vol = [0.2;0.15];
    corr = [1 0.7; 0.7 1];
    Sigma = diag(vol)*corr*diag(vol);
end

a = chol(Sigma);

Z = normrnd(0,1,n,d);
X = h*ones(n,1)*(mu - vol.^2/2)' - sqrt(h)*Z*a;

S = 100*exp(cumsum(X));

%[muEst, aEst, V, muError, aError, vError] = parameterEstimation(S);