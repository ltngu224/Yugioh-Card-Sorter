clear all; close all; clc %#ok<CLALL>

% folder read

myFolder = '/Users/liemnguyen/Documents/MATLAB/Personal_Projects/YGO_LOB';
fds = fileDatastore(myFolder, 'ReadFcn', @importdata);
fullFileNames = fds.Files;
numFiles = length(fullFileNames);

Finaltxt = fopen('Personal_Projects/Finaltxt.txt','w+');

for k = 1 : numFiles
    
    % auto cropper

    input = imread(fullFileNames{k});
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
    
    resiz           = 2 * [400 260];
    Image2          = imresize(picC,resiz);
    
    roi = 2 * [20 20 187 33 % Name
           185 289 50 15 % Set Code
           24 303 185 15 % Type
           24 289 160 15 % Edition
           48 378 80 12];
    box = insertShape(Image2,"FilledRectangle",roi);
    
    txt          = ocr(Image2, roi,'Language','/Users/liemnguyen/Documents/MATLAB/Personal_Projects/CustomOCR/YGOCardFont/tessdata/YGOCardFont.traineddata');
    recognizedText  = txt.Text;
    fprintf(Finaltxt,'%s',recognizedText);
    
    %figure(1); subplot(3,3,k); imshow(Image2); imshow(box);
    %text(80,300, recognizedText, 'BackgroundColor', [1 1 1]);
    %pause(1)
end

Read = fileread('pretxt.txt');
str = regexprep(Read,'[\n\r]+','\n');
fprintf(Finaltxt,str);

fclose(Finaltxt);

system('open /Users/liemnguyen/Documents/MATLAB/Personal_Projects/Finaltxt.txt');

%           [25 23 183 27 % Name
%           185 289 50 15 % Set Code
%           24 303 185 15 % Type
%           24 289 160 15 % Edition
%           48 378 80 12];