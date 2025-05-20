% In this code, the first cycle's first movement of each subject is extracted and combined.
% The resulting dataset will be compared with the first movement from the last cycle.

clear;
clc;
load('all_female_rms')

 for i = 1:100 % kişi
    base_idx = (i - 1) * 600; % Starting index of the data block for the corresponding subject

    tenth_move{i}   = all_female_rms(base_idx +540 +   1 : base_idx + 600, :);
 end

% Extracted the last movement from the first cycle of 20 selected subjects.

for i = 1:5:100
    varName = sprintf('all_female_rms_first_cycle_last_movement_%d', i);
    assignin('base', varName, tenth_move{i});
end

% ilk cycle ilk harektleri bir araya topla
female_concat_data = [];

for i = 1:5:100
    varName = sprintf('all_female_rms_first_cycle_last_movement_%d', i);
    if exist(varName, 'var')
        data = eval(varName);  % Değişkeni oku
        female_concat_data = [female_concat_data; data];  % Alt alta ekle
    end
end

all_female_rms_first_cycle_last_movement = female_concat_data;
save all_female_rms_first_cycle_last_movement all_female_rms_first_cycle_last_movement 


% Extracted the last movement from the last cycle of 20 selected subjects.

for i = 5:5:100
    varName = sprintf('all_female_rms_last_cycle_last_movement_%d', i);
    assignin('base', varName, tenth_move{i});
end

% Concatenate the first movements from the first cycle into a single matrix.

female_concat_data_2 = [];

for i = 5:5:100
    varName = sprintf('all_female_rms_last_cycle_last_movement_%d', i);
    if exist(varName, 'var')
        data = eval(varName);  
        female_concat_data_2 = [female_concat_data_2; data];  
    end
end
 
all_female_rms_last_cycle_last_movement = female_concat_data_2;
save all_female_rms_last_cycle_last_movement all_female_rms_last_cycle_last_movement 
