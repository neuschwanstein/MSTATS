function lklh = likelihood(x, theta)
    % theta must be a COLUMN vector
    h = 1/252;
    [n,d] = size(x);
    
    [mu,a] = fromTheta(d,theta);
    
    Sigma = a'*a;
    m = mu - diag(Sigma)/2;
    
    lklh = n*d/2*log(2*pi*h) + n/2*log(det(Sigma));
    
    invA = inv(a);
    SigmaInv = invA*invA';
    
    lklh2 = 0;
    for i=1:n
        v = (x(i,:)'-h*m);
%         lklh2 = lklh2 + v'*(Sigma\v);
        lklh2 = lklh2 + v'*SigmaInv*v;
    end

    lklh = lklh+lklh2/(2*h);
end
