%bu kodda her hareketin gender üzerindeki etkisine bakmak istiyorum. 
%o yüzden rmsleri çıkartılmış tüm verileri alıp, her bir hareketi ayıran
%kodu yazıyorum.
clear;
clc;
load('all_female_rms')

for i = 1:100 % kişi
    base_idx = (i - 1) * 600; % o kişiye ait veri bloğu başlangıcı

    first_move{i}   = all_female_rms(base_idx +   1 : base_idx +  60, :);
end

for i = 1:100 % kişi
    base_idx = (i - 1) * 600; % o kişiye ait veri bloğu başlangıcı
    second_move{i}   = all_female_rms(base_idx +60 +   1 : base_idx + 60 +60, :);
end

for i = 1:100 % kişi
    base_idx = (i - 1) * 600; % o kişiye ait veri bloğu başlangıcı
    third_move{i}   = all_female_rms(base_idx +120 +   1 : base_idx + 180, :);
end

for i = 1:100 % kişi
    base_idx = (i - 1) * 600; % o kişiye ait veri bloğu başlangıcı
    fourth_move{i}   = all_female_rms(base_idx +180 +   1 : base_idx + 240, :);
end
    
for i = 1:100 % kişi
    base_idx = (i - 1) * 600; % o kişiye ait veri bloğu başlangıcı
    fifth_move{i}   = all_female_rms(base_idx +240 +   1 : base_idx + 300, :);
end
    
for i = 1:100 % kişi
    base_idx = (i - 1) * 600; % o kişiye ait veri bloğu başlangıcı
    sixth_move{i}   = all_female_rms(base_idx +300 +   1 : base_idx + 360, :);
end
 
for i = 1:100 % kişi
    base_idx = (i - 1) * 600; % o kişiye ait veri bloğu başlangıcı
    seventh_move{i}   = all_female_rms(base_idx +360 +   1 : base_idx + 420, :);
end
    
for i = 1:100 % kişi
    base_idx = (i - 1) * 600; % o kişiye ait veri bloğu başlangıcı
    eighth_move{i}   = all_female_rms(base_idx +420 +   1 : base_idx + 480, :);
end

for i = 1:100 % kişi
    base_idx = (i - 1) * 600; % o kişiye ait veri bloğu başlangıcı
    ninth_move{i}   = all_female_rms(base_idx +480 +   1 : base_idx + 540, :);
end
    
 for i = 1:100 % kişi
    base_idx = (i - 1) * 600; % o kişiye ait veri bloğu başlangıcı
    tenth_move{i}   = all_female_rms(base_idx +540 +   1 : base_idx + 600, :);
end

% 
% 
% %buraya  kadar olan kısım çalıştığında her kişinin her bir hareketleri bir
% %hücre toplanmış oldu.

%her bir hareketi hücreden çıkartıp ayrı ayrı kaydedeceğiz.
all_female_rms_first_move_matrix = cell2mat(first_move'); % 6000x4 boyutlu örneğin
save('all_female_rms_first_move_matrix.mat', 'all_female_rms_first_move_matrix'); % yani tüm kadınların ilk hareketi

all_female_rms_second_move_matrix = cell2mat(second_move'); % 6000x4 boyutlu 
save('all_female_rms_second_move_matrix.mat', 'all_female_rms_second_move_matrix'); 

all_female_rms_third_move_matrix = cell2mat(third_move'); % 6000x4 boyutlu 
save('all_female_rms_third_move_matrix.mat', 'all_female_rms_third_move_matrix'); 

all_female_rms_fourth_move_matrix = cell2mat(fourth_move'); % 6000x4 boyutlu 
save('all_female_rms_fourth_move_matrix.mat', 'all_female_rms_fourth_move_matrix'); 

all_female_rms_fifth_move_matrix = cell2mat(fifth_move'); % 6000x4 boyutlu 
save('all_female_rms_fifth_move_matrix.mat', 'all_female_rms_fifth_move_matrix');

all_female_rms_sixth_move_matrix = cell2mat(sixth_move'); % 6000x4 boyutlu 
save('all_female_rms_sixth_move_matrix.mat', 'all_female_rms_sixth_move_matrix');

all_female_rms_seventh_move_matrix = cell2mat(seventh_move'); % 6000x4 boyutlu 
save('all_female_rms_seventh_move_matrix.mat', 'all_female_rms_seventh_move_matrix');

all_female_rms_eighth_move_matrix = cell2mat(eighth_move'); % 6000x4 boyutlu 
save('all_female_rms_eighth_move_matrix.mat', 'all_female_rms_eighth_move_matrix');

all_female_rms_ninth_move_matrix = cell2mat(ninth_move'); % 6000x4 boyutlu 
save('all_female_rms_ninth_move_matrix.mat', 'all_female_rms_ninth_move_matrix');

all_female_rms_tenth_move_matrix = cell2mat(tenth_move'); % 6000x4 boyutlu 
save('all_female_rms_tenth_move_matrix.mat', 'all_female_rms_tenth_move_matrix');

% %aynı kodu male içinde yazacağız. sonra bunlara etiket atayıp
% %birleştireceğiz.
% 
% 

