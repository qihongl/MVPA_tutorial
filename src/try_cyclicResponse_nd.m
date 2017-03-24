%% Predict cyclic response with OLS
clear all; clc; 

% gen data 
m = 100; 
n = 300; 
nnz_feature = 50; 
x = randn(m,n);
noise = randn(m,1);
intercept = 0; 
beta_cos = generateBeta(nnz_feature, n, 0, 'normal');
beta_sin = generateBeta(nnz_feature, n, 0, 'normal');
beta.true = vertcat(intercept, beta_cos, beta_sin); 
y = intercept + cos(x)*beta_cos + sin(x)*beta_sin + noise;  

% fourier basis transform 
X = horzcat(ones(size(x,1),1),cos(x), sin(x));

% fit mns
beta.mns = X\y; 
yhat.mns = beta.mns(1) + cos(x)*beta.mns(2:1+n) + sin(x)*beta.mns(2+n:end); 

% fit lasso 
options.alpha = 1;
cvfit = cvglmnet(X, y, 'gaussian',options);
yhat.lasso = cvglmnetPredict(cvfit, X, cvfit.lambda_min); 
best_idx = cvfit.lambda_min == cvfit.lambda; 
beta.lasso = cvfit.glmnet_fit.beta(:,best_idx); 


% plot 
subplot(221)
plot(yhat.mns,y,'o')
ylabel('y');xlabel('y hat by mns');

subplot(222)
plot(yhat.lasso,y,'o')
ylabel('y');xlabel('y hat by lasso');

subplot(223)
plot(beta.true,beta.mns,'o')
ylabel('true beta');xlabel('esitimated beta by mns');

subplot(224)
plot(beta.true,beta.lasso,'o')
ylabel('true beta');xlabel('esitimated beta by lasso');

residual.mns = norm(y - yhat.mns);
residual.lasso = norm(y - yhat.lasso);
residual