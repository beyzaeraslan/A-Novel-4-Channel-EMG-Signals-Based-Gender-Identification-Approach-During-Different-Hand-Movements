% Veriyi yükleme
load('all_male_rms');
load('all_female_rms');

% Etiket oluşturma
label_female = ones(length(all_female_rms), 1);
label_male = ones(length(all_male_rms), 1) * 2;

label = [label_female; label_male];

% Veriyi ve etiketleri birleştirme
veri = [all_female_rms; all_male_rms];
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

% Diğer performans metriklerini hesaplama
precision = confMat(2,2) / (confMat(2,2) + confMat(1,2)); % Pozitif sınıfın hassasiyeti
recall = confMat(2,2) / (confMat(2,2) + confMat(2,1)); % Pozitif sınıfın hatırlama oranı
f1Score = 2 * (precision * recall) / (precision + recall);

fprintf('Hassasiyet: %.2f%%\n', precision * 100);
fprintf('Hatalama Oranı: %.2f%%\n', recall * 100);
fprintf('F1 Skoru: %.2f\n', f1Score);

% Model tahmin olasılıklarını alıyoruz (iki sınıflı tahminler için)
[~, score] = predict(treeModel, testData);

% ROC eğrisi ve AUC hesaplama
% Burada '1' pozitif sınıfın etiketi olarak varsayılmıştır, eğer farklıysa bunu değiştirin
[X, Y, T, AUC] = perfcurve(testLabels, score(:, 2), 2);

% ROC eğrisini çizme
figure;
plot(X, Y);
xlabel('False Positive Rate');
ylabel('True Positive Rate');
title('ROC Eğrisi');
fprintf('AUC: %.2f\n', AUC);