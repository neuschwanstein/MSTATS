function [lambda,a0,a1,b1] = findGarchParameters(X)

lambda0 = 0;
a00 = 1.5e-5;
a10 = 1e-1;
b10 = 1e-1;

L = @(h1,x) likelihood(X,h1,x(1),x(2),x(3),x(4));

constraint_matrix = ...
    [0 -1  0  0;
     0  0 -1  0;
     0  0  0 -1;
     0  1  1  1];
 constraint_vector = [0;0;0;1];

x0 = [lambda0,a00,a10,b10];
options = optimoptions(@fmincon,'TolX',1e-75,'tolFun',1e-12,'MaxFunEvals',10000,...
    'MaxIter',4000,'GradObj','on','Display','iter','Algorithm','interior-point');

h1=var(X);
for i=1:1
    [vals,~,~,~,~,grad,~] = fmincon(@(x) L(h1,x),x0,constraint_matrix, constraint_vector,[],[],[],[],[],options);
    lambda = vals(1);
    a0 = vals(2);
    a1 = vals(3);
    b1 = vals(4);
    h1 = a0/(1-a1-b1);
    x0 = [lambda,a0,a1,b1];
end

lambda = vals(1);
a0 = vals(2);
a1 = vals(3);
b1 = vals(4);
% sigma = sqrt(365)*sqrt(a0/(1-a1-b1))
% grad
% norm(grad)

plotAround(X,h1,lambda,a0,a1,b1);

end