img = imread('D:\study\MTech_2nd_sem\Face_Detection\image\24.jpg');
img = im2double(img);
figure(1);
imshow(img);

r = img(:,:,1);
g = img(:,:,2);
b = img(:,:,3);

[rows_r,cols_r] = size(r);
total_num_of_pixels = rows_r * cols_r;
r_vector = double(reshape(r',1,total_num_of_pixels));
g_vector = double(reshape(g',1,total_num_of_pixels));
b_vector = double(reshape(b',1,total_num_of_pixels));
r_vector = rdivide(r_vector,(r_vector + g_vector + b_vector));
g_vector = rdivide(g_vector,(r_vector + g_vector + b_vector));

r = reshape(r_vector,cols_r,rows_r);
r = r';
g = reshape(g_vector,cols_r,rows_r);
g = g';


a_up = -1.8423;
b_up = 1.5294;
c_up = 0.0422;

a_down = -0.7279;
b_down = 0.6066;
c_down = 0.1766;

for i = 1:rows_r
    for j = 1:cols_r
        g_up = (a_up*(r(i,j)^2)) + (b_up * r(i,j)) + c_up;
        g_down = (a_down*(r(i,j)^2)) + (b_down * r(i,j)) + c_down;
        wr = ((r(i,j)-0.33)^2) + ((g(i,j)-0.33)^2);
        if (g(i,j) < g_up && g(i,j) > g_down && wr > 0.004)
           for k = 1:3
               img(i,j,k) = 1;
           end
        else
            for k = 1:3
               img(i,j,k) = 0;
            end
        end
    end
end
figure(2);
c = imagesc(img)
figure(3);
imshow(c)