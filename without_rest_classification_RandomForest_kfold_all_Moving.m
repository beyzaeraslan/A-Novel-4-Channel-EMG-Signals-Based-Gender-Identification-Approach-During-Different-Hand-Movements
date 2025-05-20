% This section will be modified for each movement individually,
% since the goal is to perform gender classification based on different hand movements.
% For example, we will load and train the model using the first movement data of female and male subjects,
% then proceed with the second movement, and continue this process up to the tenth movement.

clc;
clear;
% 
load('all_female_rms_fifth_move_matrix'); 
load('all_male_rms_fifth_move_matrix');

% load('all_female_rms_fifth_move_matrix.mat')
% load('all_male_rms_fifth_move_matrix.mat')

% Etiket oluşturma
label_female = ones(length(all_female_rms_fifth_move_matrix), 1);
label_male = ones(length(all_male_rms_fifth_move_matrix), 1) * 2;

label = [label_female; label_male];

% Veriyi ve etiketleri birleştirme
veri = [all_female_rms_fifth_move_matrix; all_male_rms_fifth_move_matrix];
veri_label = [veri label];

% K-Fold çapraz doğrulama ayarları
K = 5; % K kat sayısı
cv = cvpartition(label, 'KFold', K);

% K-Fold çapraz doğrulama
accuracy = zeros(K, 1); % Doğrulukları saklamak için bir vektör

 tic; %// zaman kodu

for i = 1:K
    % Eğitim ve test verilerini ayırma
    trainData = veri(training(cv, i), :);
    trainLabels = label(training(cv, i));
    testData = veri(test(cv, i), :);
    testLabels = label(test(cv, i));
    
    % Random Forest modelini oluşturma ve eğitme
    numTrees = 100; % Ağaç sayısı
    rfModel = TreeBagger(numTrees, trainData, trainLabels, 'OOBPrediction', 'On', 'Method', 'classification');
    
    % Test verisi üzerinde tahmin yapma
    [predictedLabels, scores] = predict(rfModel, testData);
    predictedLabels = str2double(predictedLabels); % Etiketleri sayısal forma dönüştürme
    
    % Modelin performansını değerlendirme
    accuracy(i) = sum(predictedLabels == testLabels) / length(testLabels);
  
end
 toc ;
% Ortalama doğruluk
meanAccuracy = mean(accuracy);
fprintf('Ortalama Doğruluk: %.2f%%\n', meanAccuracy * 100);

% Son katmanın test verileri üzerinde performansını değerlendirme
testData = veri(test(cv, K), :);
testLabels = label(test(cv, K));
[predictedLabels, scores] = predict(rfModel, testData);
predictedLabels = str2double(predictedLabels);

% Confusion matrix oluşturma
confMat = confusionmat(testLabels, predictedLabels);
disp('Confusion Matrix:');
disp(confMat);

% % Confusion matrix çizme
% figure;
% confusionchart(testLabels, predictedLabels);
% title('Confusion Matrix');

% Confusion matrix çizme
figure;
confMatChart = confusionchart(testLabels, predictedLabels);
confMatChart.Title = 'Confusion Matrix –  Pronation Movement';
confMatChart.ColumnSummary = 'column-normalized';
confMatChart.RowSummary = 'row-normalized';
confMatChart.FontSize = 12; % Yazı tipi boyutunu ayarlamak için

% Diğer performans metriklerini hesaplama
precision = confMat(2,2) / (confMat(2,2) + confMat(1,2)); % Pozitif sınıfın hassasiyeti
recall = confMat(2,2) / (confMat(2,2) + confMat(2,1)); % Pozitif sınıfın hatırlama oranı
f1Score = 2 * (precision * recall) / (precision + recall);

fprintf('Hassasiyet: %.2f%%\n', precision * 100);
fprintf('Hatalama Oranı: %.2f%%\n', recall * 100);
fprintf('F1 Skoru: %.2f\n', f1Score*100);

% ROC eğrisi ve AUC hesaplama
% Burada '2' pozitif sınıfın etiketi olarak varsayılmıştır, eğer farklıysa bunu değiştirin
[X, Y, T, AUC] = perfcurve(testLabels, scores(:, 2), 2);

% ROC eğrisini çizme
figure;
plot(X, Y);
xlabel('False Positive Rate');
ylabel('True Positive Rate');
title('ROC Curve');
fprintf('AUC: %.2f\n', AUC);