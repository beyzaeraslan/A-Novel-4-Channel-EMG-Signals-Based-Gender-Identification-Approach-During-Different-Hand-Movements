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
% load('all_female_rms_last_move_matrix_last_cycle.mat')
% Each movement will be trained and evaluated individually using these files.


clc;
clear;

load('all_female_rms_second_move_matrix'); 
load('all_male_rms_second_move_matrix');

% load('all_female_rms_second_move_matrix.mat')
% load('all_male_rms_second_move_matrix_last_cycle.mat')


% label
label_female = ones(length(all_female_rms_second_move_matrix), 1);
label_male = ones(length(all_male_rms_second_move_matrix), 1) * 2;

label = [label_female; label_male];

% Combining data and labels
veri = [all_female_rms_second_move_matrix; all_male_rms_second_move_matrix];
veri_label = [veri label];

%K-Fold cross validation settings
K = 5; % K kat sayısı
cv = cvpartition(label, 'KFold', K);


accuracy = zeros(K, 1); 
tic;
for i = 1:K
    %Separating training and test data
    trainData = veri(training(cv, i), :);
    trainLabels = label(training(cv, i));
    testData = veri(test(cv, i), :);
    testLabels = label(test(cv, i));
    
   % Creating and training the Decision Tree model
treeModel = fitctree(trainData, trainLabels);

% Making predictions on test data
predictedLabels = predict(treeModel, testData);

% Evaluating the performance of the model
accuracy = sum(predictedLabels == testLabels) / length(testLabels);
fprintf('Decision Tree Ortalama Doğruluk: %.2f%%\n', accuracy * 100);

end
toc;
% Ortalama doğruluk
meanAccuracy = mean(accuracy);
fprintf('Ortalama Doğruluk: %.2f%%\n', meanAccuracy * 100);

% Son katmanın test verileri üzerinde performansını değerlendirme
testData = veri(test(cv, K), :);
testLabels = label(test(cv, K));
predictedLabels = predict(treeModel, testData);

% Confusion matrix oluşturma
confMat = confusionmat(testLabels, predictedLabels);
disp('Confusion Matrix:');
disp(confMat);

% Confusion matrix oluşturma
confMat = confusionmat(testLabels, predictedLabels);
disp('Confusion Matrix:');
disp(confMat);


% Calculating other performance metrics
precision = confMat(2,2) / (confMat(2,2) + confMat(1,2)); % Pozitif sınıfın hassasiyeti
recall = confMat(2,2) / (confMat(2,2) + confMat(2,1)); % Pozitif sınıfın hatırlama oranı
f1Score = 2 * (precision * recall) / (precision + recall);

fprintf('Hassasiyet: %.2f%%\n', precision * 100);
fprintf('Hatalama Oranı: %.2f%%\n', recall * 100);
fprintf('F1 Skoru: %.2f\n', f1Score*100);

% Model tahmin olasılıklarını alıyoruz (iki sınıflı tahminler için)
[~, score] = predict(treeModel, testData);

% ROC curve and AUC calculation
% Here '1' is assumed as the label of positive class, change it if different
[X, Y, T, AUC] = perfcurve(testLabels, score(:, 2), 2);

% ROC eğrisini çizme
figure;
plot(X, Y, 'LineWidth', 2);
xlabel('False Positive Rate');
ylabel('True Positive Rate');
title('ROC Curve - Pronation Movement');
fprintf('AUC: %.2f\n', AUC);



