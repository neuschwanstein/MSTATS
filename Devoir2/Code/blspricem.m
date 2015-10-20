function [call, put] = blspricem(S,K,r,T,sigma)

d1 = (log(S/K) + r*T + sigma^2*T/2)./(sigma*sqrt(T));
d2 = d1 - sigma*sqrt(T);
call = S.*normcdf(d1) - K*exp(-r*T)*normcdf(d2);
put = call - S + K*exp(-r*T);
end