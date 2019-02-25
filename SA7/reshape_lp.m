% Thomas Monfre
% Dartmouth College CS 11, Spring 2018
% Short Assignment 7: transform image of license plate to be readable using
% a total least-squares estimate

clear;
load('lp_coords.mat'); % image coordinates from get_lp_coords

p = coords; % image coords
P = [0 0 ; 400 0 ; 400 200 ; 0 200]; % world coords

% matrix of linear constraints on image and world coordinates
A = [-P(1,1) -P(1,2) -1 0 0   0  p(1,1)*P(1,1) p(1,1)*P(1,2) p(1,1) ;
      0 0 0  -P(1,1) -P(1,2) -1  p(1,2)*P(1,1) p(1,2)*P(1,2) p(1,2) ;
     -P(2,1) -P(2,2) -1 0 0   0  p(2,1)*P(2,1) p(2,1)*P(2,2) p(2,1) ;
      0 0 0  -P(2,1) -P(2,2) -1  p(2,2)*P(2,1) p(2,2)*P(2,2) p(2,2) ;
     -P(3,1) -P(3,2) -1 0 0   0  p(3,1)*P(3,1) p(3,1)*P(3,2) p(3,1) ;
      0 0 0  -P(3,1) -P(3,2) -1  p(3,2)*P(3,1) p(3,2)*P(3,2) p(3,2) ;
     -P(4,1) -P(4,2) -1 0 0   0  p(4,1)*P(1,1) p(4,1)*P(4,2) p(4,1) ;
      0 0 0  -P(4,1) -P(4,2) -1  p(4,2)*P(4,1) p(4,2)*P(4,2) p(4,2)];

% perform total-least squares to solve for column vector h of unknowns
M = A'*A;
[V,D] = eig(M);
h = V(:,1);

% form h into 3x3 matrix of unknowns
H = reshape(h,3,3)';

% display original image
im = imread('license.jpg'); % read in image
imshow(im);

% display the now-readable license plate
figure;
T = projective2d(inv(H)'); % create homography
im2 = imwarp(im, T); % apply transformation
imshow(im2); % display the transformed image
set(gca, 'Ydir', 'normal' ); % set y-axis
