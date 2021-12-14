clear all; close all; clc %#ok<CLALL>


% auto cropper

input = imread('LOB-000.jpg');
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



% Image reader

Image           = picC;
Image2          = imresize(Image,[400 260]);

roi = [25 23 183 27 % Name
       185 289 50 15 % Set Code
       24 303 185 15 % Type
       24 289 160 15 % Edition
       48 378 80 12];
box = insertShape(Image2,"FilledRectangle",roi);

txt             = ocr(Image2, roi,'Language','/Users/liemnguyen/Documents/MATLAB/Personal Projects/CustomOCR/YGOCardFont/tessdata/YGOCardFont.traineddata');
txt_type        = ocr(Image2, roi,'Language','/Users/liemnguyen/Documents/MATLAB/Personal Projects/CustomOCR/YGOType/tessdata/YGOType.trainneddata');
recognizedText  = txt.Text;
figure(1); imshow(Image2); imshow(box);

text(40,150, recognizedText, 'BackgroundColor', [1 1 1]);


