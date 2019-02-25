% Thomas Monfre
% Dartmouth College CS 11, Spring 2018
% Long Assignment 4: using linear discriminant analysis, build a classifier
% to pre-screen patients for risk of ovarian cancer

%% setup
clear;
load('spectra.mat');

% separate into training and testing data
trainC1 = C1(:,1:8000);
trainC2 = C2(:,1:8000);
testC1 = C1(:,8001:10000);
testC2 = C2(:,8001:10000);

%% build a classifier

% define lengths of each class
N1 = length(trainC1);
N2 = length(trainC2);

% calculate the within class mean of each class
u1 = (1/N1) * sum(trainC1,2); % second parameter is dimension to sum on
u2 = (1/N2) * sum(trainC2,2);

% calculate the between class mean
u = (1/(N1+N2)) * (sum(trainC1,2)+sum(trainC2,2));

% zero-mean the data by subtracting from the respective within class means
trainC1_zm = trainC1 - u1;
trainC2_zm = trainC2 - u2;

% define a co-variance matrix of each class based on zero-meaned data
CV1 = trainC1_zm * trainC1_zm';
CV2 = trainC2_zm * trainC2_zm';

% compute the within-class scatter matrix Sw and the between-class scatter
% matrix Sb
Sw = CV1 + CV2;
Sb = N1*((u1-u)*((u1-u)')) + N2*((u2-u)*((u2-u)'));

% compute the generalized eigenvectors of Sb and Sw
[V,D] = eig(Sb,Sw);

% calculate the maximum eigenvalue and grab the associated eigenvector
D = diag(D);
[Y,I] = max(D);
e = V(:,I);

%% project and visualize the training data

% project the spectra from the training data onto e
projData1 = trainC1' * e;
projData2 = trainC2' * e;

% visualize the projected data for each class
figure('NumberTitle', 'off', 'Name', 'Training Data');
subplot(1,2,1);
histfit(projData1);
hold on;
histfit(projData2);
hold off;
title('Training Data Histogram');

% generate the training ROC curve to determine the effectiveness of the
% classifier - use this to calculate the threshold of acceptability
minT = min([projData1 ; projData2]);
maxT = max([projData1 ; projData2]);
rng = linspace(minT,maxT,500);

% initialize vectors to plot fit
plot1 = zeros(size(rng));
plot2 = zeros(size(rng));

i = 1;
% loop over each possible threshold
for possibleThreshold = rng
    % calculate fit for class 1
    ind = find(projData1 <= possibleThreshold);
    plot1(i) = 100*length(ind)/N1;
    
    % calculate fit for class 2
    ind = find(projData2 > possibleThreshold);
    plot2(i) = 100*length(ind)/N2;
    i = i + 1;
end

% plot the ROC curves
subplot(1,2,2);
plot(rng,plot1);
hold on;
plot(rng,plot2);
hold off;

% label graph
xlabel('Thresholds');
ylabel('Success Rate');
legend('C1','C2');
title('Receiver Operating Curve of Training Data');

% calculate the intersection of the ROC curves by determining the index at
% which the sum of each individual point is maximum
sums = plot1 + plot2;
[topSum,topIndex] = max(sums);

% grab the threshold at the index of the maximum sum
T = rng(topIndex);

% calculate the success rate of this threshold
success = mean([plot1(topIndex) plot2(topIndex)]);

fprintf('TRAINING DATA \n');
fprintf('Calculated Threshold: %f \nSuccess Rate: %f \n \n',T,success);

%% validate the classifier

% project the spectra from the testing data onto e
predData1 = testC1' * e;
predData2 = testC2' * e;

% visualize the predicted data for each class from the remaining test data
figure('NumberTitle', 'off', 'Name', 'Testing Data');
subplot(1,2,1);
histfit(predData1);
hold on;
histfit(predData2);
hold off;
title('Test Data Histogram');

% generate an ROC on the testing data
minT = min([predData1 ; predData2]);
maxT = max([predData1 ; predData2]);
rng = linspace(minT,maxT,500);

% initialize vectors to plot fit
plot1 = zeros(size(rng));
plot2 = zeros(size(rng));

i = 1;
% loop over each possible threshold
for possibleThreshold = rng
    % calculate fit for class 1
    ind = find(predData1 <= possibleThreshold);
    plot1(i) = 100*length(ind)/length(testC1);
    
    % calculate fit for class 2
    ind = find(predData2 > possibleThreshold);
    plot2(i) = 100*length(ind)/length(testC2);
    i = i + 1;
end

% plot the ROC curves
subplot(1,2,2);
plot(rng,plot1);
hold on;
plot(rng,plot2);
hold off;

% label graph
xlabel('Thresholds');
ylabel('Success Rate');
legend('C1','C2');
title('Receiver Operating Curve of Testing Data');

% calculate the intersection of the ROC curves by determining the index at
% which the sum of each individual point is maximum
newSums = plot1 + plot2;
[newTopSum,newTopIndex] = max(newSums);

% grab the threshold at the index of the maximum sum
newT = rng(newTopIndex);

% calculate the success rates
successNewT = mean([plot1(newTopIndex) plot2(newTopIndex)]);
successOldT = mean([plot1(topIndex) plot2(topIndex)]);

fprintf('TESTING DATA \n');
fprintf('Calculated Threshold: %f \nSuccess Rate at Calculated Threshold: %f \n',newT,successNewT);
fprintf('Success Rate at Training Threshold: %f \n',successOldT);
