close all;
clear all;
clc;
% Read the Image
img = imread('D:\study\MTech_2nd_sem\frame_images\1963.jpg');

[no_of_rows,no_of_cols,dimension] = size(img);
total_num_of_pixels = no_of_rows * no_of_cols;

% Convert RGB image to YCbCr 
YCBCR = rgb2ycbcr(img);
cb = zeros(no_of_rows,no_of_cols);
cr = zeros(no_of_rows,no_of_cols);
cb = YCBCR(:,:,2);
cr = YCBCR(:,:,3);

% Convert RG color space to yCbCr
%cmap = rgb2hsv(I); 
HSV = rgb2hsv(img);
H = zeros(no_of_rows,no_of_cols);
S = zeros(no_of_rows,no_of_cols);
H = HSV(:,:,1);
S = HSV(:,:,2);


image = ones(no_of_rows,no_of_cols);
%image = arrayfun(@condition, cb,cr,H,S);
image = (cb >= 77 & cb <= 127 & cr >= 133 & cr <= 173 & H > 0 & H <0.2 & S > 0.2 & S<0.7).* 0 + (~(cb >= 77 & cb <= 127 & cr >= 133 & cr <= 173 & H > 0 & H <0.2 & S > 0.2 & S<0.7).* 1);
figure(4);
imshow(image);

labeledimage = bwlabel(image);
blobMeasurements = regionprops(labeledimage,'Area');
allblobareas = [blobMeasurements.Area];
allowableAreaIndexes = (allblobareas > 150 ) & (allblobareas < 4000);
keeperindexes = find(allowableAreaIndexes);

if (keeperindexes ~= [0])
    keeperblobsimage = ismember(labeledimage,keeperindexes);
    originalimage = bwareaopen(keeperblobsimage,500);

    se = strel('disk',10);
    closbw = imclose(originalimage,se);

    mm = double(closbw);
    figure(9);
    imshow(img);
    s = regionprops(mm,'BoundingBox');

    hold on
    for k = 1 : length(s)
      rectangle('position',[s(k).BoundingBox(1)-70,s(k).BoundingBox(2)-120,s(k).BoundingBox(3)+130,s(k).BoundingBox(4)+130],'EdgeColor','b','LineWidth',3);
    end
end