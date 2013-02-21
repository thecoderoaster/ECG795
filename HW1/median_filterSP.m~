function [ g ] = median_filterSP( f, MN, d )
%G Summary of this function goes here
%   Detailed explanation goes here

%Add Gaussian Noise to image
img = imnoise(f,'salt & pepper', d);

%Perform MxN Median Filtering
fimg = medfilt2(rgb2gray(img), MN);

g = fimg;

end

