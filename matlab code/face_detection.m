% Read the Image
img = imread('D:\study\MTech_2nd_sem\frame_images\39.jpg');
figure(1);
imshow(img);
%hist(double(img))

% Divide image into RGB matrix and create vector of RGBplot(X,Y,'r','LineWidth',2);

R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

[rows_r,cols_r] = size(R);
total_num_of_pixels = rows_r * cols_r;

% Convert RGB image to YCbCr 
YCBCR = rgb2ycbcr(img);
figure(2);
imshow(YCBCR);
y = YCBCR(:,:,1);
cb = YCBCR(:,:,2);
cr = YCBCR(:,:,3);

% Convert RG color space to yCbCr
%cmap = rgb2hsv(I); 
HSV = rgb2hsv(img);
figure(3);
imshow(HSV);
H = HSV(:,:,1);
S = HSV(:,:,2);
V = HSV(:,:,3);

image = ones(rows_r,cols_r);
count = 0;
for i = 1:rows_r
    for j = 1:cols_r
        if (cb(i,j) >= 77 & cb(i,j) <= 127 & cr(i,j) >= 133 & cr(i,j) <= 173 & H(i,j) > 0 & H(i,j) <0.2 & S(i,j) > 0.2 & S(i,j)<0.7);
            image(i,j)= 0;
        end
    end
end

figure(4);
c = imshow(image);


% Plot Histogram
%figure(5);
%hist(double(YCBCR));

labeledimage = bwlabel(image);
blobMeasurements = regionprops(labeledimage,'Area');
allblobareas = [blobMeasurements.Area];
allowableAreaIndexes = (allblobareas > 150 ) & (allblobareas < 2500);
keeperindexes = find(allowableAreaIndexes);
keeperblobsimage = ismember(labeledimage,keeperindexes);
figure(5);
imshow(keeperblobsimage);


originalimage = bwareaopen(keeperblobsimage,500);
figure(6);
imshow(originalimage);
se = strel('disk',10);
closbw = imclose(originalimage,se);
figure(7);
imshow(closbw);
mm = double(closbw);
figure(8);
imshow(mm);

figure(9);
imshow(img);
s = regionprops(mm,'BoundingBox');

hold on

rectangle('position',[s.BoundingBox(1)-50,s.BoundingBox(2)-50,s.BoundingBox(3)+50,s.BoundingBox(4)+70],'EdgeColor','b','LineWidth',3);
