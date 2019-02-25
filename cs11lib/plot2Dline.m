% plot a line of form ax + by = c
function plot2Dline(a, b, c)
pp = [-a,c]/b;
X = linspace(-2,15);    % range for plotting line
pv = polyval(pp,X);     % evaluate the polynomial
plot(X,pv,'-b')
end
