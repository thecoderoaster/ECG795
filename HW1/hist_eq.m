function [ g ] = hist_eq( image, graylevels )
%HISTOEQ Equalizes the histogram of an input image
%   Detailed explanation goes here


% Variables
ROWS = size(image,1);
COLS = size(image,2);
rk = zeros(ROWS ,COLS);
sk = zeros(graylevels,1);
enk = zeros(graylevels,1);
prk = zeros(graylevels,1);
psk = zeros(graylevels,1);
img_size = ROWS * COLS;

%Normalize



% Find the number of pixels that have intensity
% rk. (Generate Histogram)
nk = imhist(image(:,:,1),graylevels);
for i = 1:graylevels
   %nk(i,1) = sum(sum(image(:,:,1) == i));
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
for row = 1 : ROWS 
    for col = 1 : COLS
        norm_value = normalize(double(image(row,col,1)),0,255,graylevels);
        rk(row,col) = denormalize(sk(norm_value,1),0,255,graylevels);
    end
end


g = uint8(rk);

end

%*************************************************
function [ y ] = normalize(x, A, B, range)
%Y Normalized value

    y = uint8(1 + ((x - A) * (range - 1))/(B-A));
end

%*************************************************

function [ x ] = denormalize(y, A, B, range)
%X Denormalized value
    
    x = uint8(A + ((B-A)*(y-1))/(range - 1));
end
%*************************************************

function [ sum ] = dsum(f,a,b)
%DSUM Performs a definite summation
%   Detailed explanation goes here

sum = 0;
for j = a:b
    sum = sum + f(j);
end
 
end
