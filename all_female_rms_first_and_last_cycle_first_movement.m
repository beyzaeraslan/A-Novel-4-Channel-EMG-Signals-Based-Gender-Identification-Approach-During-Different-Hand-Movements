% In this code, the first cycle's first movement is extracted for each individual.
% These segments are then concatenated to form a unified dataset.
% Later, this dataset will be compared with the first movement from the last cycle,
% in order to evaluate temporal changes or performance differences across repetitions.

clear;
clc;
load('all_female_rms')

for i = 1:100 % kişi
    base_idx = (i - 1) * 600; 

    first_move{i}   = all_female_rms(base_idx +   1 : base_idx +  60, :);
end

% Extracted the first movement from the first cycle of 20 selected subjects (sampled every 5 subjects).

for i = 1:5:100
    varName = sprintf('all_female_rms_first_cycle_first_movement_%d', i);
    assignin('base', varName, first_move{i});
end

% Concatenate the first movement segments from the first cycle of the selected subjects.

female_concat_data = [];

for i = 1:5:100
    varName = sprintf('all_female_rms_first_cycle_first_movement_%d', i);
    if exist(varName, 'var')
        data = eval(varName);  
        female_concat_data = [female_concat_data; data];  
    end
end

all_female_rms_first_cycle_first_movement = female_concat_data;
save all_female_rms_first_cycle_first_movement all_female_rms_first_cycle_first_movement 


% For each of the 20 selected subjects, the first movement segment from their final (last) cycle
% was extracted to enable comparison with the initial cycle's corresponding movement.

for i = 5:5:100
    varName = sprintf('all_female_rms_last_cycle_first_movement_%d', i);
    assignin('base', varName, first_move{i});
end

% Concatenate the first movement segments from the first cycle into a single matrix.
female_concat_data_2 = [];

for i = 5:5:100
    varName = sprintf('all_female_rms_last_cycle_first_movement_%d', i);
    if exist(varName, 'var')
        data = eval(varName);  % Değişkeni oku
        female_concat_data_2 = [female_concat_data_2; data];  
    end
end
 
all_female_rms_last_cycle_first_movement = female_concat_data_2;
save all_female_rms_last_cycle_first_movement all_female_rms_last_cycle_first_movement 
