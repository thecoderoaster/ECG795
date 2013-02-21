function [ g ] = median_filter( f, MN, v )
%G Summary of this function goes here
%   Detailed explanation goes here

%Add Gaussian Noise to image
%img = imnoise(f,'gaussian', 0, v);

%Perform MxN Median Filtering
fimg = medfilt2(rgb2gray(f), MN);

g = fimg;

end
