% transformation matrix practice

clear;

angle = input('Angle: ');

M_orig = [cosd(angle) -sind(angle) ; sind(angle) cosd(angle)];

coord_orig = [12 523]';
coord_fina = M_orig * coord_orig;

M_new = [coord_orig(1) -coord_orig(2) ; coord_orig(2) coord_orig(1)];
ab = inv(M_new) * coord_fina;

angle_new = acosd(ab(1))
