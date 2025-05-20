clc;
clear;

tic; % Start timing

%% ========================== Data Loading ================================
% Load preprocessed RMS features for the first movement
load('all_female_rms_first_move_matrix'); 
load('all_male_rms_first_move_matrix');

%% ========================== Label Assignment ============================
% Assign class labels: 1 for female, 2 for male
label_female = ones(length(all_female_rms_first_move_matrix), 1);
label_male   = ones(length(all_male_rms_first_move_matrix), 1) * 2;

% Combine data and labels
data   = [all_female_rms_first_move_matrix; all_male_rms_first_move_matrix];
labels = [label_female; label_male];

%% ========================== KNN Evaluation =============================
% Range of k-values (number of neighbors)
kVals = 1:10;

% Initialize performance metric vectors
acc           = zeros(size(kVals));
precisionVals = zeros(size(kVals));
recallVals    = zeros(size(kVals));
f1Vals        = zeros(size(kVals));
aucVals       = zeros(size(kVals));

% Set up 5-Fold Cross-Validation
K = 5;
cv = cvpartition(labels, 'KFold', K);

% Loop over different k values
for kIndex = 1:length(kVals)
    tempAcc      = zeros(K, 1);
    tempPrecision= zeros(K, 1);
    tempRecall   = zeros(K, 1);
    tempF1       = zeros(K, 1);
    tempAUC      = zeros(K, 1);

    % Cross-validation loop
    for i = 1:K
        % Split data into training and test sets
        trainData   = data(training(cv, i), :);
        trainLabels = labels(training(cv, i));
        testData    = data(test(cv, i), :);
        testLabels  = labels(test(cv, i));

        % Train KNN classifier with current k value
        model = fitcknn(trainData, trainLabels, 'NumNeighbors', kVals(kIndex));
        [predicted, scores] = predict(model, testData);

        % Accuracy
        tempAcc(i) = sum(predicted == testLabels) / length(testLabels);

        % Confusion matrix and metrics
        confMat = confusionmat(testLabels, predicted);
        precision = confMat(2,2) / (confMat(2,2) + confMat(1,2));
        recall    = confMat(2,2) / (confMat(2,2) + confMat(2,1));
        f1        = 2 * (precision * recall) / (precision + recall);
        [~, ~, ~, auc] = perfcurve(testLabels, scores(:,2), 2);  % AUC for class 2

        % Store metrics
        tempPrecision(i) = precision;
        tempRecall(i)    = recall;
        tempF1(i)        = f1;
        tempAUC(i)       = auc;
    end

    % Average performance across folds
    acc(kIndex)           = mean(tempAcc);
    precisionVals(kIndex) = mean(tempPrecision);
    recallVals(kIndex)    = mean(tempRecall);
    f1Vals(kIndex)        = mean(tempF1);
    aucVals(kIndex)       = mean(tempAUC);

    % Display current k results
    fprintf('k = %d\n', kVals(kIndex));
    fprintf('Accuracy: %.2f%%\n', acc(kIndex)*100);
    fprintf('Precision: %.2f%%\n', precisionVals(kIndex)*100);
    fprintf('Recall: %.2f%%\n', recallVals(kIndex)*100);
    fprintf('F1 Score: %.2f\n', f1Vals(kIndex)*100);
    fprintf('AUC: %.2f\n', aucVals(kIndex));
    fprintf('--------------------------\n');
end

%% ========================== Plotting Metrics ===========================

figure;
plot(kVals, precisionVals * 100, '-o', 'LineWidth', 2);
hold on;
plot(kVals, recallVals * 100, '-s', 'LineWidth', 2);
plot(kVals, f1Vals * 100, '-^', 'LineWidth', 2);
plot(kVals, aucVals * 100, '-x', 'LineWidth', 2);
title('Performance Metrics vs. k – First Hand Movement');
xlabel('Number of Neighbors (k)', 'FontWeight', 'bold', 'FontSize', 12);
ylabel('Performance (%)', 'FontWeight', 'bold', 'FontSize', 12);
legend('Precision', 'Recall', 'F1 Score', 'AUC');
grid on;

toc; % End timing
