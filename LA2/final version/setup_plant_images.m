% Thomas Monfre
% Dartmouth College CS 11, Spring 2018
% Long Assignment 2: set up and store images of plants in .mat file

clear;

% global constants for frame information
frameWidth = 60;
frameHeight = 45;
numFrames = 720;

% instantiate image matrices - four dimensions for each directory
images = zeros(frameHeight,frameWidth,numFrames,2);

% loop over each directory of plant images
for plant=1:2
    
    % grab directory information and load the directory of plant images
    directoryName = strcat('plant',num2str(plant));
    plantDir = dir(strcat(directoryName,'/*.jpg'));
    
    % loop over each image in the directory
    for k=1 : 1 : length(plantDir)     

        % grab image information
        filename = strcat(directoryName,'/',plantDir(k).name);
        im = imread(filename);

        % convert image to greyscale and proper size
        im = rgb2gray(im);
        im = imresize(im,60/640);
        
        % add images to matrix of images
        images(:,:,k,plant) = im;
    end
end

% save image matrix to .mat file
save('image_matrices.mat', 'images')
