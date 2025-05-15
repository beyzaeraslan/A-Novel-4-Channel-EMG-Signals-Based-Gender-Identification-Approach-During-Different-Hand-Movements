%önce birinci hareketin ilk cycle nı male-female olarak eğit
%sonra birinci hareketin son cycle nı male-female olarak eğit
%sonra onuncu hareketin ilk cyclenını male- female olarak eğit
%sonra onuncu hareketin son cyclenını male-female olarak eğit
%last movement->10. hareket

clc;
clear;
%%
%1
% load('all_female_rms_first_cycle_first_movement'); 
% load('all_male_rms_first_cycle_first_movement');

%%
%2
% % 
% load('all_female_rms_last_cycle_first_movement'); 
% load('all_male_rms_last_cycle_first_movement');
%%
% %3
% % 
% load('all_female_rms_first_cycle_last_movement'); 
% load('all_male_rms_first_cycle_last_movement');
% % % 
% %%
% %4
% % 
load('all_female_rms_last_cycle_last_movement'); 
load('all_male_rms_last_cycle_last_movement');
%%

% Etiket oluşturma
label_female = ones(length(all_female_rms_last_cycle_last_movement), 1);
label_male = ones(length(all_male_rms_last_cycle_last_movement), 1) * 2;

label = [label_female; label_male];

% Veriyi ve etiketleri birleştirme
veri = [all_female_rms_last_cycle_last_movement; all_male_rms_last_cycle_last_movement];
veri_label = [veri label];

% K-Fold çapraz doğrulama ayarları
K = 5; % K kat sayısı
cv = cvpartition(label, 'KFold', K);

% K-Fold çapraz doğrulama
accuracy = zeros(K, 1); % Doğrulukları saklamak için bir vektör
tic;
for i = 1:K
    % Eğitim ve test verilerini ayırma
    trainData = veri(training(cv, i), :);
    trainLabels = label(training(cv, i));
    testData = veri(test(cv, i), :);
    testLabels = label(test(cv, i));
    
   % Decision Tree modelini oluşturma ve eğitme
treeModel = fitctree(trainData, trainLabels);

% Test verisi üzerinde tahmin yapma
predictedLabels = predict(treeModel, testData);

% Modelin performansını değerlendirme
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

% % Confusion matrix çizme
% figure;
% confusionchart(testLabels, predictedLabels);
% title('Confusion Matrix');

% Confusion matrix çizme
figure;
confMatChart = confusionchart(testLabels, predictedLabels);
confMatChart.Title = 'Confusion Matrix - Rest Movement';
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

% Model tahmin olasılıklarını alıyoruz (iki sınıflı tahminler için)
[~, score] = predict(treeModel, testData);

% ROC eğrisi ve AUC hesaplama
% Burada '1' pozitif sınıfın etiketi olarak varsayılmıştır, eğer farklıysa bunu değiştirin
[X, Y, T, AUC] = perfcurve(testLabels, score(:, 2), 2);

% ROC eğrisini çizme
figure;
plot(X, Y, 'LineWidth', 2);
xlabel('False Positive Rate');
ylabel('True Positive Rate');
title('ROC Curve - Rest Movement');
fprintf('AUC: %.2f\n', AUC);



