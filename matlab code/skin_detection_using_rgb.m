img = imread('\4143.jpg');
img = im2double(img);

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
b_vector = rdivide(b_vector,(r_vector + g_vector + b_vector));

r = reshape(r_vector,cols_r,rows_r);
r = r';
g = reshape(g_vector,cols_r,rows_r);
g = g';
b = reshape(b_vector,cols_r,rows_r);
b = b';

a_up = -1.376;
b_up = 1.0743;
c_up = 0.2;

a_down = -0.776;
b_down = 0.5601;
c_down = 0.18;

for i = 1:rows_r
    for j = 1:cols_r
        g_up = (a_up*(r(i,j)^2)) + (b_up * r(i,j)) + c_up;
        g_down = (a_down*(r(i,j)^2)) + (b_down * r(i,j)) + c_down;
        wr = ((r(i,j)-0.33)^2) + ((g(i,j)-0.33)^2);
        
        x = ( 0.5*( ( r(i,j)- g(i,j) )+( r(i,j) - b(i,j) ) ) );
        y = sqrt(((r(i,j)-g(i,j))^2) + ((r(i,j)-b(i,j))*(g(i,j)-b(i,j))));
        theta = acos( x / y );
        
        if (b(i,j) <= g(i,j))
            h = theta;
        else
            h = 360 - theta;
        end
        if (g(i,j) < g_up && g(i,j) > g_down && wr > 0.001 && ( h > 240 || h <= 20 ))
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
figure(7);
c = imagesc(img)

