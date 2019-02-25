% example of a randomly created Maximum Likelihood Estimator
clear;

N = 100;

a = randn;
b = randn;

% generate data
x = randn(N,1);
y = a*x + b + (0.5*rand(N,1) + 2);

% zero-mean the data
x = x - mean(x);
y = y - mean(y);






plot(x,y,'ro');



