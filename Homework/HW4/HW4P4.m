%clear all;

load('P6.mat');
%[nrows ncols ncolors] = size(X);
%data = reshape(X, [nrows*ncols ncolors]);
K=16;
[mu, compressed, errHist] = kmeansFit(X, K);