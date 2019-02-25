% Thomas Monfre
% Dartmouth College CS 11, Spring 2018
% Long Assignment 2: visualize the motion of plants

clear;
load('image_matrices.mat');
load('pixel_motion.mat');

% time values for graph of average vertical motion
x = [0:10:length(avg)*10-1]';

% plot the average amount of vertical motion as a function of time
figure;
p1graph = plot(x,avg(:,1).*(480/45),'r');
hold on;
p2graph = plot(x,avg(:,2).*(480/45),'b');
hold off;

% label axis
title('Average Vertical Motion as a Function of Time');
xlabel('Time (each frame taken 10 minutes apart)');
ylabel('Average vertical motion of plant leaves');
legend('plant 1','plant 2');
grid on;

% create new figure
figure;

% iterate over image frames for each plant
for plant=1:2
    
    % display plant images overlaid with motion vectors
    for k=4 : 1 : length(images)-3
        figure(2);

        % display image
        im = images(:,:,k,plant);
        imagesc(im);
        title(['Plant ',num2str(plant),' frame ',num2str(k)]);
        axis off;

        % display motion vectors
        hold on;
        quiver(motion(:,:,1,k-3,plant),-motion(:,:,2,k-3,plant),'y');
        hold off;

        % allow framerate/refresh rate to catch up
        pause(0.1);
    end
end