
clear;
clc;
load('all_male_rms')

 for i = 1:100 
    base_idx = (i - 1) * 600; 
    tenth_move{i}   = all_male_rms(base_idx +540 +   1 : base_idx + 600, :);
 end


for i = 1:5:100
    varName = sprintf('all_male_rms_first_cycle_last_movement_%d', i);
    assignin('base', varName, tenth_move{i});
end


male_concat_data = [];

for i = 1:5:100
    varName = sprintf('all_male_rms_first_cycle_last_movement_%d', i);
    if exist(varName, 'var')
        data = eval(varName); 
        male_concat_data = [male_concat_data; data]; 
    end
end

all_male_rms_first_cycle_last_movement = male_concat_data;
save all_male_rms_first_cycle_last_movement all_male_rms_first_cycle_last_movement 



for i = 5:5:100
    varName = sprintf('all_male_rms_last_cycle_last_movement_%d', i);
    assignin('base', varName, tenth_move{i});
end


male_concat_data_2 = [];

for i = 5:5:100
    varName = sprintf('all_male_rms_last_cycle_last_movement_%d', i);
    if exist(varName, 'var')
        data = eval(varName);  
        male_concat_data_2 = [male_concat_data_2; data]; 
    end
end
 
all_male_rms_last_cycle_last_movement = male_concat_data_2;
save all_male_rms_last_cycle_last_movement all_male_rms_last_cycle_last_movement 
