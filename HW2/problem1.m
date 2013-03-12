function [ roc ] = problem1( template, threshold, total_imgs, truedatafile )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Read in and parse the true data set
fileID = fopen(truedatafile, 'r');
frewind(fileID);
formatspec = '%s'
truedata = textscan(fileID, formatspec, 'CollectOutput',true);
fclose(fileID);
data = strtok(truedata{1},':()')
% for i = 1:size(data,1)
% newdata = textscan(data{i},'(%u8,%u8)\n', 'CollectOutput', true);
% end
data = cellfun(@str2num,data,'UniformOutput',false);
%data(any(cellfun('isempty',data),2),:) = []; 
data = cell2mat(data);
%Organize data in 169x6 matrix
% trueset = zeros(total_imgs,6);
% for i=1:size(data,1)
%      while((ret = strtok(data{i}, ':')))
%         trueset
%      end
% end


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

