% practice figure out shear values
clear;

a_orig = input('Original A Value: ');
b_orig = input('Original B Value: ');

M_orig = [1 a_orig ; b_orig 1];

coord_orig = [1 2 3 4 ; 5 6 7 8];

coord_new = M_orig * coord_orig;

M_new = [coord_orig(2) 0 ; 0 coord_orig(1)];
v = [coord_new(1) - coord_orig(1) ; coord_new(2) - coord_orig(2)];

final_ans = inv(M_new) * v