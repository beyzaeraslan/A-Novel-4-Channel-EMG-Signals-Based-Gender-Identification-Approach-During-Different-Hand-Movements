clc;
clear;

tic; % Start time measurement

% Veriyi yükleme
load('all_female_rms_first_move_matrix'); 
load('all_male_rms_first_move_matrix');

% Etiketleme
label_female = ones(length(all_female_rms_first_move_matrix), 1);
label_male = ones(length(all_male_rms_first_move_matrix), 1) * 2;
label = [label_female; label_male];


veri = [all_female_rms_first_move_matrix; all_male_rms_first_move_matrix];


kVals = 1:10;
acc = zeros(size(kVals));
precisionVals = zeros(size(kVals));
recallVals = zeros(size(kVals));
f1Vals = zeros(size(kVals));
aucVals = zeros(size(kVals));


K = 5;
cv = cvpartition(label, 'KFold', K);


for kIndex = 1:length(kVals)
    tempAcc = zeros(K, 1);
    tempPrecision = zeros(K, 1);
    tempRecall = zeros(K, 1);
    tempF1 = zeros(K, 1);
    tempAUC = zeros(K, 1);

    for i = 1:K
        trainData = veri(training(cv, i), :);
        trainLabels = label(training(cv, i));
        testData = veri(test(cv, i), :);
        testLabels = label(test(cv, i));

        model = fitcknn(trainData, trainLabels, 'NumNeighbors', kVals(kIndex));
        [pred, score] = predict(model, testData);

        tempAcc(i) = sum(pred == testLabels) / length(testLabels);

        confMat = confusionmat(testLabels, pred);
        precision = confMat(2,2) / (confMat(2,2) + confMat(1,2));
        recall = confMat(2,2) / (confMat(2,2) + confMat(2,1));
        f1 = 2 * (precision * recall) / (precision + recall);

        [~, ~, ~, AUC] = perfcurve(testLabels, score(:,2), 2);

        tempPrecision(i) = precision;
        tempRecall(i) = recall;
        tempF1(i) = f1;
        tempAUC(i) = AUC;
    end

    acc(kIndex) = mean(tempAcc);
    precisionVals(kIndex) = mean(tempPrecision);
    recallVals(kIndex) = mean(tempRecall);
    f1Vals(kIndex) = mean(tempF1);
    aucVals(kIndex) = mean(tempAUC);

    % Yazdırma
    fprintf('k = %d\n', kVals(kIndex));
    fprintf('Doğruluk: %.2f%%\n', acc(kIndex)*100);
    fprintf('Precision: %.2f%%\n', precisionVals(kIndex)*100);
    fprintf('Recall: %.2f%%\n', recallVals(kIndex)*100);
    fprintf('F1 Score: %.2f\n', f1Vals(kIndex)*100);
    fprintf('AUC: %.2f\n', aucVals(kIndex));
    fprintf('--------------------------\n');
end

% Graphing other metrics
figure;
plot(kVals, precisionVals * 100, '-o', 'LineWidth', 2);
hold on;
plot(kVals, recallVals * 100, '-s', 'LineWidth', 2);
plot(kVals, f1Vals * 100, '-^', 'LineWidth', 2);
plot(kVals, aucVals * 100, '-x', 'LineWidth', 2);
title('Performance Metrics by k – Rest Movement');
xlabel('Number of Neighbors (k)','FontWeight', 'bold', 'FontSize', 12);
ylabel('Performance Metric (%)','FontWeight', 'bold', 'FontSize', 12);
legend('Precision', 'Recall', 'F1 Score', 'AUC');
grid on;

toc; % Time measurement finish

