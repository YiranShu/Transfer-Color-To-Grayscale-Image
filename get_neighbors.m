function [ neighbors ] = get_neighbors( row, column, height, width )

if (row == 1 && column == 1) || (row == height && column == width) || (row == 1 && column == width) || (row == height && column == 1)
    neighbors = zeros(8, 2);
elseif (row == 1 && column == 2) || (row == 1 && column == width - 1) || (row == 2 && column == 1) || (row == 2 && column == width) || (row == height - 1 && column == 1) || (row == height - 1 && column == width) || (row == height && column == 2) || (row == height && column == width - 1)
    neighbors = zeros(11, 2);
elseif (row == 1 && column >= 3 && column <= width - 2) || (row == height && column >= 3 && column <= width - 2) || (column == 1 && row >= 3 && row <= height - 2) || (column == width && row >= 3 && row <= height - 2)
    neighbors = zeros(14, 2);
elseif (row == 2 && column == 2) || (row == 2 && column == width - 1) || (row == height - 1 && column == 2) || (row == height - 1 && column == width - 1)
    neighbors = zeros(15, 2);
elseif (row == 2 && column >= 3 && column <= width - 2) || (row == height - 1 && column >= 3 && column <= width - 2) || (column == 2 && row >= 3 && row <= height - 2) || (column == width - 1 && row >= 3 && row <= height - 2)
    neighbors = zeros(19, 2);
else
    neighbors = zeros(24, 2);
end

index = 1;
for i = row - 2 : row + 2
    for j = column - 2 : column + 2
        if i >= 1 && i <= height && j >= 1 && j <= width && (i ~= row || j ~= column)
            neighbors(index, 1) = i;
            neighbors(index, 2) = j;
            index = index + 1;
        end
    end
end

neighbors = uint16(neighbors);

end

