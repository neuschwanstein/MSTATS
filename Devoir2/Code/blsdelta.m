function delta = blsdelta(S,K,r,T,sigma)

d1 = 1./(sigma*sqrt(T)) .* (log(S/K) + r*T + sigma^2*T/2);
delta = [normcdf(d1), nomrcdf(d1)-1];
end