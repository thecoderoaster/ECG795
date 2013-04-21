function [ X ] = problem3( image )
%X Finds the minimum eigenvalues greater than a certain threshold
%   Detailed explanation goes here

% Step 1: Read in image
f = imread(image);
ROWS = size(f,1);
COLS = size(f,2);
lammax = zeros(ROWS,COLS);
lammin = zeros(ROWS,COLS);
gray = rgb2gray(f);

% Step 2: Compute the Image Gradient of image
[Ix Iy] = imgrad(gray);
Ix2 = Ix .* Ix;
Iy2 = Iy .* Iy;
IxIy = Ix;

% Step 3: Filter gradients with weight
w = [1 1 1; 1 1 1; 1 1 1];
a = imfilter(Ix2, w);
b = imfilter(IxIy,w);
c = imfilter(Iy2, w);

% Step 4: Compute Autocorrelation Matrix and Lambdas (eig)
for i=1:ROWS
    for j=1:COLS
        A = [a(i,j) b(i,j); b(i,j) c(i,j)];
        lambda = eig(double(A));
        lammin(i,j) = min(lambda);
        lammax(i,j) = max(lambda);
    end
end

% Step 5: Look for lammin's greater than max(lammin) * 80%
threshold = (max(lammin(:)) .* 0.80);
[rows, cols] = find(lammin > threshold);

% Step 6: Plot keypoints and vector
imshow(gray);     
hold on;            

for i=1:size(rows,1)
    x = rows(i); 
    y = cols(i); 
    %u = Ix(x);
    %v = Iy(y);
    plot(y,x,'o');
    %quiver(y,x,v,u);
end



hold off;          

X = image;
end