
clear all
I=imread('D:\study\MTech_2nd_sem\frame_images\39.jpg');
[row column dimension]=size(I);

R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

% R1=histeq(R);
% G1=histeq(G);
% B1=histeq(B);
% I=cat(3,R1,G1,B1);
%imshow(I);

% I1=rgb2ycbcr(I);
% I1=double(I1);

%figure(1);
%imshow(I);
%I=double(I);
% Y=I1(:,:,1);
% Cb=I1(:,:,2);
% Cr=I1(:,:,3);
I4 = zeros([row,column]);
% I3 = zeros([row,column]);
% I5 = zeros([row,column]);

for i=200:500
    for j=700:900
       %  I4(i,j)=((r(i,j)./(r(i,j)+g(i,j))).* (1-(g(i,j)./(r(i,j)+g(i,j))))).^2;
       %I3(i,j)=((Cr(i,j)>=155 & Cr(i,j)<=165) & (Cb(i,j)>=115 & Cb(i,j)<=125) );    
   I4(i,j)=((R(i,j)>95 & G(i,j)>40 & B(i,j)>20) & ((R(i,j)>G(i,j)) & (R(i,j)>B(i,j))) & ((abs(R(i,j)-G(i,j)))>=15) & (((max([R(i,j),G(i,j),B(i,j)]))-(min([R(i,j),G(i,j),B(i,j)])))>31));
   %  I4(i,j)=((r(i,j)./(r(i,j)+g(i,j))).* (1-(g(i,j)./(r(i,j)+g(i,j))))).^2;
    %I4(i,j)=( ((G(i,j)./(R(i,j)+G(i,j)+B(i,j)))>=.28) & ((G(i,j)./(R(i,j)+G(i,j)+B(i,j)))<=.363));
    end
        
end



% figure(2);
% imshow(I3);
%figure(3);
%imshow(I4);

% I5=((and(logical(I3),logical(I4))));
% figure(4);
% imshow(I5);




outp = imerode(I4 ,strel('square', 2)); 
outp1 = imfill(outp, 'holes');
imshow(outp1),figure;

[L, n] = bwlabel(outp1); 
face_region = regionprops(L, 'Area');
face_area = [face_region.Area];
face_idx = find(face_area > (.26)*max(face_area));
face_shown = ismember(L, face_idx);
imshow(face_shown),figure;
s = regionprops(face_shown,'centroid');
centroids = cat(1, s.Centroid);
imshow(I)
hold on
plot(centroids(:,1),centroids(:,2), 'b*')
hold off
