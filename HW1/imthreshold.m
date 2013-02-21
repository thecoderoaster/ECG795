function [ g ] = imthreshold( f, T1 )
%G Provides a thresholded version of the input
%   Based on a threshold value, the input image
%   is rasterized pixel-by-pixel, generating an 
%   output image that's either 0(Black) or 1(White)

%Grab some stats on image
ROWS = size(f,1);
COLS = size(f,2);
%RGB = size(f,3);
%IMG_SIZE = ROWS * COLS;

hsv_img = rgb2hsv(f);
bw = zeros(ROWS,COLS);

%Threshold Input
for row = 1:ROWS
    for cols = 1:COLS
        if(hsv_img(row,cols,1) < T1 )
            bw(row,cols) = 1;
        else
            bw(row,cols) = 0;
        end
    end
   
end


%MN = [3,3];
%S = strel('rectangle', MN);

%Pattern that resembles the makeup of a face
MN = [0, 0, 1, 1, 1, 1, 1, 1, 0, 0;
      0, 1, 1, 1, 1, 1, 1, 1, 1, 0;
      1, 1, 1, 1, 1, 1, 1, 1, 1, 1; 
      1, 1, 1, 1, 1, 1, 1, 1, 1, 1;
      1, 1, 1, 1, 1, 1, 1, 1, 1, 1;
      1, 1, 1, 1, 1, 1, 1, 1, 1, 1;
      1, 1, 1, 1, 1, 1, 1, 1, 1, 1;
      1, 1, 1, 1, 1, 1, 1, 1, 1, 1;
      1, 1, 1, 1, 1, 1, 1, 1, 1, 1;
      1, 1, 1, 1, 1, 1, 1, 1, 1, 1;
      1, 1, 1, 1, 1, 1, 1, 1, 1, 1;
      1, 1, 1, 1, 1, 1, 1, 1, 1, 1;
      1, 1, 1, 1, 1, 1, 1, 1, 1, 1;
      1, 1, 1, 1, 1, 1, 1, 1, 1, 1;
      0, 1, 1, 1, 1, 1, 1, 1, 1, 0;
      0, 0, 1, 1, 1, 1, 1, 1, 0, 0;
      0, 0, 0, 1, 1, 1, 1, 0, 0, 0;
      0, 0, 0, 0, 1, 1, 0, 0, 0, 0;
      0, 0, 0, 0, 0, 1, 0, 0, 0, 0;
      0, 0, 0, 0, 0, 1, 0, 0, 0, 0];
S = strel(MN);
eroded_output = imerode(bw,S);
opened_output = imdilate(eroded_output,S);
dilated_output = imdilate(opened_output,S);
imshow(dilated_output);
%imshow(bw);


%Look for connected components and bound (NOT WORKING)
cc = bwconncomp(dilated_output);
stats = regionprops(cc, 'Area', 'BoundingBox');
bb = cat(1, stats.BoundingBox);
idx = find([stats.Area] > 900);
bw2 = ismember(labelmatrix(cc), idx);
imshow(bw2);
hold on
for elements = 1:numel(idx)
    %bb = find([stats.BoundingBox] == idx(elements));
    plot(bb(idx(elements),1), bb(idx(elements),2), bb(idx(elements),3), bb(idx(elements),4), 'b*');
end
hold off
L = labelmatrix(cc);
L2 = bwlabel(bw);
g = L2;
end

