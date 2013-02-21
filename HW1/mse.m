function [ e ] = mse(f1,f2)
%E Mean Squared Error
%   Detailed explanation goes here


img1 = double(f1);
img2 = double(f2);

[M N] = size(img1);
diff = (double(f1) - double(f2)).^2;
MSE = mean(mean(diff,2),1)/(M * N);

e = MSE;

end
