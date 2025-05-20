% In this section, the goal is to analyze the effect of each specific hand movement on gender classification.
% The dataset includes 20 female subjects. Each subject performed 5 cycles, and each cycle consists of 10 different hand gestures.

clear;
clc;
load('all_female_rms') % Load the combined RMS feature data for 100 female subjects (100 x 600 samples)

% Separate the RMS features for each of the 10 hand movements per subject
% Each subject has 600 samples: 10 movements x 60 samples

for i = 1:100
    base_idx = (i - 1) * 600;
    first_move{i} = all_female_rms(base_idx + 1 : base_idx + 60, :);
end

for i = 1:100
    base_idx = (i - 1) * 600;
    second_move{i} = all_female_rms(base_idx + 61 : base_idx + 120, :);
end

for i = 1:100
    base_idx = (i - 1) * 600;
    third_move{i} = all_female_rms(base_idx + 121 : base_idx + 180, :);
end

for i = 1:100
    base_idx = (i - 1) * 600;
    fourth_move{i} = all_female_rms(base_idx + 181 : base_idx + 240, :);
end

for i = 1:100
    base_idx = (i - 1) * 600;
    fifth_move{i} = all_female_rms(base_idx + 241 : base_idx + 300, :);
end

for i = 1:100
    base_idx = (i - 1) * 600;
    sixth_move{i} = all_female_rms(base_idx + 301 : base_idx + 360, :);
end

for i = 1:100
    base_idx = (i - 1) * 600;
    seventh_move{i} = all_female_rms(base_idx + 361 : base_idx + 420, :);
end

for i = 1:100
    base_idx = (i - 1) * 600;
    eighth_move{i} = all_female_rms(base_idx + 421 : base_idx + 480, :);
end

for i = 1:100
    base_idx = (i - 1) * 600;
    ninth_move{i} = all_female_rms(base_idx + 481 : base_idx + 540, :);
end

for i = 1:100
    base_idx = (i - 1) * 600;
    tenth_move{i} = all_female_rms(base_idx + 541 : base_idx + 600, :);
end


% Convert each movement cell array into a matrix and save separately.
% Each resulting matrix has dimensions 6000 x 4 (100 subjects x 60 samples per movement)

all_female_rms_first_move_matrix = cell2mat(first_move');
save('all_female_rms_first_move_matrix.mat', 'all_female_rms_first_move_matrix');

all_female_rms_second_move_matrix = cell2mat(second_move');
save('all_female_rms_second_move_matrix.mat', 'all_female_rms_second_move_matrix');

all_female_rms_third_move_matrix = cell2mat(third_move');
save('all_female_rms_third_move_matrix.mat', 'all_female_rms_third_move_matrix');

all_female_rms_fourth_move_matrix = cell2mat(fourth_move');
save('all_female_rms_fourth_move_matrix.mat', 'all_female_rms_fourth_move_matrix');

all_female_rms_fifth_move_matrix = cell2mat(fifth_move');
save('all_female_rms_fifth_move_matrix.mat', 'all_female_rms_fifth_move_matrix');

all_female_rms_sixth_move_matrix = cell2mat(sixth_move');
save('all_female_rms_sixth_move_matrix.mat', 'all_female_rms_sixth_move_matrix');

all_female_rms_seventh_move_matrix = cell2mat(seventh_move');
save('all_female_rms_seventh_move_matrix.mat', 'all_female_rms_seventh_move_matrix');

all_female_rms_eighth_move_matrix = cell2mat(eighth_move');
save('all_female_rms_eighth_move_matrix.mat', 'all_female_rms_eighth_move_matrix');

all_female_rms_ninth_move_matrix = cell2mat(ninth_move');
save('all_female_rms_ninth_move_matrix.mat', 'all_female_rms_ninth_move_matrix');

all_female_rms_tenth_move_matrix = cell2mat(tenth_move');
save('all_female_rms_tenth_move_matrix.mat', 'all_female_rms_tenth_move_matrix');


% At this point, each subject's individual movements have been separated and saved as standalone matrices.
% These matrices can now be used for further movement-specific analysis in gender classification tasks.
% The same procedure can be applied to the fefemale dataset and then the matrices can be labeled and combined accordingly.
