% =========================================================================
% This script extracts the 10th hand movement (i.e., the last movement) 
% from both the first and last cycles of selected female subjects based on 
% RMS features. The purpose is to compare early and late performance 
% segments for gender classification analysis.
%
% Output:
% - all_female_rms_first_cycle_last_movement.mat
% - all_female_rms_last_cycle_last_movement.mat
% =========================================================================

clear;
clc;

% Load preprocessed RMS feature matrix for all female subjects
load('all_female_rms');

% -------------------------------------------------------------------------
% Step 1: Extract the 10th movement for each subject
% -------------------------------------------------------------------------

for i = 1:100
    base_idx = (i - 1) * 600;  % Starting index of the current subject's data block
    tenth_move{i} = all_female_rms(base_idx + 541 : base_idx + 600, :);
end

% -------------------------------------------------------------------------
% Step 2: Select the first cycle's last movement from 20 selected subjects
% (Subjects: 1, 6, 11, ..., 96 — i.e., every 5th subject starting at 1)
% -------------------------------------------------------------------------

for i = 1:5:100
    varName = sprintf('all_female_rms_first_cycle_last_movement_%d', i);
    assignin('base', varName, tenth_move{i});
end

% Concatenate the selected movements into a single matrix
female_concat_data = [];

for i = 1:5:100
    varName = sprintf('all_female_rms_first_cycle_last_movement_%d', i);
    if exist(varName, 'var')
        data = eval(varName);
        female_concat_data = [female_concat_data; data];
    end
end

% Save the combined data from the first cycle
all_female_rms_first_cycle_last_movement = female_concat_data;
save all_female_rms_first_cycle_last_movement all_female_rms_first_cycle_last_movement

% -------------------------------------------------------------------------
% Step 3: Select the last cycle's last movement from 20 selected subjects
% (Subjects: 5, 10, 15, ..., 100 — i.e., every 5th subject starting at 5)
% -------------------------------------------------------------------------

for i = 5:5:100
    varName = sprintf('all_female_rms_last_cycle_last_movement_%d', i);
    assignin('base', varName, tenth_move{i});
end

% Concatenate the selected movements into a single matrix
female_concat_data_2 = [];

for i = 5:5:100
    varName = sprintf('all_female_rms_last_cycle_last_movement_%d', i);
    if exist(varName, 'var')
        data = eval(varName);
        female_concat_data_2 = [female_concat_data_2; data];
    end
end

% Save the combined data from the last cycle
all_female_rms_last_cycle_last_movement = female_concat_data_2;
save all_female_rms_last_cycle_last_movement all_female_rms_last_cycle_last_movement
