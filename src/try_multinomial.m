%% test multinomial classification 
clear all; close all;
% load data 
load fisheriris.mat; X = meas; 

% fit lasso 
cvfit = cvglmnet(X, species, 'multinomial');
yhat = cvglmnetPredict(cvfit, X, 'lambda_min'); 

% compute the prediction 
yhat = bsxfun(@eq, max(yhat,[],2), yhat);

% calculate the accuracy
y = zeros(150,3); 
y(1:50,1) = 1; 
y(51:100,2) = 1;
y(101:150,3) = 1;
sum(y & yhat)