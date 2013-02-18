function [ sum ] = dsum(f,a,b)
%DSUM Performs a definite summation
%   Detailed explanation goes here

sum = 0;
for j = a:b
    sum = sum + f(j);
end
 
end

