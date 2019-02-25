clear;

N = 100;

% generate data
x = randn(N,1);
y = randn*x + randn + (0.2*randn(N,1));

% zero-mean the data
x = x - mean(x);
y = y - mean(y);

% perform total least squares & solve for eigen vector u
X = [x y];
M = X'*X;
[V,D] = eig(M);
uTLS = V(:,1);

% perform least squares and solve for unknown vector u
uLS = inv(x'*x) * x' * y;

% plot
plot(x,y,'r.');
hold on;
plot(x,(-uTLS(1)*x)/uTLS(2));
plot(x, uLS(1)*x);
legend('Data','Total Least Squares','Least Squares')
hold off;
axis equal;