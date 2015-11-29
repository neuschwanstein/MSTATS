function [price,delta] = duanTables(lambda,a0,a1,b1)
%% Duan 1995 replication.

%% Simulation parameters
N = 5e4;
s0s = [0.8, 0.9, 0.95, 1, 1.05, 1.1, 1.2];
Ts = [30, 90, 180];
h1ratios = [0.8, 1.0, 1.2];
sigma = sqrt(a0/(1-a1-b1));
% sigma = sqrt(a0/(1-a1*(1+lambda^2)-b1));
price_factor = 10000;

%% Results storage: First two are s0 and mean(bmsPrice), others are garch stats
price = zeros(21,11); 
delta = zeros(21,11);

%% Loop across all values
i=1;
for T=Ts
for s0=s0s
    %% Generate MC points for this particular simulation.
    rands = normrnd(0,1,T,N);
    
    %% BMS True Values
    d = (log(s0) + T*sigma^2/2)/(sigma*sqrt(T));
    true_bms_price = s0*normcdf(d) - normcdf(d - sigma*sqrt(T));
    true_bms_delta = normcdf(d);
    true_bms_price = price_factor * true_bms_price;
    
    %% BMS Montecarlo runs
    bmsReturns = -0.5*sigma^2 + sigma*rands;
    bmsX = s0*exp(sum(bmsReturns))';
    
    bms_price = max(bmsX-1,0) * price_factor;
    bms_delta = bmsX/s0 .* (bmsX>=1);

    price(i,1) = s0;
    delta(i,1) = s0;
    price(i,2) = true_bms_price;
    delta(i,2) = true_bms_delta;
    
    j=3;
    for h1ratio=h1ratios
        [garch_price, garch_delta] = garchMC(bmsX,h1ratio,rands,s0,sigma,a0,a1,b1,lambda);
        garch_price = garch_price * price_factor;
        
        price(i,j) = mean(garch_price);
        delta(i,j) = mean(garch_delta);
        
        price(i,j+1) = bias(garch_price, true_bms_price);
        delta(i,j+1) = bias(garch_delta, true_bms_delta);
        
%         price(i,j+2) = sd(garchPrice, trueBmsPrice);
%         delta(i,j+2) = sd(garchDelta, trueBmsDelta);
        price(i,j+2) = sd(garch_price, true_bms_price);
        delta(i,j+2) = sd(garch_delta, true_bms_delta);        
        j = j+3;
    end
    
    i=i+1;
end
end
end

function bias = bias(garch, bms)
% bias = 100*mean((garch - bms)/bms);
bias = (100*mean(garch) - bms)/bms;
end

% function sd = sd(garch,bms)
% n = length(garch);
% biases = zeros(n,1);
% for i=1:n
%     temp_garch = garch;
%     temp_garch(i) = [];
%     biases(i) = bias(temp_garch,bms);
% end
% sd = std(biases);
% end
% function sd = sd(garch,bms)
% garch = garch(bms~=0);
% bms = bms(bms~=0);
% sd=std(100*(garch-bms)./bms);
% end

function sd = sd(garch, bms)
sd = std(100*(garch - bms)/bms);
end


