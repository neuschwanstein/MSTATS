function theta = toTheta(d,mu,a)
    theta = zeros(d*(d+3)/2,1);
    theta(1:d) = mu;
    
    for i=1:d
        a(i,i) = log(a(i,i));
    end
    
    mask = triu(ones(d,d));   
%     theta(d+1:end) = nonzeros(a);
    theta(d+1:end) = a(mask==1);
end