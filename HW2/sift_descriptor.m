function [ D ] = sift_descriptor( image1, image2)
%D Returns 128 Dimension vector of keypoints in both images
%   Detailed explanation goes here


% Step 1: Find keypoints in image 1
s1 = corner_detector(image1);

% Step 2: Find keypoints in image 2
s2 = corner_detector(image2);

% Step 3: Construct 16x16 matrix grid around keypoints (image 1)
D1 = sift_bin8(s1);

% Step 4: Construct 16x16 matrix grid around keypoints (image 2)
D2 = sift_bin8(s2);

% Step 5: Compare vectors

end

function [ D ] = sift_bin8( s1 )

GRID_16 = zeros(16,16);

rows = s1(1).KeypointsRows;
cols = s1(1).KeypointsCols;
angles = s1(1).Angle;

%for k = 1:size(rows(:),1)  %Takes forever to compute... 36,000+ keypoints!
for k = 1:1000              %Just look at first 1000 for time being...
    %Grab next keypoint
    if(k < size(rows(:),1))
        x1 = rows(k) - 8;
        y1 = cols(k) - 8;
    else
        break;
    end
    
    % Step 4: Run through grid and grab angles
    if(x1 > 0 && y1 > 0)
        for i=1:16
            for j=1:16
                if((x1+i > 0) && (x1+i < size(angles(:,1),1)) && (y1+i > 0) && (y1+i < size(angles(1,:),2)))
                    %Still in image bounds...
                    if(angles(x1+i, y1+j) < 0)
                        %Negative radian, add 2pi
                        GRID_16(i,j) = ((2 .* pi) + angles(x1+i,y1+j));
                    else
                        GRID_16(i,j) = angles(x1+i,y1+j);
                    end
                else
                    %Out of bounds!
                    GRID_16(i,j) = 0;
                end
            end
        end
    end
    
    % Step 5: Take 4x4 of 16x16 grid and place angles in 8 bins from 0 to 2pi 
    %         to get 128D vector.
    a = 0;
    b = 0;
    d128Vector = zeros(128,1);
    
    while(a < 16)
        while(b < 16)
            for c = 1:4
                for d = 1:4
                   d128Vector(a+c) = GRID_16(a+c,b+d);
                end
                
            end
            b = b + 4;
        end
        a = a + 4;
        b = 0;
    end
end

D = d128Vector;
end
