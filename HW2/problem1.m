function [ roc ] = problem1( template, threshold, total_imgs, truedatafile )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Create a total_imgs x 2 table for ROC consisting of TP, FP
outcome_table = zeros(total_imgs, 2); 
bounding_box = zeros(1,4);
previous_tp = 0;
previous_fp = 0;
rate = 0;

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
    
    %Grab true coordinate for image x
    index = find(truetable(:,3) == img+1, 3);
    truecoord = truetable(index,[1,2]);
    
    %Create bounding box (position vector) for true location
    bounding_box(1) = truecoord(1);
    bounding_box(2) = truecoord(2);
    bounding_box(3) = 100;
    bounding_box(4) = 40;
    
    
    %Compute ROC components
    if(~isempty(s))
        for i=1:size(s,1)
            
            area1 = sum(intersect(bounding_box,s(i).BoundingBox));
            area2 = sum(union(bounding_box, s(i).BoundingBox));
            rate = area1 / area2;
        
            %fishing for TP's :)
            if(rate > 0.5)
                break
            end
        
        end 
    end
    
    if(rate > 0.5)
        %TP
        outcome_table(img+1,:) = [rate previous_fp];
        previous_tp = rate;
    else
        %FP
        outcome_table(img+1,:) = [previous_tp rate];
        previous_fp = rate;
    end
    
    
    %Run NMS on list (part c)
    
    
end

 imshow(f)
 hold on
 axis equal
 if(~isempty(s))
    for i=1:size(s,1)
        rectangle('Position', s(i).BoundingBox, 'EdgeColor', 'r');
    end
 end
 rectangle('Position', bounding_box, 'EdgeColor', 'g');
 hold off

roc = outcome_table;
end

