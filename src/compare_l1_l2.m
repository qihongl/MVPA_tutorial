%% lasso experiment 
clear variables; clf; 
% seed = 2;  rng(seed); 
% stimuli by voxel
m = 256;        % num stimuli
n = 512;        % num voxels
numNonZeroFeatures = 100; 
noise = randn(m,1);

% generate X, beta and y 
X = randn(m,n);
beta.truth = generateBeta(numNonZeroFeatures, n, 1);
y = X * beta.truth;

%% iteratively fitting reweighted-lasso
lambda = 1;
% fit lasso
beta.lasso = lasso_ista(X, y, lambda, false);
% fit ridge
[U,S,V] = svd(X, 'econ');
beta.ridge = V * inv(S^2 + eye(size(S))*lambda) * S * U' * y;
% fit regular least square 
beta.normal = inv(X' * X) * X' * y; 

%% compare solution with the truth 
g.FS = 20; 
g.LW = 2; 
figure(1)

subplot(221)
compareBeta(beta.lasso, beta.truth,'lasso esimates','Truth', g)
subplot(222)
compareBeta(beta.ridge, beta.truth,'ridge estimates','Truth', g)
subplot(223)
compareBeta(beta.normal,beta.truth,'regular LS esimates','Truth', g)
subplot(224)
bar([1,2,3,4],[nnz(beta.truth), nnz(beta.lasso), nnz(beta.ridge), nnz(beta.normal)])
set(gca,'XTickLabel',{'truth','lasso', 'ridge', 'regular LS'}, 'fontsize', g.FS - 4)
ylabel('Number of Nonzero Weights', 'fontsize', g.FS)
xlabel('Methods', 'fontsize', g.FS)
