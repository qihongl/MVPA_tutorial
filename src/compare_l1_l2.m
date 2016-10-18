%% lasso experiment 
clear variables; clf; 
seed = 1;  rng(seed); 
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
% % fit regular least square 
% beta.normal = inv(X' * X) * X' * y; 

%% compare solution with the truth 
g.FS = 20; 
g.LW = 2; 
figure(1)

subplot(131)
compareBeta(beta.lasso, beta.truth,'Lasso esimates','True beta', g)
subplot(132)
compareBeta(beta.ridge, beta.truth,'Ridge estimates','True beta', g)
% subplot(313)
% compareBeta(beta.normal,beta.truth,'regular LS esimates','Truth', g)
subplot(133)

% bar([1,2,3,4],[nnz(beta.truth), nnz(beta.lasso), nnz(beta.ridge), nnz(beta.normal)])
bar([1,2,3],[nnz(beta.truth), nnz(beta.lasso), nnz(beta.ridge)])
set(gca,'XTickLabel',{'truth','lasso', 'ridge'}, 'fontsize', g.FS - 4)
hold on 
plot([0 4],[nnz(beta.truth) nnz(beta.truth)], 'k--')
hold off 
ylim([0 n])
xlim([0 4])
ylabel('Number of Nonzero Weights', 'fontsize', g.FS)
xlabel('Methods', 'fontsize', g.FS)
