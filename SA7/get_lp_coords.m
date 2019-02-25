% Thomas Monfre
% Dartmouth College CS 11, Spring 2018
% Short Assignment 7: function to select points from an image then save
% said coordinates for later use

% function call:
% get_lp_coords('SA7/license.jpg', 'lp_coords.mat');

function [] = get_lp_coords(imageFile, outputFile)

% load image
im = imread(imageFile);

% display image
imshow(im);
axis on;
title('Select Corners of License Plate');

% block for user to select 4 corners
coords = ginput(4);

close;
fprintf('Grabbed license plate coordinate values');

% save coordinates to the output file
save(outputFile, 'coords');

end