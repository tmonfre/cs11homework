% fit line using steepest descent
clear;
cla; 
set( gca, 'FontSize', 24 );

% data
u   = randn(2,1); % slope and intercept
x   = [-1 : 0.02 : 1]';
y   = u(1)*x + u(2) + 0.1*randn(size(x));
bnd = max( max(abs(x)), max(abs(y)) );

% linear system
X = [x ones(length(x),1)];
b = X'*y;
A = X'*X;
ui = 10*(rand(2,1)-0.5); % starting condition

%uLS = inv(X'*X)*X'*y; % calculate with least squares -- prove answers

% steepest descent
while(1)
    ri = b - A*ui;
    alpha = (ri'*ri)/(ri'*A'*ri);
    uj = ui + alpha*ri;
    
    if mean(abs(uj-ui)) < 1e-2
        break
    end

    % display
    cla; hold on;
    plot( x, y, 'bo' );
    plot( x, uj(1)*x+uj(2), 'r-' );
    %( x, uLS(1)*X+uLS(2), 'g-');
    hold off;
    axis ( [-bnd bnd -bnd bnd] ); axis square;
    drawnow; pause(0.5);
    
    % update estimate
    ui = uj;
end
