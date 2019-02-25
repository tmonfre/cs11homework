% Thomas Monfre
% Dartmouth College CS 11, Spring 2018
% Long Assignment 1: function to estimate the curve then visualize best-fit

%% setup
% clear workspace, then load variables from ball_cords.mat
clear;
load('ball_cords.mat');

% grab the user-selected graph values from coords
graphX = coords(:,1);
graphY = coords(:,2);

figure;

% set x range of values - to be used in all graphs
% left bound takes first x value from coords and subtracts 5 unit buffer
% right bound takes last x value from coords and adds 23 unit buffer
xrng = [graphX(1) - 5 : 10 : graphX(length(graphX)) + 23]';

%% GRAPH LEAST-SQUARED LINE

% create subplot for all graphs, then access plot 1
subplot(2,2,1);

% graph the user-coordinates
userPoints = plot(graphX, graphY, 'r.');
set(userPoints, 'MarkerSize', 10);

% calculate the least-squared line
lineX = [graphX ones(size(graphX))];
lineU = inv(lineX'*lineX) * lineX' * graphY;
lineEq = lineU(1)*xrng + lineU(2);

% graph the least-squared line
hold on;
line = plot(xrng,lineEq);
set(line, 'LineWidth', 1);
axis equal; set(gca, 'YDir', 'reverse');
hold off;

title('Least-Squared Line');

% calculate mean-squared error
lineValsY = lineU(1)*graphX + lineU(2); % predicted y values
lineError = (graphY - lineValsY).^2;
lineError = sum(lineError) / length(graphX);

fprintf('Mean-Squared Error of Line: %f \n', lineError);

%% GRAPH LEAST-SQUARED PARABOLA

% access subplot 2
subplot(2,2,2);

% graph the user-coordinates
userPoints = plot(graphX, graphY, 'r.');
set(userPoints, 'MarkerSize', 10);

% calculate the least-squared parabola1
parab1X = [graphX.^2 graphX ones(size(graphX))];
parab1U = inv(parab1X'*parab1X) * parab1X' * graphY;
parab1Eq = parab1U(1)*xrng.^2 + parab1U(2)*xrng + parab1U(3);

% graph the least-squared parabola1
hold on;
parab1 = plot(xrng,parab1Eq);
set(parab1, 'LineWidth', 1);
axis equal; set(gca, 'YDir', 'reverse');
hold off;

title('Least-Squared Parabola');

% calculate mean-squared error
parab1ValsY = parab1U(1)*graphX.^2 + parab1U(2)*graphX + parab1U(3);
parab1Error = (graphY - parab1ValsY).^2;
parab1Error = sum(parab1Error) / length(graphX);

fprintf('Mean-Squared Error of Parabola: %f  \n', parab1Error);

%% GRAPH LEAST-SQUARED PARABOLA WITH NO FIRST-ORDER TERM

% access subplot 3
subplot(2,2,3);

% graph the user-coordinates
userPoints = plot(graphX, graphY, 'r.');
set(userPoints, 'MarkerSize', 10);

% calculate the least-squared parabola2
parab2X = [graphX.^2 ones(size(graphX))];
parab2U = inv(parab2X'*parab2X) * parab2X' * graphY;
parab2Eq = parab2U(1)*xrng.^2 + parab2U(2);

% graph the least-squared parabola2
hold on;
parab2 = plot(xrng,parab2Eq);
set(parab2, 'LineWidth', 1);
axis equal; set(gca, 'YDir', 'reverse');
hold off;

title('Least-Squared Parabola with no first-order term');

% calculate mean-squared error
parab2ValsY = parab2U(1)*graphX.^2 + parab2U(2);
parab2Error = (graphY - parab2ValsY).^2;
parab2Error = sum(parab2Error) / length(graphX);

fprintf('Mean-Squared Error of Parabola with no first-order term: %f  \n', parab2Error);

%% GRAPH LEAST-SQUARED SINUSOID

% access subplot 4
subplot(2,2,4);

% graph the user-coordinates
userPoints = plot(graphX, graphY, 'r.');
set(userPoints, 'MarkerSize', 10);

% calculate the least-squared sinusoid
sinusoidX = [sin(((1/335.5)*graphX) - 9.9) ones(size(graphX))];
sinusoidU = inv(sinusoidX'*sinusoidX) * sinusoidX' * graphY;
sinusoidEq = sinusoidU(1)*sin(((1/335.5)*xrng) - 9.9) + sinusoidU(2);

% graph the least-squared sinusoid
hold on;
sinusoid = plot(xrng,sinusoidEq);
set(sinusoid, 'LineWidth', 1);
axis equal; set(gca, 'YDir', 'reverse');
hold off;

title('Least-Squared Sinusoid');

% calculate mean-squared error
sinusoidValsY = sinusoidU(1)*sin(((1/335.5)*graphX) - 9.9) + sinusoidU(2);
sinusoidError = (graphY - sinusoidValsY).^2;
sinusoidError = sum(sinusoidError) / length(graphX);

fprintf('Mean-Squared Error of Sinusoid: %f  \n', sinusoidError);

%% GRAPH
figure;

% superimpose image with graph plot -- image advances every 0.5 seconds
for k=1 : 1 : 25
    
    figure(2);
    
    % display image on screen
    frame = frames(:,:,:,k);
    imshow(uint8(frame));
    drawnow;
    
    hold on;
    
    % overlay predicted location from best-fit model
    parab1 = plot(xrng,parab1Eq);
    set(parab1, 'LineWidth', 1);
    
    % overlay selected coordinate points from coords
    userPoints = plot(graphX, graphY, 'r.' );
    set(userPoints, 'MarkerSize', 25);
    
    hold off;
    
    % reverse and label axis
    set(gca, 'YDir', 'reverse');    
    title('Superimposed Video with Selected Points and Predicted Curve');
    
    % wait (block)
    pause(0.5);
end
