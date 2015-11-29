function [] = plotAround(X,h1,lambda,a0,a1,b1)

ls =linspace(0.9*lambda,1.1*lambda,20);
a0s=linspace(0.9*a0,1.1*a0,20);
a1s=linspace(0.9*a1,1.1*a1,20);
b1s=linspace(0.9*b1,1.1*b1,20);

yl=zeros(1,20); ya0=zeros(1,20); ya1=zeros(1,20); yb1=zeros(1,20);
grad_l=zeros(1,20); grad_a0=zeros(1,20); grad_a1=zeros(1,20); grad_b1=zeros(1,20);

for i = 1:20
    [yl(i),grad] = likelihood(X,h1,ls(i),a0,a1,b1); grad_l(i) = grad(1);
    [ya0(i),grad] = likelihood(X,h1,lambda,a0s(i),a1,b1); grad_a0(i) = grad(2);
    [ya1(i),grad] = likelihood(X,h1,lambda,a0,a1s(i),b1); grad_a1(i) = grad(3);
    [yb1(i),grad] = likelihood(X,h1,lambda,a0,a1,b1s(i)); grad_b1(i) = grad(4);
end
x=1:20;

figure
plot(x,yl,x,ya0,x,ya1,x,yb1);
legend('\lambda','\alpha_0','\alpha_1','\beta_1')
ylabel('Minus Log Likelihood')
% 
% figure
% plot(x,grad_l);
% title('\lambda Gradient')
% 
% figure
% plot(x,grad_a0);
% title('\alpha_0 Gradient')
% 
% figure
% plot(x,grad_a1);
% title('\alpha_1 Gradient')
% 
% figure
% plot(x,grad_b1);
% title('\beta_1 Gradient')
end