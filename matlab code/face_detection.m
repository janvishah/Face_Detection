% Read the Image
img = imread('D:\study\MTech_2nd_sem\frame_images\39.jpg');

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
image = arrayfun(@condition, cb,cr,H,S);

figure(4);
c = imshow(image);

labeledimage = bwlabel(image);
blobMeasurements = regionprops(labeledimage,'Area');
allblobareas = [blobMeasurements.Area];
allowableAreaIndexes = (allblobareas > 200 ) & (allblobareas < 1200000);
keeperindexes = find(allowableAreaIndexes);
keeperblobsimage = ismember(labeledimage,keeperindexes);



originalimage = bwareaopen(keeperblobsimage,500);

se = strel('disk',10);
closbw = imclose(originalimage,se);

mm = double(closbw);

figure(9);
imshow(img);
s = regionprops(mm,'BoundingBox');

hold on

rectangle('position',[s.BoundingBox(1)-70,s.BoundingBox(2)-70,s.BoundingBox(3)+130,s.BoundingBox(4)+130],'EdgeColor','b','LineWidth',3);
