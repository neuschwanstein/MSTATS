rng(8368);
N = 10000;
n = 22;
m = 5001;
minS = 80.0;
maxS = 120.0;
S0 = 100.0;
K  = 100.0;
T  = 1.0;
r  = 0.05;
sigma = 0.06;
mu = 0.09;
alpha =1.0;
beta = 0.0;
put = 1;

T0 = T/n;
rp = r*T0;
sigmap = sigma*sqrt(T0);

alphap = alpha*T0;
Kp = K*exp(-r*T);
mup = mu*T0-0.5*sigmap*sigmap;
R = mup -rp +sigmap*randn(N,1);  %Gaussian excess returns

[S,C,a,c1,Phi1] = Hedging_IID_MC2012(R,T,K,r,n,put,minS,maxS,m);

C0 = interpolation_1d(S0,C(1,:)',minS,maxS);
phi = (interpolation_1d(S0,a(1,:)',minS,maxS)-C0*c1)/S0;
[Call, Put] = blsprice(S0,K,r,T,sigma);
[Call_D, Put_D] = blsdelta(S0,K,r,T,sigma);

if(put)
    fprintf('Phi (Opt) = %g  Phi (B&S) = %g  \n', phi, Put_D);
    fprintf('Put (Opt) = %g  Put (B&S) = %g  \n', C0, Put);
else
    fprintf('Phi (Opt) = %g  Phi (B&S) = %g  \n', phi, Call_D);
    fprintf('Put (Opt) = %g  Put (B&S) = %g  \n', C0, Call);
end

[CallBS,PutBS] =  blsprice(S, K, r, T, sigma);
[PhiBS,Phi1BS] =  blsdelta(S, K, r, T, sigma);

if(put)
    figure
    plot(S,C(1,:)','r--');
    hold on
    plot(S,PutBS);
    title(['Put values at time 0 for n=', num2str(n), ' hedging periods'])
    legend('Optimal hedging','Delta-hedging',0)
    figure
    plot(S,Phi1,'r--');
    hold on
    plot(S,Phi1BS);
    title('Number of shares \phi_1 at start')
    legend('Optimal hedging','Delta-hedging',0)
else
    figure
    plot(S,C(1,:)','r--');
    hold on
    plot(S,CallBS);
    title(['Call values at time 0 for n=', num2str(n), ' hedging periods'])
    legend('Optimal hedging','Delta-hedging',0)
    figure
    plot(S,Phi1,'r--');
    hold on
    plot(S,PhiBS);
    title('Number of shares \phi_1 at start')
    legend('Optimal hedging','Delta-hedging',0)
end
