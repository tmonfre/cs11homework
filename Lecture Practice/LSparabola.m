% load and plot data
load LSparabola.mat;
h = plot( x, y, '.' );
set( h, 'MarkerSize', 16 );
set( gca, 'FontSize', 16 );

% your LS code here (2 lines)
% u: 3x1 vector with values for a,b,c
X = [x.^2 x ones(size(x))];
u = inv(X'*X) * X' * y;

% plot LS fit
xrng = [-1 : 0.1 : 1]';
P = u(1)*xrng.^2 + u(2)*xrng + u(3);
hold on;
plot( xrng, P );
hold off;
axis( [-1 1 0.6 2] );
