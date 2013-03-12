function [ list ] = corr_detect( template, timg, threshold )
%LIST Returns a list of image locations that are > than threshold
%   Detailed explanation goes here

%Step 1: Perform normalized correlation
g = normxcorr2(template, timg);

%Step 2: Look for locations that are > threshold and return
list = zeros(size(g,1), size(g,2));
for row=1:size(g,1)
    for col=1:size(g,2)
        if(g(row,col) > threshold)
            list(row, col) = g(row,col);
        end
    end
end


end

