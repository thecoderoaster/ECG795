function [ g ] = box_filterSP( f, MN, d )
%G Summary of this function goes here
%   Detailed explanation goes here


%Add Gaussian Noise to image
img = imnoise(f,'salt & pepper', d);


%Perform MxN Filtering
filter = fspecial('average',MN);
fimg = imfilter(img, filter, 'replicate');


g = fimg;

end

