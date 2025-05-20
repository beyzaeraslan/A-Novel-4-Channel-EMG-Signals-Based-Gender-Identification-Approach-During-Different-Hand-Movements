% This script processes publicly available EMG data obtained from an online source.
% Each subject performs 5 cycles, and each cycle contains 10 distinct hand gestures.
% Rest segments are excluded, and only active gesture segments are considered for analysis.

% 'data' is loaded manually from individual .mat files located in C:/female/ or C:/female/, each representing one subject.
    % ---- Cycle 1 ----
    data_1=data(1:208000,:);
    female_gesture_1= data_1(8000+1:20000,:);
    female_gesture_2= data_1(28000+1:40000,:);
    female_gesture_3= data_1(48000+1:60000,:);
    female_gesture_4= data_1(68000+1:80000,:);
    female_gesture_5= data_1(88000+1:100000,:);
    female_gesture_6= data_1(108000+1:120000,:);
    female_gesture_7= data_1(128000+1:140000,:);
    female_gesture_8= data_1(148000+1:160000,:);
    female_gesture_9= data_1(168000+1:180000,:);
    female_gesture_10= data_1(188000+1:200000,:)
    
    features_1=[female_gesture_1;female_gesture_2;female_gesture_3;female_gesture_4;female_gesture_5;female_gesture_6;female_gesture_7;female_gesture_8;female_gesture_9;female_gesture_10];
    
    
    % ---- Cycle 2 ----
    data_2=data(268000:476000,:);
    female_gesture_1= data_2(8000+1:20000,:);
    female_gesture_2= data_2(28000+1:40000,:);
    female_gesture_3= data_2(48000+1:60000,:);
    female_gesture_4= data_2(68000+1:80000,:);
    female_gesture_5= data_2(88000+1:100000,:);
    female_gesture_6= data_2(108000+1:120000,:);
    female_gesture_7= data_2(128000+1:140000,:);
    female_gesture_8= data_2(148000+1:160000,:);
    female_gesture_9= data_2(168000+1:180000,:);
    female_gesture_10= data_2(188000+1:200000,:);
    
    features_2=[female_gesture_1;female_gesture_2;female_gesture_3;female_gesture_4;female_gesture_5;female_gesture_6;female_gesture_7;female_gesture_8;female_gesture_9;female_gesture_10];
     
     % ---- Cycle 3 ---- 
    data_3=data(536000:744000,:);
    female_gesture_1= data_3(8000+1:20000,:);
    female_gesture_2= data_3(28000+1:40000,:);
    female_gesture_3= data_3(48000+1:60000,:);
    female_gesture_4= data_3(68000+1:80000,:);
    female_gesture_5= data_3(88000+1:100000,:);
    female_gesture_6= data_3(108000+1:120000,:);
    female_gesture_7= data_3(128000+1:140000,:);
    female_gesture_8= data_3(148000+1:160000,:);
    female_gesture_9= data_3(168000+1:180000,:);
    female_gesture_10= data_3(188000+1:200000,:);
    
    features_3=[female_gesture_1;female_gesture_2;female_gesture_3;female_gesture_4;female_gesture_5;female_gesture_6;female_gesture_7;female_gesture_8;female_gesture_9;female_gesture_10];
    
    % ---- Cycle 4 ---- 
    data_4=data(804000:1012000,:);
    female_gesture_1= data_4(8000+1:20000,:);
    female_gesture_2= data_4(28000+1:40000,:);
    female_gesture_3= data_4(48000+1:60000,:);
    female_gesture_4= data_4(68000+1:80000,:);
    female_gesture_5= data_4(88000+1:100000,:);
    female_gesture_6= data_4(108000+1:120000,:);
    female_gesture_7= data_4(128000+1:140000,:);
    female_gesture_8= data_4(148000+1:160000,:);
    female_gesture_9= data_4(168000+1:180000,:);
    female_gesture_10= data_4(188000+1:200000,:);
    
    features_4=[female_gesture_1;female_gesture_2;female_gesture_3;female_gesture_4;female_gesture_5;female_gesture_6;female_gesture_7;female_gesture_8;female_gesture_9;female_gesture_10];
    
    % ---- Cycle 5 ----
    data_5=data(1072000:1280000,:);
    female_gesture_1= data_5(8000+1:20000,:);
    female_gesture_2= data_5(28000+1:40000,:);
    female_gesture_3= data_5(48000+1:60000,:);
    female_gesture_4= data_5(68000+1:80000,:);
    female_gesture_5= data_5(88000+1:100000,:);
    female_gesture_6= data_5(108000+1:120000,:);
    female_gesture_7= data_5(128000+1:140000,:);
    female_gesture_8= data_5(148000+1:160000,:);
    female_gesture_9= data_5(168000+1:180000,:);
    female_gesture_10= data_5(188000+1:200000,:)
    
   features_5=[female_gesture_1;female_gesture_2;female_gesture_3;female_gesture_4;female_gesture_5;female_gesture_6;female_gesture_7;female_gesture_8;female_gesture_9;female_gesture_10];

   % Combine all gesture segments across all 5 cycles 
   all_features=[features_1 ;features_2;features_3;features_4;features_5];
    
    % Save combined features for this subject (update the variable name accordingly, e.g., subject 20)
    save combined_features_20 combined_features_20
    clear;
 
% Combine gesture data from all subjects into one matrix (rest segments excluded)
% Each 'combined_features_X' corresponds to one subject.
all_female=[combined_features_1 ; combined_features_2 ;combined_features_3;combined_features_4;combined_features_5;combined_features_6;combined_features_7;combined_features_8 ;combined_features_9 ; combined_features_10;combined_features_11 ; combined_features_12 ;combined_features_13;combined_features_14;combined_features_15;combined_features_16;combined_features_17;combined_features_18 ;combined_features_19 ; combined_features_20];


% RMS features are extracted from each channel using a sliding window approach.
% Window size: 100 ms, Sampling rate: 2000 Hz → 200 samples per window
k = 1;
pu_time = 100; % milliseconds
fs = 2000;      % sampling frequency in Hz
pu = (fs * pu_time) / 1000; % samples per window (100 ms)
for i = 1:4  % for each channel
    for j = 1:pu:size(all_female,1) - pu + 1
        window = all_female(j:j+pu-1, i);  % extract 100 ms segment
        feat = rms(window);             % compute RMS
        feature(k, i) = feat;           % store feature
        k = k + 1;
    end
    k = 1;  % reset index for next channel
end


 % saved "all_female_rms.mat"

