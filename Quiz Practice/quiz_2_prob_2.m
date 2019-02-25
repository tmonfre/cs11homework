clear;

M = [ 1 1; 1 0 ];

u = [1 ; 1];

for i=3 : 1 : 13
    
    u = M * u;
    fprintf('Calcul: %d \n', u(1));
    fprintf('Actual: %d \n', fibonacci(i));
    
end



