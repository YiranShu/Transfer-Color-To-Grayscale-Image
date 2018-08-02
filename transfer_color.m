function output_image = transfer_color(source, target)

tic
clc;
warning off;

%source = im2double(source);
%target = im2double(target);
[h_source, w_source, ~] = size(source);
[h_target, w_target, ~] = size(target);
output_image = zeros(h_target, w_target, 3);

lab_source = rgb2lab(source);
lab_target = rgb2lab(target);

l_source = lab_source(:, :, 1);
l_target = lab_target(:, :, 1);
output_image(:, :, 1) = l_target;
var_source = sqrt(var(l_source(:), 1));
var_target = sqrt(var(l_target(:), 1));
avg_source = mean(l_source(:));
avg_target = mean(l_target(:));

for i = 1 : h_source
    for j = 1 : w_source
        l_source(i, j) = (var_target / var_source) * (l_source(i, j) - avg_target) + avg_source;
    end
end

sample_num = 250;
w1 = 0.5;
w2 = 0.5;
samples = [randi([1, h_source], sample_num, 1), randi([1, w_source], sample_num, 1)];
for i = 1 : h_target
    for j = 1 : w_target
        E = zeros(sample_num, 1);
        target_neighbors = get_neighbors(i, j, h_target, w_target);
        target_neighbors_intensities = get_neighbors_intensities(l_target, target_neighbors);
        var_target = sqrt(var([target_neighbors_intensities, l_target(i, j)], 1));
        for k = 1 : sample_num
            sample_neighbors = get_neighbors(samples(k, 1), samples(k, 2), h_source, w_source);
            sample_neighbors_intensities = get_neighbors_intensities(l_source, sample_neighbors);
            var_sample = sqrt(var([sample_neighbors_intensities, l_source(samples(k, 1), samples(k, 2))]));
            E(k) = w1 * abs(l_target(i, j) - l_source(samples(k, 1), samples(k, 2))) + w2 * abs(var_target - var_sample);
        end
        
        [~, index] = min(E);
        output_image(i, j, 2) = lab_source(samples(index, 1), samples(index, 2), 2);
        output_image(i, j, 3) = lab_source(samples(index, 1), samples(index, 2), 3);
    end
end

output_image = lab2rgb(output_image);
toc;
end