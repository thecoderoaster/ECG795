function [ s ] = corner_detector( image )
%X Finds the minimum eigenvalues greater than a certain threshold
%   Detailed explanation goes here

% Step 1: Read in image
%I = imread(image);
%f = im2double(I(:,:,1));
f = imread(image);
ROWS = size(f,1);
COLS = size(f,2);
lammax = zeros(ROWS,COLS);
lammin = zeros(ROWS,COLS);
angle = zeros(ROWS,COLS);

% Step 2: Compute the Image Gradient of image
[Ix Iy] = imgrad(f);
Ix2 = Ix .* Ix;
Iy2 = Iy .* Iy;
IxIy = Ix .* Iy;

% Step 3: Filter gradients with weight
w = [1 1 1; 1 1 1; 1 1 1];
a = double(imfilter(Ix2, w));
b = double(imfilter(IxIy,w));
c = double(imfilter(Iy2, w));

% Step 4: Compute Autocorrelation Matrix and Lambdas (eig)
for i=1:ROWS
    for j=1:COLS
        A = [a(i,j) b(i,j); b(i,j) c(i,j)];
        lambda = eig(A);
        lammin(i,j) = min(lambda);
        lammax(i,j) = max(lambda);
        angle(i,j) = 0.5.*atan((2.*b(i,j))/(a(i,j) - c(i,j)));
    end
end

% Step 5: Look for lammin's greater than max(lammin) * 80%
threshold = (max(lammin(:)) .* 0.80);
[rows, cols] = find(lammin > threshold);

% Step 6: Plot keypoints and vector
imshow(image);     
hold on;            

u = zeros(size(rows,1),1);
v = zeros(size(rows,1),1);
scale = zeros(size(rows, 1),1);
for i=1:size(rows,1)
    x = rows(i); 
    y = cols(i); 
    u(i) = Ix(x);
    v(i) = Iy(y);
    scale(i) = lammin(x,y);
    plot(y,x,'o');
end

quiver(cols,rows,v,u);



hold off;          

% Step 7: Package and return
s = struct('Ix',Ix, 'Iy', Iy,'LambdaMin',lammin,'LambdaMax',lammax,'Angle',angle,'Threshold',threshold','KeypointsRows',rows,'KeypointsCols',cols);

end

