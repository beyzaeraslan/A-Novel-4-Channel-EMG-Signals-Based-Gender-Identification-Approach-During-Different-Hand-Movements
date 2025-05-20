clear;
clc;
load('all_male_rms')% Load preprocessed RMS feature matrix for all male subjects


% Extract the first movement for each of the all male subject
for i = 1:100
    base_idx = (i - 1) * 600;
    first_move{i}   = all_male_rms(base_idx +   1 : base_idx +  60, :);
end

% Select the first cycle's first movement for 20 male subjects 
for i = 1:5:100
    varName = sprintf('all_male_rms_first_cycle_first_movement_%d', i);
    assignin('base', varName, first_move{i});
end

% Concatenate the selected first-cycle first movements into a single matrix
male_concat_data = [];

for i = 1:5:100
    varName = sprintf('all_male_rms_first_cycle_first_movement_%d', i);
    if exist(varName, 'var')
        data = eval(varName); 
        male_concat_data = [male_concat_data; data]; 
    end
end

% Save the final combined matrix for first-cycle first movements
all_male_rms_first_cycle_first_movement = male_concat_data;
save all_male_rms_first_cycle_first_movement all_male_rms_first_cycle_first_movement 



% Select the first movement from the last cycle for 20 male subjects
for i = 5:5:100
    varName = sprintf('all_male_rms_last_cycle_first_movement_%d', i);
    assignin('base', varName, first_move{i});
end

% Concatenate the selected last-cycle first movements into a single matrix
male_concat_data_2 = [];

for i = 5:5:100
    varName = sprintf('all_male_rms_last_cycle_first_movement_%d', i);
    if exist(varName, 'var')
        data = eval(varName);  
        male_concat_data_2 = [male_concat_data_2; data];  
    end
end

% Save the final combined matrix for last-cycle first movements 
all_male_rms_last_cycle_first_movement = male_concat_data_2;
save all_male_rms_last_cycle_first_movement all_male_rms_last_cycle_first_movement 

% Summary:
% This code extracts the first movement (1st of 10) from both the first and last cycles 
% of 20 selected male subjects. The selected segments are stored in two matrices:
% - 'all_male_rms_first_cycle_first_movement'
% - 'all_male_rms_last_cycle_first_movement'
% These can be used for comparative gender classification to analyze performance changes over time.

