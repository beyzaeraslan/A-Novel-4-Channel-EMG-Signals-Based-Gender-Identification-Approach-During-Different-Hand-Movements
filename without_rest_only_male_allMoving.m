% In this section, the goal is to analyze the effect of each specific hand movement on gender classification.
% The dataset includes 20 male subjects. Each subject performed 5 cycles, and each cycle consists of 10 different hand gestures.

clear;
clc;
load('all_male_rms') % Load the combined RMS feature matrix

% Convert each gesture-specific cell array into a matrix and save them as separate .mat files for further analysis
for i = 1:100   % 20 subjects x 5 cycle
    base_idx = (i - 1) * 600;
    first_move{i} = all_male_rms(base_idx + 1 : base_idx + 60, :);
end

for i = 1:100
    base_idx = (i - 1) * 600;
    second_move{i} = all_male_rms(base_idx + 61 : base_idx + 120, :);
end

for i = 1:100
    base_idx = (i - 1) * 600;
    third_move{i} = all_male_rms(base_idx + 121 : base_idx + 180, :);
end

for i = 1:100
    base_idx = (i - 1) * 600;
    fourth_move{i} = all_male_rms(base_idx + 181 : base_idx + 240, :);
end

for i = 1:100
    base_idx = (i - 1) * 600;
    fifth_move{i} = all_male_rms(base_idx + 241 : base_idx + 300, :);
end

for i = 1:100
    base_idx = (i - 1) * 600;
    sixth_move{i} = all_male_rms(base_idx + 301 : base_idx + 360, :);
end

for i = 1:100
    base_idx = (i - 1) * 600;
    seventh_move{i} = all_male_rms(base_idx + 361 : base_idx + 420, :);
end

for i = 1:100
    base_idx = (i - 1) * 600;
    eighth_move{i} = all_male_rms(base_idx + 421 : base_idx + 480, :);
end

for i = 1:100
    base_idx = (i - 1) * 600;
    ninth_move{i} = all_male_rms(base_idx + 481 : base_idx + 540, :);
end

for i = 1:100
    base_idx = (i - 1) * 600;
    tenth_move{i} = all_male_rms(base_idx + 541 : base_idx + 600, :);
end


% Convert each movement cell array into a matrix and save separately.
all_male_rms_first_move_matrix = cell2mat(first_move');
save('all_male_rms_first_move_matrix.mat', 'all_male_rms_first_move_matrix');

all_male_rms_second_move_matrix = cell2mat(second_move');
save('all_male_rms_second_move_matrix.mat', 'all_male_rms_second_move_matrix');

all_male_rms_third_move_matrix = cell2mat(third_move');
save('all_male_rms_third_move_matrix.mat', 'all_male_rms_third_move_matrix');

all_male_rms_fourth_move_matrix = cell2mat(fourth_move');
save('all_male_rms_fourth_move_matrix.mat', 'all_male_rms_fourth_move_matrix');

all_male_rms_fifth_move_matrix = cell2mat(fifth_move');
save('all_male_rms_fifth_move_matrix.mat', 'all_male_rms_fifth_move_matrix');

all_male_rms_sixth_move_matrix = cell2mat(sixth_move');
save('all_male_rms_sixth_move_matrix.mat', 'all_male_rms_sixth_move_matrix');

all_male_rms_seventh_move_matrix = cell2mat(seventh_move');
save('all_male_rms_seventh_move_matrix.mat', 'all_male_rms_seventh_move_matrix');

all_male_rms_eighth_move_matrix = cell2mat(eighth_move');
save('all_male_rms_eighth_move_matrix.mat', 'all_male_rms_eighth_move_matrix');

all_male_rms_ninth_move_matrix = cell2mat(ninth_move');
save('all_male_rms_ninth_move_matrix.mat', 'all_male_rms_ninth_move_matrix');

all_male_rms_tenth_move_matrix = cell2mat(tenth_move');
save('all_male_rms_tenth_move_matrix.mat', 'all_male_rms_tenth_move_matrix');

