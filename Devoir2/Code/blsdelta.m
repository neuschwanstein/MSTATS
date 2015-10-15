function [deltaCall, deltaPut] = blsdelta(S,K,r,T,sigma)
[~,d] = size(S);
T = repmat(T,1,d);      % T = [T T .. T] (d cols);
d1 = 1./(sigma*sqrt(T)) .* (log(S/K) + r*T + sigma^2*T/2);
deltaCall = normcdf(d1);
deltaPut = deltaCall-1;
end