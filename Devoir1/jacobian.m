function J = jacobian(d,theta)
	J = ones(size(theta));
    [~,a] = fromTheta(d,theta);
    mask = triu(ones(d,d),1);
    a(mask==1) = 1;
    J(d+1:end) = a(a~=0);
    J = diag(J);
end