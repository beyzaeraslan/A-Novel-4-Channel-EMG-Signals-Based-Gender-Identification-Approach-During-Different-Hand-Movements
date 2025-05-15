% bu kodda her bireyin ilk cycleını ve ilk hareketini alacağım. sonrada
% birleştirip, son cycle son hareketle kıyaslacağım
clear;
clc;
load('all_female_rms')

for i = 1:100 % kişi
    base_idx = (i - 1) * 600; % o kişiye ait veri bloğu başlangıcı

    first_move{i}   = all_female_rms(base_idx +   1 : base_idx +  60, :);
end

%20 kişinin ilk döngüdeki ilk hareketini aldım
for i = 1:5:100
    varName = sprintf('all_female_rms_first_cycle_first_movement_%d', i);
    assignin('base', varName, first_move{i});
end

% ilk cycle ilk harektleri bir araya topla
female_concat_data = [];

for i = 1:5:100
    varName = sprintf('all_female_rms_first_cycle_first_movement_%d', i);
    if exist(varName, 'var')
        data = eval(varName);  % Değişkeni oku
        female_concat_data = [female_concat_data; data];  % Alt alta ekle
    end
end

all_female_rms_first_cycle_first_movement = female_concat_data;
save all_female_rms_first_cycle_first_movement all_female_rms_first_cycle_first_movement 


%20 kişinin son döngüdeki son ilk hareketini aldım
%yani herkesin sonuncu döngüsü ama ilk hareketi alındı.
for i = 5:5:100
    varName = sprintf('all_female_rms_last_cycle_first_movement_%d', i);
    assignin('base', varName, first_move{i});
end

% ilk cycle ilk harektleri bir araya topla
female_concat_data_2 = [];

for i = 5:5:100
    varName = sprintf('all_female_rms_last_cycle_first_movement_%d', i);
    if exist(varName, 'var')
        data = eval(varName);  % Değişkeni oku
        female_concat_data_2 = [female_concat_data_2; data];  % Alt alta ekle
    end
end
 
all_female_rms_last_cycle_first_movement = female_concat_data_2;
save all_female_rms_last_cycle_first_movement all_female_rms_last_cycle_first_movement 
