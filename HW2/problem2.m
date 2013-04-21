function [ f ] = problem2( image )
%F Returns image with keypoints denoting corners found
%   Detailed explanation goes here

%Find corners
ret = corner_detector(image);

%Plot keypoints
imshow(image);      %# Display your image
hold on;            %# Add subsequent plots to the image

for i=1:size(ret,1)
    x = ret(i,1);
    y = ret(i,2);
    plot(y,x,'o');  %# NOTE: x_p and y_p are switched (see note below)!
end
hold off;           %# Any subsequent plotting will overwrite the image!

f = image;
end

