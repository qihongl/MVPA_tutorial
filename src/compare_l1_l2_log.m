%% lasso experiment 
clear variables; clf; 
seed = 1;  rng(seed); 
% stimuli by voxel
m = 500;        % num stimuli
n = 500;        % num voxels
numNonZeroFeatures = 50; 
% noise = randn(m,1);

%% generate X, beta, then y <- X * beta + noise 
X = randn(m,n);
beta.truth = generateBeta(numNonZeroFeatures, n, 0, 'normal');
probability = sigmoid(X * beta.truth);
y = binornd(1,probability);

%% separate the training set and the test set 
% hold out half of the data 
testset_idx = false(m,1); 
testset_idx(1 : (m / 2 )) = true; 
X_train = X(~testset_idx,:);
y_train = y(~testset_idx); 
X_test = X(testset_idx,:);
y_test = y(testset_idx);

%% fitting logistic regression with L1 & L2 regularizer
options.nlambda = 100; 
% fit lasso
options.alpha = 1; 
cvfit.lasso = cvglmnet(X_train, y_train, 'binomial', options);
beta.lasso = cvglmnetCoef(cvfit.lasso, 'lambda_min');
beta.lasso(1) = [];
% figure(2);cvglmnetPlot(cvfit.lasso)

% fit ridge model 
options.alpha = 0; 
cvfit.ridge = cvglmnet(X_train,y_train, 'binomial', options);
beta.ridge = cvglmnetCoef(cvfit.ridge, 'lambda_min');
beta.ridge(1) = [];

%% compute TP/FP 
% w.r.t beta 
[TP.beta.lasso, FP.beta.lasso] = computeTPFP(beta.truth, beta.lasso);
[TP.beta.ridge, FP.beta.ridge] = computeTPFP(beta.truth, beta.ridge);

% w.r.t labels 
pred.lasso = sigmoid(X_test * beta.lasso); 
pred.ridge = sigmoid(X_test * beta.ridge);
% compute the classification accuracy
accuracy.lasso = sum(round(pred.lasso) == y_test) / length(y_test); 
accuracy.ridge = sum(round(pred.ridge) == y_test) / length(y_test); 

%% compare solution with the truth 
g.FS = 20; 
g.LW = 2;

figure(1)
subplot(221)
compareBeta(beta.lasso, beta.truth,'Lasso esimates','True beta', g, false)
subplot(222)
compareBeta(beta.ridge, beta.truth,'Ridge estimates','True beta', g, false)

% hits & false rate bar plot 
subplot(223)
mybar = bar([1,2,3], ...
    [nnz(beta.truth), 0; TP.beta.lasso, FP.beta.lasso; TP.beta.ridge, FP.beta.ridge], 'stacked');
legend(mybar, {'True positive','False positive'}, 'Location','NW');
set(gca,'XTickLabel',{'truth','lasso', 'ridge'})
hold on 
plot([0 4],[nnz(beta.truth) nnz(beta.truth)], 'k--')
hold off 
ylim([0 n])
xlim([0 4])
title('Feature selection')
ylabel('Number of Nonzero Weights', 'fontsize', g.FS)
xlabel('Methods', 'fontsize', g.FS)
set(gca,'fontsize', g.FS - 4)

% plot ROC curve
subplot(224)
hold on 
[TP.lasso,FP.lasso,~,AUC.lasso] = perfcurve(y_test,pred.lasso,1); 
plot(TP.lasso,FP.lasso, 'linewidth',g.LW)
[TP.ridge,FP.ridge,~,AUC.ridge] = perfcurve(y_test,pred.ridge,1); 
plot(TP.ridge,FP.ridge, 'linewidth',g.LW)
hold off 
title('ROC curves')
ylabel('True Positive Rate')
xlabel('False Positive Rate')
legend({'Lasso','Ridge'}, 'Location','SE');
set(gca,'fontsize', g.FS - 4)

%% print some performance metrics
accuracy
AUC

%% unsupervised analysis 

% [U,S,V] = svd(X);
% 
% figure(2)
% plot(diag(S))
