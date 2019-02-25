% CS 11, Spring 2018
% Short Assignment 6
% scaffolding provided by CS 11 staff
% compute_transform function written by Thomas Monfre

clear;

% load image
im = imread( 'SA6/einstein.png' );

% display original image
% prompt user to select 3 points
imshow( im ); axis on;
title('Original image');
[x1, y1] = ginput(3);

% generate a random 2 x 2 affine matrix
a = 1 + 0.25*randn;
b = 0.25*randn;
c = 0.25*randn;
d = 1 + 0.25*randn;
T1 = [a b 0; c d 0; 0 0 1];
tform = affine2d(T1);

% generate a random 2 x 1 translation vector
e = 20*rand;
f = 20*rand;

% warp and translate image
imT1 = imwarp( im, tform );         % affine
imT1 = shift( imT1, e, f );         % translation

% display image after warp and translate
% prompt user to select 3 points
imshow( uint8(imT1) ); axis on;
title('Warped and translated image');
[x2, y2] = ginput(3);

tback = compute_transform( x1, y1, x2, y2 );

% apply transformation to (hopefully) restore the original

tform = affine2d([tback(1,1) tback(1,2) 0; tback(2,1) tback(2,2) 0; 0 0 1]);
imT2 = shift( imT1, tback(1,3), tback(2, 3));   % translation
imT2 = imwarp( imT2, tform );                   % affine
imshow( uint8(imT2) ); axis on;
title('Restored image');


% compute transformation matrix to convert warped points
% x2, y2 back to the original coordinates x1, y1
%
% This function should return a 2x3 matrix named
% 'transform' that contains the 2x2 affine transformation
% matrix and 2x1 translation vector (as shown in class).

function[transform] = compute_transform( x1, y1, x2, y2 )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% create 6x6 matrix of known x2,y2 values, zeros, and ones
% to be multiplied by 6x1 column vector of unknowns (a,b,c,d,e,f)
M = [x2 y2 zeros(3,1) zeros(3,1) ones(3,1) zeros(3,1) ; 
     zeros(3,1) zeros(3,1) x2 y2 zeros(3,1) ones(3,1)];
 
% resultant 6x1 column vector of original x1,y1 points
v = [x1 ; y1];

% calculate inverse and solve for 6x1 matrix of unknowns
u = inv(M) * v;

% reform unknowns to transformation matrix
transform = [u(1,1) u(2,1) u(5,1) ; u(3,1) u(4,1) u(6,1)];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end


%%% -------------------------------
function[im2] = shift( im, dx, dy )

%%% DETERMINE TRANSLATION AMOUNTS
[ydim,xdim,zdim] = size( im );
dims = [ydim xdim];
vals = [dy dx];
vals = round( mod( -vals, dims ) );

%%% TRANSLATE EACH CHANNEL
im2 = zeros(ydim, xdim, zdim);
for z = 1 : zdim
    im2(:,:,z) = [ im(vals(1)+1:dims(1), vals(2)+1:dims(2), z),...
        im(vals(1)+1:dims(1), 1:vals(2), z); ...
        im(1:vals(1), vals(2)+1:dims(2), z),...
        im(1:vals(1), 1:vals(2), z) ];
end
end


