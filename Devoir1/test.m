% Test.m
d = 5;
n = 2000;

sigma = [0.2;0.3;0.25;0.15;0.2];
corr = [0.5 0.1 0.05 0.08 0.02;
          0 0.5 0.03 0.07 0.1;
          0   0 0.5  0.01 0.02;
          0   0   0   0.5 0.03;
          0   0   0     0   0.5];
corr = corr + corr';
Sigma = diag(sigma)*corr*diag(sigma);