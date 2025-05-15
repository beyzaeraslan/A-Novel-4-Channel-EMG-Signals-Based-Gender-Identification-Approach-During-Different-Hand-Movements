
% 1. Klasöre git
cd 'C:\Users\beyza\Desktop\GenderIdentification\Dataset\female'
 
% 2. Dosya isimlerini almak
dosyalar = dir('*.mat');

% 3. Özellikleri saklamak için boş bir yapı oluştur
combinedFeatures = [];

pu_zaman = 100; % milisaniye
fs = 2000;
pu = (fs*pu_zaman)/1000;

  
k=1;
for i = 1:length(dosyalar)
    dosyaIsmi = dosyalar(i).name;
    % Dosya içeriğini yükle
    dosya = load(dosyaIsmi);
    data=dosya.data; 
  for i = 1:4
    for j = 1:pu:size(data)
        pencere = data(j:j+pu-1, i);
        feat = rms(pencere);
        feature(k,i) = feat;
        k = k + 1;       
    end
    k=(length(feature)+1)-6400;
  end
 
k=length(feature)+1;
j=1;
i=1;

end

feature_of_female = feature;

save feature_of_female feature_of_female
% 
% % 4. Birleştirilmiş özellikleri bir .mat dosyasına kaydetmek
% outputFileName = 'combined_features.mat';
% save(outputFileName, 'combinedFeatures');