%% Predict cyclic response with OLS
clear all; clc; close all;

% set parameters 
x = 1:.1:10;
x = x';
noise = randn(length(x),1);
intercept = 10; 
beta_cos = 2;
beta_sin = 1;

% generate data 
y = intercept + beta_cos * cos(x) + beta_sin * sin(x) + noise;  
X = horzcat(ones(length(x),1),cos(x), sin(x));

% fit OLS
beta = X\y

% plot 
plot(x,y, 'o')
yhat = beta(1) + beta(2) * cos(x) + beta(3) * sin(x);  
hold on 
plot(x,yhat)
hold off 

legend({'raw data', 'prediction'})
xlabel('x');ylabel('y');title('predict cyclic response')