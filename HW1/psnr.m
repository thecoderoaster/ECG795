function [ res ] = psnr( mse )
%RES Peak Signal To Noise Ratio
%   Detailed explanation goes here

res = 20 * log10(255/sqrt(mse));

end

