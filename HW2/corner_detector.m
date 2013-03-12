function [ X ] = corner_detector( image )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Step 1: Read in image
f = double(imread(image));

% Step 2: Blur Image with Gaussian Filter using 3x3 box and sigma = 1
gaussfilter = fspecial('gaussian',[3 3], 1.0);
blurredimage = imfilter(f, gaussfilter, 'replicate');

% Step 3: Take Laplacian of image (horizontal and vertical derivatives)
laplacian = del2(blurredimage);

% Step 4: Compute the Autocorrelation matrix
% A = size(laplacian(:,:,1));
% L = laplacian(:,:,1);
% for row = 1:size(A,1)
%     for col = 1:size(A,1)
%         A(row,col) = conv2([L(row).*L(row),L(row).*L(col);1, L(col).*L(col)],gaussfilter);
%     end
% end

A = conv2(laplacian(:,:,1), gaussfilter);
%[V,D] = eig(A);
%[V,D] = eigs(A);

[rows, cols] = find(A < (min(A(:))*0.80));
X = ([rows, cols]);

end

