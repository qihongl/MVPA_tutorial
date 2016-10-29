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
beta.truth = generateBeta(numNonZeroFeatures, n, 5, 'normal');
probability = 1 ./ (1 + exp(-X * beta.truth));
y = binornd(1,probability);

%% fitting logistic regression with L1 & L2 regularizer
options.nlambda = 100; 
% fit lasso
options.alpha = 1; 
cvfit.lasso = cvglmnet(X,y, 'binomial', options);
beta.lasso = cvglmnetCoef(cvfit.lasso, 'lambda_min');
beta.lasso(1) = [];
% figure(2);cvglmnetPlot(cvfit.lasso)

% fit ridge model 
options.alpha = 0; 
cvfit.ridge = cvglmnet(X,y, 'binomial', options);
beta.ridge = cvglmnetCoef(cvfit.ridge, 'lambda_min');
beta.ridge(1) = [];

%% compute TP/FP
[TP.lasso, FP.lasso] = computeTPFP(beta.truth, beta.lasso);
[TP.ridge, FP.ridge] = computeTPFP(beta.truth, beta.ridge);

%% compare solution with the truth 
g.FS = 20; 
g.LW = 2;

figure(1)
subplot(131)
compareBeta(beta.lasso, beta.truth,'Lasso esimates','True beta', g, false)
subplot(132)
compareBeta(beta.ridge, beta.truth,'Ridge estimates','True beta', g, false)

% hits & false rate bar plot 
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

%% unsupervised analysis 

[U,S,V] = svd(X);

figure(2)
plot(diag(S))
