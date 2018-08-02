function [ output_image ] = mylab2rgb( original )

[h, w, ~] = size(original);
output_image = zeros(h, w, 3);

for i = 1 : h
    for j = 1 : w
        L = 10 ^ (original(i, j, 1) / sqrt(3) + original(i, j, 2) / sqrt(6) + original(i, j, 3) / sqrt(2));
        M = 10 ^ (original(i, j, 1) / sqrt(3) + original(i, j, 2) / sqrt(6) - original(i, j, 3) / sqrt(2));
        S = 10 ^ (original(i, j, 1) / sqrt(3) - 2 * original(i, j, 2) / sqrt(6));
        
        output_image(i, j, 1) = sum([4.4687, -3.5887, 0.1196] .* [L, M, S]);
        output_image(i, j, 2) = sum([-1.2197, 2.3831, -0.1626] .* [L, M, S]);
        output_image(i, j, 3) = sum([0.0585, -0.2611, 1.2057] .* [L, M, S]);
    end
end

end

