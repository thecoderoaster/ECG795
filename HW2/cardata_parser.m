function [ table ] = cardata_parser( datafile )
%TABLE Parses out trueLocations.txt file only and returns a matrix
%   Each line is read from the datafile and parsed out for
%   coordinates. Each coordinate has a tag that denotes which
%   image that coordinate belongs to. Images with multiple 
%   coordinates have the same tag on multiple rows. The tag
%   is the third column in the matrix.

%Step 1: Open the file with read access
fileID = fopen(datafile, 'r');
truetable = [];
row = 1;
while(feof(fileID) ~= 1)
    
    %Step 2: Grab a line from the datafile
    %        and determine how many coordinates there are
    %        by looking at commas
    str = fgetl(fileID);
    commas = strfind(str,',');
    
    %Step 3: Pre Tokenize, if only one comma we're done...
    [token, remain] = strtok(str);
    if(size(commas(:),1) ==  1)
        xy = textscan(remain, '(%d16,%d16)');
        xy = horzcat(xy, row);
        truetable = vertcat(truetable,xy);
    else
        %Step 4: Otherwise... keep breaking into tokens
        for i = 1:size(commas(:),1)
            [token, remain] = strtok(remain);
            xy = textscan(token, '(%d16,%d16)');
            xy = horzcat(xy, row);
            truetable = vertcat(truetable,xy);
        end
    end
    row = row + 1;
end

fclose(fileID);

%Step 5: Convert your cell to a matrix.
data = cellfun(@int16,truetable,'UniformOutput',false);
table = cell2mat(data);

%Example: How to find an image coordinates:
% >> index = find(table(:,3) == 21, 3);
%
% Here, we're looking in the third column for image 21,
% which for the trueLocations.txt file returns index 34
% in our new matrix table above.

% >> table(index,[1,2]);
%
% Once you know the index, you can extract the coordinates
% and do what you want with the values.
end

