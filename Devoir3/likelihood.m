function [L,grad_L] = likelihood(X,h1,lambda,a0,a1,b1)
% To be minimized !!

%% Value initalization and allocation
T = length(X);
h = zeros(T,1);
e = zeros(T,1);

%% Minus Likelihood computation
h(1) = h1;
e(1) = (X(1) - lambda*sqrt(h(1)) - 0.5*h(1))/sqrt(h(1));

for t=2:T
    h(t) = a0 + a1*h(t-1)*e(t-1)^2 + b1*h(t-1);
    e(t) = (X(t) - lambda*sqrt(h(t)) - 0.5*h(t))/sqrt(h(t));
end

L = sum(log(h) + e.^2);

%% Gradient
if nargout > 1
    
%% Constant value initilization and allocation
grad_lambda = [1 0 0 0];
grad_a0     = [0 1 0 0];
grad_a1     = [0 0 1 0];
grad_b1     = [0 0 0 1];

grad_h = zeros(T,4);
grad_e = zeros(T,4);

%% Gradient Computation
grad_h(1,:) = [0;0;0;0];
grad_e(1,:) = -grad_lambda;

for t=2:T
    grad_h(t,:) = grad_a0 + ...
        2*a1*h(t-1)*e(t-1)*grad_e(t-1,:) + a1*e(t-1)^2*grad_h(t-1,:) + h(t-1)*e(t-1)^2*grad_a1 + ...
        h(t-1)*grad_b1 + b1*grad_h(t-1,:);
    
    grad_e(t,:) = -0.5*X(t)*h(t)^(-3/2)*grad_h(t,:) + ...
        -grad_lambda + ...
        -0.25*h(t)^(-1/2)*grad_h(t,:);
end

grad_L = sum(grad_h./repmat(h,1,4) + 2*repmat(e,1,4).*grad_e);

end
end