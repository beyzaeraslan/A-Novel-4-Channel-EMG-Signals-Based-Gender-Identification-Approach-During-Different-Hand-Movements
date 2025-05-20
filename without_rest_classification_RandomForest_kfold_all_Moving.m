% This section will be modified for each movement individually,
% as the aim is to perform gender classification based on distinct hand gestures.
% For each gesture, corresponding male and female datasets are loaded,
% and classification is performed using a Random Forest model with 5-fold cross-validation.

clc;
clear;

% Load the RMS feature matrices for the fifth hand gesture
load('all_female_rms_fifth_move_matrix'); 
load('all_male_rms_fifth_move_matrix');

% Assign class labels: 1 for female, 2 for male
label_female = ones(length(all_female_rms_fifth_move_matrix), 1);
label_male   = ones(length(all_male_rms_fifth_move_matrix), 1) * 2;

% Concatenate data and labels
label = [label_female; label_male];
data  = [all_female_rms_fifth_move_matrix; all_male_rms_fifth_move_matrix];
data_with_labels = [data label];

% Set K-Fold cross-validation parameters
K = 5;
cv = cvpartition(label, 'KFold', K);

% Initialize accuracy vector
accuracy = zeros(K, 1);

% Start timing the classification process
tic;

% Perform K-Fold cross-validation
for i = 1:K
    % Split data into training and testing sets
    trainData   = data(training(cv, i), :);
    trainLabels = label(training(cv, i));
    testData    = data(test(cv, i), :);
    testLabels  = label(test(cv, i));
    
    % Train Random Forest classifier
    numTrees = 100;
    rfModel = TreeBagger(numTrees, trainData, trainLabels, ...
                         'OOBPrediction', 'On', ...
                         'Method', 'classification');
    
    % Predict test data
    [predictedLabels, scores] = predict(rfModel, testData);
    predictedLabels = str2double(predictedLabels);  % Convert to numeric
    
    % Calculate accuracy
    accuracy(i) = sum(predictedLabels == testLabels) / length(testLabels);
end

% Stop timing
toc;

% Display mean accuracy
meanAccuracy = mean(accuracy);
fprintf('Mean Accuracy: %.2f%%\n', meanAccuracy * 100);

% Evaluate model performance on the last fold's test set
testData    = data(test(cv, K), :);
testLabels  = label(test(cv, K));
[predictedLabels, scores] = predict(rfModel, testData);
predictedLabels = str2double(predictedLabels);

% Confusion Matrix
confMat = confusionmat(testLabels, predictedLabels);
disp('Confusion Matrix:');
disp(confMat);

% Plot Confusion Matrix
figure;
confMatChart = confusionchart(testLabels, predictedLabels);
confMatChart.Title = 'Confusion Matrix – Fifth Gesture';
confMatChart.ColumnSummary = 'column-normalized';
confMatChart.RowSummary = 'row-normalized';
confMatChart.FontSize = 12;

% Compute additional performance metrics
precision = confMat(2,2) / (confMat(2,2) + confMat(1,2));  % Precision (Positive Predictive Value)
recall    = confMat(2,2) / (confMat(2,2) + confMat(2,1));  % Recall (Sensitivity)
f1Score   = 2 * (precision * recall) / (precision + recall);

fprintf('Precision: %.2f%%\n', precision * 100);
fprintf('Recall: %.2f%%\n', recall * 100);
fprintf('F1 Score: %.2f\n', f1Score * 100);

% Compute and plot ROC curve and AUC
% Class '2' (male) is considered the positive class here
[X, Y, T, AUC] = perfcurve(testLabels, scores(:, 2), 2);

figure;
plot(X, Y);
xlabel('False Positive Rate');
ylabel('True Positive Rate');
title('ROC Curve');
fprintf('AUC: %.2f\n', AUC);
