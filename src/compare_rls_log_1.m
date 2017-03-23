%% least square classification
% Reference: 
% 1. http://stackoverflow.com/questions/22491359/least-squares-linear-classifier-in-matlab
clear variables; clf;
%% generated data 
% Parameters for creatinga the two clusters 
M = 100;
N = 2;

variance1 = .2;
variance2 = .5;
center1 = [4 2];
center2 = [-3,-1]; 
center3 = [-6,-2]; 


X1 = variance1 * bsxfun(@plus, randn(M, N), center1);
X2 = variance2 * bsxfun(@plus, randn(M, N), center2);
% X3 = variance2 * bsxfun(@plus, randn(M, N), center3);

X = [X1; X2];  
X_aug = [ones(2*M, 1) X];    % add intercept term
y = [ones(M, 1); -ones(M, 1)];
% y = [ones(M, 1); -ones(M, 1); ones(M,1)];

%% Solve least square & logistic optimization 
beta.ls = inv(X_aug' * X_aug) * X_aug' * y; 
fit = cvglmnet(X, y, 'binomial');
% fit = cvglmnet(X,y, 'gaussian');
beta.log = cvglmnetCoef(fit,'lambda_min');

svmStruct = svmtrain(X, y,'ShowPlot',true);

%% Plot data points and boundary
% compute the boundaries
bound = 3; 
x = -bound:.1:bound;
boundary.ls = -beta.ls(1)/beta.ls(3) - (beta.ls(2)/beta.ls(3))*x;
boundary.log = -beta.log(1)/beta.log(3) - (beta.log(2)/beta.log(3))*x;
% plot 
hold on;
% plot(X1(:, 1), X1(:, 2), 'kx', 'linewidth', 2); 
% plot(X2(:, 1), X2(:, 2), 'ko', 'linewidth', 2); 
xlim([-bound bound]); ylim([(min(X(:,2))-.25) max(X(:,2))+.25]);
plot(x, boundary.ls, 'r', 'linewidth', 2);
plot(x, boundary.log, 'g', 'linewidth', 2);
legend({'Class 0','Class 1', 'SVs','SVM','OLS','LOG'}, 'location', 'SE')
title('Compare least square loss and logistic loss')
xlabel('X_1')
ylabel('X_2')
set(gca,'fontsize', 16)