%% lasso experiment 
clear variables; clf; 
seed = 1;  rng(seed); 
% stimuli by voxel
m = 256;        % num stimuli
n = 512;        % num voxels
numNonZeroFeatures = 512; 
noise = randn(m,1);

% generate X, beta and y 
X = randn(m,n);
beta.truth = generateBeta(numNonZeroFeatures, n, 0, 'normal');
y = X * beta.truth;

%% fitting least square model with L1 & L2 regularizer
lambda = 1;
% fit lasso
beta.lasso = lasso_ista(X, y, lambda, false);
% fit ridge
[U,S,V] = svd(X, 'econ');
beta.ridge = V * inv(S^2 + eye(size(S))*lambda) * S * U' * y;

% fit regular least square 
beta.normal = inv(X' * X) * X' * y; 

%% compute TP/FP
[TP.lasso, FP.lasso] = computeTPFP(beta.truth, beta.lasso);
[TP.ridge, FP.ridge] = computeTPFP(beta.truth, beta.ridge);

%% compare solution with the truth 
g.FS = 20; 
g.LW = 2; 
figure(1)

subplot(131)
compareBeta(beta.lasso, beta.truth,'Lasso esimates','True beta', g, true)
subplot(132)
compareBeta(beta.ridge, beta.truth,'Ridge estimates','True beta', g, true)
subplot(133)
mybar = bar([1,2,3], ...
    [nnz(beta.truth), 0; TP.lasso, FP.lasso; TP.ridge, FP.ridge], 'stacked');
legend(mybar, {'True positive','False positive'}, 'Location','NW');
set(gca,'XTickLabel',{'truth','lasso', 'ridge'})

hold on 
plot([0 4],[nnz(beta.truth) nnz(beta.truth)], 'k--')
hold off 
ylim([0 n])
xlim([0 4])
ylabel('Number of Nonzero Weights', 'fontsize', g.FS)
xlabel('Methods', 'fontsize', g.FS)
set(gca,'fontsize', g.FS - 4)

%% 
figure(2)
compareBeta(beta.normal,beta.truth,'regular LS esimates','Truth', g, false)

