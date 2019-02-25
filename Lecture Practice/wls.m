clear;

N = 20;

coords = zeros(N,2);
W = zeros(N);

a = randn;
b = randn;

for k=1 : N
    coords(k,1) = randn;
    coords(k,2) = a*coords(k,1) + b + (0.2*randn);
    W(k,k) = 1 + sqrt(coords(k,1)*coords(k,1) + coords(k,2)*coords(k,2));
end

X = [coords(:,1) ones(N,1)];

u_norm = inv(X'*X) * X' * coords(:,2);
eq_norm = u_norm(1)*coords(:,1) + u_norm(2);

u_weighted = inv(X'*W'*W*X) * X' * W' * W * coords(:,2);
eq_weighted = u_weighted(1)*coords(:,1) + u_weighted(2);

plot(coords(:,1),coords(:,2),'ro');
hold on;
plot(coords(:,1),eq_norm,'g-');
plot(coords(:,1),eq_weighted,'b-');
legend('data', 'ls', 'wls');
grid on;
hold off;

