% First, train the model using the first cycle of the first movement for both male and female subjects.
% Then, train using the last cycle of the first movement (male vs. female).
% Next, train using the first cycle of the tenth movement (male vs. female).
% Finally, train using the last cycle of the tenth movement (male vs. female).
% Note: "Last movement" refers to the 10th hand movement in this context.

clc;
clear;

%% ====================================
% Load one of the following movement/cycle combinations:
% 1. First cycle, first movement
load('all_female_rms_first_cycle_first_movement.mat'); 
load('all_male_rms_first_cycle_first_movement.mat');

% 2. Last cycle, first movement
% load('all_female_rms_last_cycle_first_movement.mat'); 
% load('all_male_rms_last_cycle_first_movement.mat');

% 3. First cycle, last (10th) movement
% load('all_female_rms_first_cycle_last_movement.mat'); 
% load('all_male_rms_first_cycle_last_movement.mat');

% 4. Last cycle, last (10th) movement
% load('all_female_rms_last_cycle_last_movement.mat'); 
% load('all_male_rms_last_cycle_last_movement.mat');

%% ====================================
% Label assignment: 1 = female, 2 = male
label_female = ones(length(all_female_rms_first_cycle_first_movement), 1);
label_male   = ones(length(all_male_rms_first_cycle_first_movement), 1) * 2;
labels = [label_female; label_male];

% Combine data
data = [all_female_rms_first_cycle_first_movement; all_male_rms_first_cycle_first_movement];

%% ====================================
% K-Fold Cross-Validation setup
K = 5;
cv = cvpartition(labels, 'KFold', K);
accuracy = zeros(K, 1);

% Start timer
tic;

for i = 1:K
    % Partition the data
    trainData   = data(training(cv, i), :);
    trainLabels = labels(training(cv, i));
    testData    = data(test(cv, i), :);
    testLabels  = labels(test(cv, i));
    
    % Train the KNN model
    k = 3;  % Number of neighbors
    knnModel = fitcknn(trainData, trainLabels, 'NumNeighbors', k);
    
    % Predict on test set
    predictedLabels = predict(knnModel, testData);
    
    % Calculate accuracy
    accuracy(i) = sum(predictedLabels == testLabels) / length(testLabels);
end

% End timer
toc;

% Print mean accuracy
meanAccuracy = mean(accuracy);
fprintf('Mean Accuracy: %.2f%%\n', meanAccuracy * 100);

%% ====================================
% Final evaluation on the last fold
testData    = data(test(cv, K), :);
testLabels  = labels(test(cv, K));
[predictedLabels, score] = predict(knnModel, testData);

% Confusion matrix
confMat = confusionmat(testLabels, predictedLabels);
disp('Confusion Matrix:');
disp(confMat);

% Additional performance metrics
precision = confMat(2,2) / (confMat(2,2) + confMat(1,2));  % Positive Predictive Value
recall    = confMat(2,2) / (confMat(2,2) + confMat(2,1));  % Sensitivity
f1Score   = 2 * (precision * recall) / (precision + recall);

fprintf('Precision: %.2f%%\n', precision
