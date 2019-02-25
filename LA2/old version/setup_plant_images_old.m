% Thomas Monfre
% Dartmouth College CS 11, Spring 2018
% Long Assignment 2: set up and store images of plants in .mat file

clear;

% load directories of plant images
plant1 = dir('plant1/*.jpg');
plant2 = dir('plant2/*.jpg');
 
p1images = zeros(45,60,length(plant1));
p2images = zeros(45,60,length(plant2));
 
for k=1 : 1 : length(plant1)     
    
    % grab image information from directories plant1 and plant2
    p1filename = strcat('plant1/',plant1(k).name);
    p2filename = strcat('plant2/',plant2(k).name);
    
    % grab image from directories plant1 and plant2
    p1im = imread(p1filename);
    p2im = imread(p2filename);
    
    % convert images to greyscale and proper size
    p1im = rgb2gray(p1im);
    p2im = rgb2gray(p2im);
    p1im = imresize(p1im,60/640);
    p2im = imresize(p2im,60/640);
    
    % add images to matrix of images
    p1images(:,:,k) = p1im;
    p2images(:,:,k) = p2im;
end

% save image matrices to file
save('image_matrices.mat', 'p1images', 'p2images')
