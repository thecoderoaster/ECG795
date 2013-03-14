function [ roc ] = problem1( template, threshold, total_imgs, truedatafile )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Read in and parse the true data set
truetable = cardata_parser(truedatafile);

for img = 0:total_imgs
    %Grab image
    imgnum = int2str(img);
    path = strcat('CarData/TestImages/test-',imgnum,'.pgm');
    f = imread(path);
    
    %Run correlation and determine bounds
    list = corr_detect(template,f,threshold);
    label = bwlabel(list);
    s = regionprops(label,'Area','BoundingBox');
    
    
    
    %Run NMS on list (part c)
    
    
end

% imshow(f)
% hold on
% axis equal
% rectangle('Position', s.BoundingBox, 'EdgeColor', 'r');
% hold off

roc = s;
end

