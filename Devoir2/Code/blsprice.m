function price = blsprice(S,K,r,T,sigma)

d1 = 1/(sigma*sqrt(T)) * (log(S/K) + r*T + sigma^2*T/2);
d2 = 1/(sigma*sqrt(T)) * (log(S/K) + r*T - sigma^2*T/2);
call = S.*normcdf(d1) - K*exp(-r*T)*normcdf(d2);
put = call - S + K*exp(-r*T);
price = [call, put];
end