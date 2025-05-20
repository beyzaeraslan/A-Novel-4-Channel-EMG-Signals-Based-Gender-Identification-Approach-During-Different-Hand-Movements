% This section will be modified for each movement separately, 
% as the goal is to perform gender classification based on specific hand movements.
% For example, we will first load and train on the data from the first movement 
% for both male and female subjects, then repeat the process for the second movement,
% and so on, up to the tenth movement.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In addition, classification will also be performed by comparing the first 
% and last cycles of each movement separately.
% For that purpose, data is loaded as follows (example for the second movement):
% load('all_female_rms_second_move_matrix.mat')

clc;
clear;

%% ====================== Data Loading ===========================
load('all_female_rms_second_move_matrix.mat'); 
load('all_male_rms_second_move_matrix.mat');

% For cycle-based comparisons, you can replace the lines above with:
% load('all_female_rms_second_move_matrix.mat')
% load('all_male_rms_second_move_matrix_last_cycle.mat')

%% ====================== Label Assignment ===========================
% 1 = female, 2 = male
label_female = ones(length(all_female_rms_second_move_matrix), 1);
label_male   = ones(length(all_male_rms_second_move_matrix), 1) * 2;
label        = [label_female; label_male];

% Combine female and male data into one matrix
data = [all_female_rms_second_move_matrix; all_male_rms_second_move_matrix];

%% ====================== Cross-Validation Setup ===========================
K = 5;  % Number of folds
cv = cvpartition(label, 'KFold', K);
accuracy = zeros(K, 1);  % Accuracy storage

tic; % Start timing

for i = 1:K
    % Split data into training and testing
    trainData   = data(training(cv, i), :);
    trainLabels = label(training(cv, i));
    testData    = data(test(cv, i), :);
    testLabels  = label(test(cv, i));
    
    % Train Decision Tree model
    treeModel = fitctree(trainData, trainLabels);
    
    % Predict on test data
    predictedLabels = predict(treeModel, testData);
    
    % Calculate accuracy for current fold
    accuracy(i) = sum(predictedLabels == testLabels) / length(testLabels);
    
    fprintf('Fold %d Accuracy: %.2f%%\n', i, accuracy(i) * 100);
end

toc;

% Mean accuracy across all folds
meanAccuracy = mean(accuracy);
fprintf('Mean Accuracy: %.2f%%\n', meanAccuracy * 100);

%% ====================== Final Evaluation ===========================

% Evaluate the last fold again for confusion matrix and metrics
testData    = data(test(cv, K), :);
testLabels  = label(test(cv, K));
[predictedLabels, score] = predict(treeModel, testData);

% Confusion Matrix
confMat = confusionmat(testLabels, predictedLabels);
disp('Confusion Matrix:');
disp(confMat);

%% ====================== Additional Metrics ===========================

% Calculate Precision, Recall, F1 Score
precision = confMat(2,2) / (confMat(2,2) + confMat(1,2));
recall    = confMat(2,2) / (confMat(2,2) + confMat(2,1));
f1Score   = 2 * (precision * recall) / (precision + recall);

fprintf('Precision: %.2f%%\n', precision * 100);
fprintf('Recall: %.2f%%\n', recall * 100);
fprintf('F1 Score: %.2f\n', f1Score * 100);

%% ====================== ROC Curve & AUC ===========================

% Compute ROC curve and AUC (assuming class '2' = male is the positive class)
[X, Y, T, AUC] = perfcurve(testLabels, score(:, 2), 2);

% Plot ROC Curve
figure;
plot(X, Y, 'LineWidth', 2);
xlabel('False Positive Rate');
ylabel('True Positive Rate');
title('ROC Curve – Second Movement');
grid on;
fprintf('AUC: %.2f\n', AUC);
