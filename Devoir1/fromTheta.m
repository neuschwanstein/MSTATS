function [mu, a] = fromTheta(d,theta)
    mu = theta(1:d);
    a = triu(ones(d,d));
    mask = a;
    a(mask == 1) = theta(d+1:end);
    
    for i=1:d
        a(i,i) = exp(a(i,i));
    end
end