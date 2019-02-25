% simulate a coin toss

n = 100000;
x = (rand(1,n) < 0.5);

heads = 0;
tails = 0;

for k=1 : length(x)
    if x(k) == 1
        heads = heads + 1;
    elseif x(k) == 0
        tails = tails + 1;
    end
end

pie([heads, tails],{'Heads','Tails'})

figure;
y = cumsum(x)./[1:n];
plot(y);
axis([0 n 0.25 0.75]);