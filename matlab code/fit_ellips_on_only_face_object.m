% Read the Image
img = imread('C:\Users\Piyu\Documents\MATLAB\Frames\410.jpg');
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
allowableAreaIndexes = (allblobareas > 200 ) & (allblobareas < 1940000);
keeperindexes = find(allowableAreaIndexes);
keeperblobsimage = ismember(labeledimage,keeperindexes);
figure(5);
imshow(keeperblobsimage);


originalimage = bwareaopen(keeperblobsimage,200);
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
s = regionprops(mm,originalimage, 'Orientation','MajorAxisLength','MinorAxisLength','Eccentricity','Centroid');
hold on
phi = linspace(0,2*pi,50)';
cosphi = cos(phi);
sinphi = sin(phi);

c_1 = cat(1,s.Centroid);
xbar = c_1(1);

ybar = c_1(2);
    
MajorAxisLengths = cat(1,s.MajorAxisLength);
a = MajorAxisLengths(1);
MinorAxisLengths = cat(1,s.MinorAxisLength);
b = MinorAxisLengths(1);
    
orientations = cat(1,s.Orientation);
theta = -orientations(1) * (pi/180);
X = xbar + (a * cosphi * cos(theta)) - (b * sinphi * sin(theta));
Y = ybar + (a * cosphi * sin(theta)) + (b * sinphi * cos(theta));
   
plot(X,Y,'r','LineWidth',2);

