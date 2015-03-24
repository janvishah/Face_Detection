%https://www.youtube.com/watch?v=gvtqSJx3Y98
im = imread('24.JPG')

resize_image = imresize(im, [432 432], 'bilinear');
img=rgb2gray(resize_image);

diff_im = imsubtract(resize_image(:,:,1),img);
imshow(diff_im)
diff_im = medfilt2(diff_im,[3,3]);
diff_im = imadjust(diff_im);
level = graythresh(diff_im);
bw = im2bw(diff_im, level);
imshow(bw);
BW5 = imfill(bw,'holes');
bw6 = bwlabel(BW5, 8);
stats = regionprops(bw6,['basic']);
[N,M] = size(stats);
if(bw == 0)
    break;
else
    tmp = stats(1);
    for i=2:N
        if stats(i).Area > tmp.Area
            tmp = stats(i);
        end
    end
    bb = tmp.BoundingBox;
    bc = tmp.Centroid;
    imshow(resize_image)
    rectangle('position',bb,'EdgeColor','r','LineWidth',2)
end


