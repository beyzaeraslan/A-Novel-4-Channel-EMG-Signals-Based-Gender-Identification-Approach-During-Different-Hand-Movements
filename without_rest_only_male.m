% This script processes publicly available EMG data obtained from an online source.
% Data from 20 individual male subjects were separately loaded and stored as:
% combined_features_1, combined_features_2, ..., combined_features_20.
%
% All individual datasets were concatenated into a single variable named 'all_male'.
% Subsequently, RMS (Root Mean Square) features were extracted from the combined data.
%
% The resulting feature matrix was saved as 'all_male_rms.mat' for further analysis.

    % 1 cycle için
    data_1=data(1:208000,:);
    male_gesture_1= data_1(8000+1:20000,:);
    male_gesture_2= data_1(28000+1:40000,:);
    male_gesture_3= data_1(48000+1:60000,:);
    male_gesture_4= data_1(68000+1:80000,:);
    male_gesture_5= data_1(88000+1:100000,:);
    male_gesture_6= data_1(108000+1:120000,:);
    male_gesture_7= data_1(128000+1:140000,:);
    male_gesture_8= data_1(148000+1:160000,:);
    male_gesture_9= data_1(168000+1:180000,:);
    male_gesture_10= data_1(188000+1:200000,:)
    
    features_1=[male_gesture_1;male_gesture_2;male_gesture_3;male_gesture_4;male_gesture_5;male_gesture_6;male_gesture_7;male_gesture_8;male_gesture_9;male_gesture_10];
    
    
    % 2 cycle için
    data_2=data(268000:476000,:);
    male_gesture_1= data_2(8000+1:20000,:);
    male_gesture_2= data_2(28000+1:40000,:);
    male_gesture_3= data_2(48000+1:60000,:);
    male_gesture_4= data_2(68000+1:80000,:);
    male_gesture_5= data_2(88000+1:100000,:);
    male_gesture_6= data_2(108000+1:120000,:);
    male_gesture_7= data_2(128000+1:140000,:);
    male_gesture_8= data_2(148000+1:160000,:);
    male_gesture_9= data_2(168000+1:180000,:);
    male_gesture_10= data_2(188000+1:200000,:);
    
    features_2=[male_gesture_1;male_gesture_2;male_gesture_3;male_gesture_4;male_gesture_5;male_gesture_6;male_gesture_7;male_gesture_8;male_gesture_9;male_gesture_10];
     % 3 cycle için
    data_3=data(536000:744000,:);
    male_gesture_1= data_3(8000+1:20000,:);
    male_gesture_2= data_3(28000+1:40000,:);
    male_gesture_3= data_3(48000+1:60000,:);
    male_gesture_4= data_3(68000+1:80000,:);
    male_gesture_5= data_3(88000+1:100000,:);
    male_gesture_6= data_3(108000+1:120000,:);
    male_gesture_7= data_3(128000+1:140000,:);
    male_gesture_8= data_3(148000+1:160000,:);
    male_gesture_9= data_3(168000+1:180000,:);
    male_gesture_10= data_3(188000+1:200000,:);
    
    features_3=[male_gesture_1;male_gesture_2;male_gesture_3;male_gesture_4;male_gesture_5;male_gesture_6;male_gesture_7;male_gesture_8;male_gesture_9;male_gesture_10];
    
    % 4 cycle için
    data_4=data(804000:1012000,:);
    male_gesture_1= data_4(8000+1:20000,:);
    male_gesture_2= data_4(28000+1:40000,:);
    male_gesture_3= data_4(48000+1:60000,:);
    male_gesture_4= data_4(68000+1:80000,:);
    male_gesture_5= data_4(88000+1:100000,:);
    male_gesture_6= data_4(108000+1:120000,:);
    male_gesture_7= data_4(128000+1:140000,:);
    male_gesture_8= data_4(148000+1:160000,:);
    male_gesture_9= data_4(168000+1:180000,:);
    male_gesture_10= data_4(188000+1:200000,:);
    
    features_4=[male_gesture_1;male_gesture_2;male_gesture_3;male_gesture_4;male_gesture_5;male_gesture_6;male_gesture_7;male_gesture_8;male_gesture_9;male_gesture_10];
    
     % 5 cycle için
    data_5=data(1072000:1280000,:);
    male_gesture_1= data_5(8000+1:20000,:);
    male_gesture_2= data_5(28000+1:40000,:);
    male_gesture_3= data_5(48000+1:60000,:);
    male_gesture_4= data_5(68000+1:80000,:);
    male_gesture_5= data_5(88000+1:100000,:);
    male_gesture_6= data_5(108000+1:120000,:);
    male_gesture_7= data_5(128000+1:140000,:);
    male_gesture_8= data_5(148000+1:160000,:);
    male_gesture_9= data_5(168000+1:180000,:);
    male_gesture_10= data_5(188000+1:200000,:)
    
   features_5=[male_gesture_1;male_gesture_2;male_gesture_3;male_gesture_4;male_gesture_5;male_gesture_6;male_gesture_7;male_gesture_8;male_gesture_9;male_gesture_10];
    
   all_features=[features_1 ;features_2;features_3;features_4;features_5];
    
    combined_features_20 = all_features;
    save combined_features_20 combined_features_20
    clear;



% To better analyze the effect of specific hand movements on gender classification,
% all signals labeled as 'rest' (i.e., during non-movement periods) have been excluded from the dataset.
% The analysis is thus limited to active gesture data only.

all_male=[combined_features_1 ; combined_features_2 ;combined_features_3;combined_features_4;combined_features_5;combined_features_6;combined_features_7;combined_features_8 ;combined_features_9 ; combined_features_10;combined_features_11 ; combined_features_12 ;combined_features_13;combined_features_14;combined_features_15;combined_features_16;combined_features_17;combined_features_18 ;combined_features_19 ; combined_features_20];

% feature extraction
k=1;
pu_zaman = 100; % milisecond
fs = 2000;
pu = (fs*pu_zaman)/1000;
for i = 1:4
    for j = 1:pu:size(all_male)
        pencere = all_male(j:j+pu-1, i);
        feat = rms(pencere);
        feature(k,i) = feat;
        k = k + 1;       
    end
    k=1;
  end
 


