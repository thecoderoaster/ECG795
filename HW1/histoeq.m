function [ g ] = histoeq( image, graylevels )
%HISTOEQ Equalizes the histogram of an input image
%   Detailed explanation goes here


% Variables
rk = zeros(512,512);
sk = zeros(graylevels,1);
nk = zeros(graylevels,1);
enk = zeros(graylevels,1);
prk = zeros(graylevels,1);
psk = zeros(graylevels,1);
img_size = size(image,1) * size(image,2);

% Find the number of pixels that have intensity
% rk.
for i = 1:graylevels
   nk(i,1) = sum(sum(image(:,:,1) == i));
   prk(i,1) = nk(i,1)/img_size;
end

% Perform transformation on input image 
for k = 1:graylevels
    sk(k,1) = round((graylevels - 1) * dsum(prk, 1, k));
    enk(sk(k,1)+1,1) = enk(sk(k,1)+1,1) + nk(k,1);
end

% Equalize Histogram
for k = 1:graylevels
     psk(k,1) = enk(k,1)/img_size;
end


% Create new image
for row = 1 : 512
    for col = 1 : 512
       rk(row,col) = sk(image(row,col,1),1);
    end
end

x = 1 : 1 : 256;
subplot(4,1,1), plot(x,nk);
subplot(4,1,2), plot(x,prk);
subplot(4,1,3), plot(x,sk);
subplot(4,1,4), stem(x,enk);
g = uint8(rk);

%x = 1: 1: graylevels;
%imshow(rk);
%subplot(2,1,1), imshow(image(:,:,1));
%subplot(2,1,2), imhist(image(:,:,1));
%subplot(2,2,1), imshow(rk);
%subplot(2,2,2), imhist(rk);


% Display Histogram figure Pr(Rk) vs. Rk and
% Display Transformation figure Sk vs Rk
%subplot(5,1,1), imhist(image(:,:,1));
%x = 1 : 1 : graylevels;
%subplot(5,1,2), hist(nk,x);
%subplot(5,1,3), hist(prk,x);
%subplot(5,1,4), hist(sk,x);
%subplot(5,1,5), hist(enk,x);





%g = rk;
end

