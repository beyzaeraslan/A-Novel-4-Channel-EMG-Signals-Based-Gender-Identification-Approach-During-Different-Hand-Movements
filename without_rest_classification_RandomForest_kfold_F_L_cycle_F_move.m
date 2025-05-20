% First, train the model using the first cycle of the first movement for both male and female subjects.
% Then, train the model using the last cycle of the first movement (male vs. female).
% Next, train using the first cycle of the tenth movement (male vs. female).
% Finally, train using the last cycle of the tenth movement (male vs. female).
% Note: "Last movement" refers to the 10th hand movement in this context.

clc;
clear;

%% ==== DATA LOADING SECTION ====

% NOTE:
% Uncomment the appropriate pair of files (female & male) for the desired experiment.
% Example: First cycle, first movement → first two lines
% Example: Last cycle, last movement → last two lines

% 1. First cycle, first movement
% load('all_female_rms_first_cycle_first_movement.mat'); 
% load('all_male_rms_first_cycle_first_movement.mat');

% 2. Last cycle, first movement
load('all_female_rms_last_cycle_first_movement.mat'); 
load('all_male_rms_last_cycle_first_movement.mat');

% 3. First cycle, last movement (10th)
% load('all_female_rms_first_cycle_last_movement.mat'); 
% load('all_male_rms_first_cycle_last_movement.mat');

% 4. Last cycle, last movement (10th)
load('all_female_rms_last_cycle_last_movement.mat'); 
load('all_male_rms_last_cycle_last_movement.mat');

%% ==== LABEL ASSIGNMENT ====

% Assign class labels: 1 for female, 2 for male
label_female = ones(length(all_female_rms_last_cycle_first_movement), 1);
label_male   = ones(length(all_male_rms_last_cycle_first_movement), 1) * 2;

% Combine data and labels
label = [label_female; label_male];
data  = [all_female_rms_last_cycle_first_movement; all_male_rms_last_cycle_first_movement];

%% ==== CROSS-VALIDATION SETUP ====

% 5-fold cross-validation
K = 5;
cv = cvpartition(label, 'KFold', K);
accuracy = zeros(K, 1);  % Accuracy for each fold

% Start timing
tic;

for i = 1:K
    % Partition data into training and testing sets
    trainData   = data(training(cv, i), :);
    trainLabels = label(training(cv, i));
    testData    = data(test(cv, i), :);
    testLabels  = label(test(cv, i));
    
    % Train Random Forest classifier
    numTrees = 100;
    rfModel = TreeBagger(numTrees, trainData, trainLabels, ...
                         'OOBPrediction', 'On', ...
                         'Method', 'classification');
    
    % Predict on test data
    [predictedLabels, scores] = predict(rfModel, testData);
    predictedLabels = str2double(predictedLabels);
    
    % Compute accuracy for current fold
    accuracy(i) = sum(predictedLabels == testLabels) / length(testLabels);
end

% Stop timing
toc;

% Mean accuracy across folds
meanAccuracy = mean(accuracy);
fprintf('Mean Accuracy: %.2f%%\n', meanAccuracy * 100);

%% ==== FINAL PERFORMANCE EVALUATION ====

% Evaluate performance on the test set of the last fold
testData    = data(test(cv, K), :);
testLabels  = label(test(cv, K));
[predictedLabels, scores] = predict(rfModel, testData);
predictedLabels = str2double(predictedLabels);

% Confusion matrix
confMat = confusionmat(testLabels, predictedLabels);
disp('Confusion Matrix:');
disp(confMat);

% Visualize confusion matrix
figure;
confMatChart = confusionchart(testLabels, predictedLabels);
confMatChart.Title = 'Confusion Matrix – Selected Movement';
confMatChart.ColumnSummary = 'column-normalized';
confMatChart.RowSummary = 'row-normalized';
confMatChart.FontSize = 12;

%% ==== ADDITIONAL METRICS ====

% Precision, Recall, F1-Score
precision = confMat(2,2) / (confMat(2,2) + confMat(1,2));
recall    = confMat(2,2) / (confMat(2,2) + confMat(2,1));
f1Score   = 2 * (precision * recall) / (precision + recall);

fprintf('Precision: %.2f%%\n', precision * 100);
fprintf('Recall: %.2f%%\n', recall * 100);
fprintf('F1 Score: %.2f\n', f1Score * 100);

%% ==== ROC CURVE & AUC ====

% Compute ROC curve and AUC
% Label '2' (male) is considered the positive class
[X, Y, T, AUC] = perfcurve(testLabels, scores(:, 2), 2);

% Plot ROC Curve
figure;
plot(X, Y);
xlabel('False Positive Rate');
ylabel('True Positive Rate');
title('ROC Curve');
fprintf('AUC: %.2f\n', AUC);
