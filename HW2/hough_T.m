%Used HoughTransform from RosettaCode and Szeliski as guidance/example
%Link: http://rosettacode.org/wiki/Example:Hough_transform/MATLAB
function [ space ] = hough_T( img, theta_freq )
%SPACE Hough Space
%   Detailed explanation goes here

    RGB = imread(img);
    I = rgb2gray(RGB);

    I = flipud(I);
    [w, h] = size(I);
    
    rhoLimit = norm([w, h]);
    rho = (-rhoLimit:1:rhoLimit);
    theta = (-pi:theta_freq:pi);
    
    totalThetas = numel(theta);
    space = zeros(numel(rho),totalThetas);
    
    %Look for the edge pixels
    [x, y] = find(I);
    
    %Allocate space for accumulator
    totalEdges = numel(x);
    accumulator = zeros(totalEdges, totalThetas);
    
    %Allocate cosine and sine calculations
    cosine = (0:w - 1)'*cos(theta);
    sine = (0:h - 1)'*sin(theta);
    
    accumulator((1:totalEdges),:) = cosine(x,:) + sine(y,:);
    
    %Bin the rhos
    for i = (1:totalThetas)
        space(:,i) = hist(accumulator(:,i),rho);
    end
    
    pcolor(theta, rho, space);
    shading flat;
    title('Hough Transform');
    xlabel('Theta (radians)');
    ylabel('Rho (pixels)');
    colormap(hot);
end

