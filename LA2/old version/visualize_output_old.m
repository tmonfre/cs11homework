% Thomas Monfre
% Dartmouth College CS 11, Spring 2018
% Long Assignment 2: visualize the motion of plants

clear;
load('image_matrices.mat');
load('pixel_motion.mat');

% time values for graph of average vertical motion
x = [0:10:length(p1avg)*10-1]';

% plot the average amount of vertical motion as a function of time
figure;
p1graph = plot(x,p1avg.*(480/45),'r');
hold on;
p2graph = plot(x,p2avg.*(480/45),'b');
hold off;

% label axis
title('Average Vertical Motion as a Function of Time');
xlabel('Time (each frame taken 10 minutes apart)');
ylabel('Average vertical motion of plant leaves');
legend('plant 1','plant 2');
grid on;

% create new figure
figure;

% display plant images overlaid with motion vectors
for k=4 : 1 : length(p1images)-3
    figure(2);
    
    % display image
    im = p1images(:,:,k);
    imagesc(im);
    title(['Plant 1 frame ',num2str(k)]);
    axis off;
    
    % display motion vectors
    hold on;
    quiver(p1motion(:,:,1,k-3),-p1motion(:,:,2,k-3),'y');
    hold off;
    
    % allow framerate/refresh rate to catch up
    pause(0.1);
    
end
