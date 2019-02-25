function plot3Dplane(a, b, c, d)
% break into cases to avoid division by 0
if c ~= 0
    [X, Y] = meshgrid(-15:1:15);
    Z = (-a*X -b*Y + d)/c;
    surf(X, Y, Z);
elseif b ~= 0
    [X, Z] = meshgrid(-15:1:15);
    Y = (-a*X -c*Z + d)/b;
    surf(X, Y, Z);
elseif a ~= 0
    [Y, Z] = meshgrid(-15:1:15);
    X = (-b*Y -c*Z + d)/a;
    surf(X, Y, Z);
end

view(30,30);
end
