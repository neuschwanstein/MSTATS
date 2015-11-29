%test.m

%%%%%%%%%% Option parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S = 0.8;
K = 1;
r = 0;
sigma = 0.25;
T = 3;
% Value of the underlying
% Strike (exercise price)
% Risk free interest rate
% Volatility
                                        % Time to expiry
%%%%%%%%%% Monte-Carlo Method Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% randn(?state?,0)                      % Repeatable trials on/off
M=1e7;                                  % Number of Monte-Carlo trials
%%%%%%%%%% Use final values to compute %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X=S*exp((r-0.5*sigma^2)*T + sigma*sqrt(T)*randn(M,1));
option_values=max(K-X,0);
present_vals=exp(-r*T)*option_values;
int=1.96*std(present_vals)/sqrt(M);
put_value=mean(present_vals);
display(put_value)
display([put_value-int put_value+int])

d1 = (log(S/K) + (r + 0.5*sigma^2)*T)/(sigma*sqrt(T));
d2 = d1 - sigma*sqrt(T);
N1 = 0.5*(1+erf(-d1/sqrt(2)));
N2 = 0.5*(1+erf(-d2/sqrt(2)));
value = K.*exp(-r*T).*N2-S.*N1;

my_delta = mean(X/S .* (X>=K))

% Evaluate the Put option options
% Discount under r-n assumption
% Compute confidence intervals
% Take the average