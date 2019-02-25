% Thomas Monfre
% Dartmouth College CS 11, Spring 2018
% Short Assignment 4: Linear systems in MatLab

% Problem 1:
% compute matrix expressions

% store "local" variables for matrices used in this problem
A = [-1 ; 3];
B = [4 2 ; -3 1];
C = [5 10 ; 11 -3];
D = [-6 2 ; 3 1 ; -2 -7];

% part a (solution is stored in variable p1a & printed to Command Window)
p1a = -2 * C

% part b 
p1b = (5*B) - (2*C)

% part c
p1c = C*A

% part d
p1d = (A') * (D')

% part e
p1e = B * C

% part f
p1f = C * B

% part g
p1g = C * (B')

% clear "local" variables used for problem 1
clear A;
clear B;
clear C;
clear D;


% Problem 2:
% solve linear systems

% part a (solution is stored in variable p2a & printed to Command Window)

M = [5 7 ; 3 6];  % "local" variable for matrix M
v = [10 ; -3];    % "local" variable for vector v

p2a = inv(M) * v  % result

% part b
M = [3 5 6 ; 1 3 -2 ; -4 -6 3];  % matrix M
v = [7 ; 5 ; 5];  % vector v

p2b = inv(M) * v  % result 

% part c
M = [-2 0 6 ; 0 2 4 ; 3 6 -2];   % matrix M
v = [8 ; 6 ; -4];   % vector v

p2c = inv(M) * v    % result

% part d
M = [-1 0 3 ; 0 1 2 ; 3 6 -2];   % matrix M
v = [4 ; 3 ; -4];   % vector v

p2d = inv(M) * v    % result

% clear "local" variables used for problem 2
clear M;
clear v;


% Problem 3: 
% graph solutions to problem 2

% load auxilliary graphics functions
addpath('cs11lib/') 

% part a
figure; hold on; % instruct MatLab to plot several features in same figure

plot2Dline(5, 7, 10)       % 5x + 7y = 10
plot2Dline(3, 6, -3)       % 3x + 6y = -3

plot2Dpoint(9,-5)          % solution

% part b
figure; hold on;

plot3Dplane(3, 5, 6, 7)    %  3x + 5y + 6z = 7
plot3Dplane(1, 3, -2, 5)   %   x + 3y - 2z = 5
plot3Dplane(-4, -6, 3, 5)  % -4x - 6y + 3z = 5

plot3Dpoint(-8, 5, 1)      % solution

% part c
figure; hold on;

plot3Dplane(-2, 0, 6, 8)   % -2x + 6z = 8
plot3Dplane(0, 2, 4, 6)    %  2y + 4z = 6
plot3Dplane(3, 6, -2, -4)  %  3x + 6y -2z = -4

plot3Dpoint(2, -1, 2)      % solution

% part d
figure; hold on;

plot3Dplane(-1, 0, 3, 4)   %  -x + 3z = 4
plot3Dplane(0, 1, 2, 3)    %   y + 2z = 3
plot3Dplane(3, 6, -2, -4)  %  3x + 6y -2z = -4

plot3Dpoint(2, -1, 2)      % solution
