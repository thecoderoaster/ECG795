function [ g ] = filtering( f, v )
%G Summary of this function goes here
%   Detailed explanation goes here

%Add Gaussian Noise to image
J = imnoise(f,'gaussian', 0, v);

g = J

end

