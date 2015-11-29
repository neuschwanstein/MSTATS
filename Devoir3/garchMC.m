function [garch_price, garch_delta] = garchMC(bmsX,h1ratio,rands,s0,sigma,a0,a1,b1,lambda)

%% Initialization
[T,N] = size(rands);
K = 1;

%% BMS True Values
d = (log(s0) + T*sigma^2/2)/(sigma*sqrt(T));
true_bms_price = s0*normcdf(d) - normcdf(d - sigma*sqrt(T));
true_bms_delta = normcdf(d);

%% Montecarlo Loop
h = zeros(T,N);
xi = zeros(T,N);

h(1,:) = (h1ratio*sigma)^2;
for t=2:T
    xi(t-1,:) = sqrt(h(t-1,:)).*rands(t-1,:);
    h(t,:) = a0 + a1*(xi(t-1,:) - lambda*sqrt(h(t-1,:))).^2 + b1*h(t-1,:);
end
xi(T,:) = sqrt(h(T,:)).*rands(T,:);

X = s0*exp(sum(-0.5*h + xi))';


%% Final stats.
garch_price = max(X-K,0);
garch_delta = X/s0 .* (X>=K);

%% Control Variates
bms_price = max(bmsX-K,0);
bms_delta = bmsX/s0 .* (bmsX>=K);

opt_price_price = -cov(garch_price,bms_price)/var(bms_price);
opt_price_price = opt_price_price(1,2);
garch_price = garch_price + opt_price_price*(bms_price - true_bms_price);

opt_price_delta = -cov(garch_price,bms_delta)/var(bms_delta);
opt_price_delta = opt_price_delta(1,2);
garch_price = garch_price + opt_price_delta*(bms_delta - true_bms_delta);

opt_delta_price = -cov(garch_delta,bms_price)/var(bms_price);
opt_delta_price = opt_delta_price(1,2);
garch_delta = garch_delta + opt_delta_price*(bms_price - true_bms_price);

opt_delta_delta = -cov(garch_delta,bms_delta)/var(bms_delta);
opt_delta_delta = opt_delta_delta(1,2);
garch_delta = garch_delta + opt_delta_delta*(bms_delta - true_bms_delta);
end