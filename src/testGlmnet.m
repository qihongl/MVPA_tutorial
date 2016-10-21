%% test if glmnet is properly linked with MATLAB
rng(1)
M = 20;
N = 10; 
% generate data 
X = randn(M,N);
beta = randn(N,1);
y = X * beta;
% compute model fit 
cvfit = cvglmnet(X,y);
cvglmnetPlot(cvfit)