clear;

x0 = 1;
x = [0 : 0.1 : 2];

% zero-th order
y = exp(x);
plot(x,y);

hold on;
y = exp(x) + exp(x).*(x-x0);
plot(x,y);

y = exp(x) + exp(x).*(x-x0) + 0.5.*exp(x).*(x-x0).^2;
plot(x,y);
hold off;

legend('zero-eth order', 'first order', 'second order');


