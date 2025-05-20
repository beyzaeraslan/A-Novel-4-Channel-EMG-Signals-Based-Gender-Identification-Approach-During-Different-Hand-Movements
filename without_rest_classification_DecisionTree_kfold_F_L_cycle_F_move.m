% First, train a gender classification model using the first cycle of the first movement (male vs. female).
% Then, train using the last cycle of the first movement (male vs. female).
% Next, train using the first cycle of the tenth movement (male vs. female).
% Finally, train using the last cycle of the tenth movement (male vs. female).
% Note: "Last movement" refers to the tenth hand movement in this context.

clc;
clear;

%%Select which movement-cycle combination to load
% 1. First cycle of the first movement
% load('all_female_rms_first_cycle_first_movement'); 
% load('all_male_rms_first_cycle_first_movement');

% 2. Last cycle of the first movement
% load('all_female_rms_last_cycle_first_movement'); 
% load('all_male_rms_last_cycle_first_movement');

% 3. First cycle of the tenth (last) movement
% load('all_female_rms_first_cycle_last_movement'); 
% load('all_male_rms_first_cycle_last_movement');

% 4. Last cycle of the tenth (last) movement
load('all_female_rms_last_cycle_last_movement'); 
load('all_male_rms_last_cycle_last_movement');

%% Label assignment: 1 = female, 2 = male
label_female = ones(length(all_female_rms_last_cycle_last_movement), 1);
label_male   = ones(length(all_male_rms_last_cycle_last_movement), 1) * 2;

label = [label_female; label_male];

% Combine data and labels
veri = [all_female_rms_last_cycle_last_movement; all_male_rms_last_cycle_last_movement];
veri_label = [veri label];

% K-Fold cross-validation settings
K = 5;
cv = cvpartition(label, 'KFold', K);
accuracy = zeros(K, 1);

tic;
for i = 1:K
    % Split data into training and testing sets
    trainData   = veri(training(cv, i), :);
    trainLabels = label(training(cv, i));
    testData    = veri(test(cv, i), :);
    testLabels  = label(test(cv, i));
    
    % Train the Decision Tree model
    treeModel = fitctree(trainData, trainLabels);

    % Predict labels on test set
    predictedLabels = predict(treeModel, testData);

    % Compute accuracy for this fold
    accuracy = sum(predictedLabels == testLabels) / length(testLabels);
    fprintf('Decision Tree Accuracy: %.2f%%\n', accuracy * 100);
end
toc;

% Report mean accuracy across folds
meanAccuracy = mean(accuracy);
fprintf('Mean Accuracy: %.2f%%\n', meanAccuracy * 100);

% Final evaluation using the last fold's test set
testData    = veri(test(cv, K), :);
testLabels  = label(test(cv, K));
predictedLabels = predict(treeModel, testData);

% Generate confusion matrix
confMat = confusionmat(testLabels, predictedLabels);
disp('Confusion Matrix:');
disp(confMat);

% Plot confusion matrix
confMatChart = confusionchart(testLabels, predictedLabels);
confMatChart.Title = 'Confusion Matrix - Rest Movement';
confMatChart.ColumnSummary = 'column-normalized';
confMatChart.RowSummary = 'row-normalized';
confMatChart.FontSize = 12;

% Compute additional performance metrics
precision = confMat(2,2) / (confMat(2,2) + confMat(1,2)); 
recall    = confMat(2,2) / (confMat(2,2) + confMat(2,1)); 
f1Score   = 2 * (precision * recall) / (precision + recall);

fprintf('Precision: %.2f%%\n', precision * 100);
fprintf('Recall: %.2f%%\n', recall * 100);
fprintf('F1 Score: %.2f\n', f1Score * 100);

% Obtain class scores (probabilities)
[~, score] = predict(treeModel, testData);

% Compute ROC curve and AUC
% Class '2' (male) is assumed as the positive class
[X, Y, T, AUC] = perfcurve(testLabels, score(:, 2), 2);

% Plot ROC curve
figure;
plot(X, Y, 'LineWidth', 2);
xlabel('False Positive Rate');
ylabel('True Positive Rate');
title('ROC Curve - Rest Movement');
fprintf('AUC: %.2f\n', AUC);
