% =========================================================================
% Script: Extract First Movement from First and Last Cycles (Female Subjects)
%
% Description:
% This script extracts the first hand movement from both 
% the first and last cycles of selected female subjects based on 
% RMS-extracted EMG features. The aim is to analyze potential temporal 
% changes in signal patterns for gender classification tasks.
%
% Output:
% - all_female_rms_first_cycle_first_movement.mat
% - all_female_rms_last_cycle_first_movement.mat
% =========================================================================

clear;
clc;

% Load preprocessed RMS features for all female subjects.
load('all_female_rms');


%  Extract the first movement from each subject
for i = 1:100
    base_idx = (i - 1) * 600;  % Starting index for subject i
    first_move{i} = all_female_rms(base_idx + 1 : base_idx + 60, :);
end

% Select and store first movement from the first cycle
for i = 1:5:100
    varName = sprintf('all_female_rms_first_cycle_first_movement_%d', i);
    assignin('base', varName, first_move{i});  
end

% Concatenate selected first-cycle first movements into a single matrix
female_concat_data = [];

for i = 1:5:100
    varName = sprintf('all_female_rms_first_cycle_first_movement_%d', i);
    if exist(varName, 'var')
        data = eval(varName);
        female_concat_data = [female_concat_data; data];  % Append vertically
    end
end

% Save the combined matrix for the first cycle's first movement
all_female_rms_first_cycle_first_movement = female_concat_data;
save all_female_rms_first_cycle_first_movement all_female_rms_first_cycle_first_movement


% Select and store first movement from the last cycle

for i = 5:5:100
    varName = sprintf('all_female_rms_last_cycle_first_movement_%d', i);
    assignin('base', varName, first_move{i}); 
end

% Concatenate selected last-cycle first movements into a single matrix
female_concat_data_2 = [];

for i = 5:5:100
    varName = sprintf('all_female_rms_last_cycle_first_movement_%d', i);
    if exist(varName, 'var')
        data = eval(varName);
        female_concat_data_2 = [female_concat_data_2; data];  % Append vertically
    end
end

% Save the combined matrix for the last cycle's first movement
all_female_rms_last_cycle_first_movement = female_concat_data_2;
save all_female_rms_last_cycle_first_movement all_female_rms_last_cycle_first_movement

