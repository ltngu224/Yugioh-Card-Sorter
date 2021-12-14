clear all; close all; clc %#ok<CLALL>

% auto cropper

input = imread('LOB-090.jpg');
startBW = rgb2gray(input);
index = size(startBW);

picA = size(startBW);

for p = 1:index(1)
    for q = 1:index(2)
        if startBW(p,q) > 220
            picA(p,q) = 255;
        elseif startBW(p,q) < 220
            picA(p,q) = 0;
        end
    end
end

picB = bwareaopen(picA,1000);
[row_crop, col_crop] = find(~picB);

tRow = min(row_crop); bRow = max(row_crop); 
lCol = min(col_crop); rCol = max(col_crop);

picC = input(tRow:bRow,lCol:rCol);


figure(1); subplot(2,3,1); imshow(input)
subplot(2,3,2); imshow(startBW)
subplot(2,3,3); imshow(picA)
subplot(2,3,4); imshow(picB)
subplot(2,3,6); imshow(picC)




