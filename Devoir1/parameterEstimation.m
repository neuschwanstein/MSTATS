function [mu, a, V, muError, aError, vError] = parameterEstimation(S)
    %% Housekeeping
    X = log(S(2:end,:)) - log(S(1:end-1,:));
    [~,d] = size(X);
    lklh = @(theta) likelihood(X,theta);
    
    %% Initialization
    mu0 = 0.1*ones(d,1);
    cov0 = 0.01*eye(d); % 0.1 vol, no correlation
    theta0 = toTheta(d,mu0,cov0);
    
    %% Optimization
    theta = fminunc(lklh,theta0);
    
    %% Profit
    [mu, a] = fromTheta(d,theta);
    V = zeros(2);
    muError = 0;
    aError = 0;
    vError = 0;
end