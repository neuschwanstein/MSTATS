function [mu, a, V, muError, aError] = parameterEstimation(S)
    % Do we also need values for correlation and errors? (as shown on p.40)
    
    %% Housekeeping
    X = log(S(2:end,:)) - log(S(1:end-1,:));
    [n,d] = size(X);
    lklh = @(theta) likelihood(X,theta);
    
    %% Initialization
    mu0 = 0.1*ones(d,1);
    cov0 = 0.01*eye(d); % 0.1 vol, no correlation
    theta0 = toTheta(d,mu0,cov0);
    
    %% Optimization
    [theta,~,~,~,~,H] = fminunc(lklh,theta0); % H=hessian(theta)
    
    %% Estimators
    [mu, a] = fromTheta(d,theta);
    
    %% Error estimation
    I = H/n;
    J = jacobian(d,theta);
    V = J*(I\J);
    
    diagV = diag(V);
    muError = 1.96*sqrt(diagV(1:d)/n);
    aError = triu(ones(d));
    aError(aError == 1) = 1.96*sqrt(diagV(d+1:end)/n);
end