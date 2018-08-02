function [ output_image ] = rgb2mylab( original )

[h, w, ~] = size(original);
output_image = zeros(h, w, 3);
for i = 1 : h
    for j = 1 : w
        L = log10(sum([0.3811, 0.5783, 0.0402] .* [original(i, j, 1), original(i, j, 2), original(i, j, 3)]));
        M = log10(sum([0.1967, 0.7244, 0.0782] .* [original(i, j, 1), original(i, j, 2), original(i, j, 3)]));
        S = log10(sum([0.0241, 0.1288, 0.8444] .* [original(i, j, 1), original(i, j, 2), original(i, j, 3)]));

        output_image(i, j, 1) = 1 / sqrt(3) * (L + M + S);
        output_image(i, j, 2) = 1 / sqrt(6) * (L + M - 2 * S);
        output_image(i, j, 3) = 1 / sqrt(2) * (L - M);
    end
end

end

