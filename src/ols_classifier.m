%% least square classification
% Reference: 
% 1. http://stackoverflow.com/questions/22491359/least-squares-linear-classifier-in-matlab
clear variables; clf;
%% generated data 
% Parameters for creatinga the two clusters 
M = 100;
N = 2;
variance1 = .3;
variance2 = .6;
center1 = [6 6];
center2 = [-2,-1];

X1 = variance1 * bsxfun(@plus, randn(M, N), center1);
X2 = variance2 * bsxfun(@plus, randn(M, N), center2);
X = [[X1; X2] ones(2*M, 1)];    % add intercept term
y = [ones(M, 1); -ones(M, 1)];

%% Solve least squares problem
beta.ls = inv(X' * X) * X' * y; 


%% Plot data points and OLS boundary
bound = 3; 
x = -bound:.1:bound;
boundary = -beta.ls(3)/beta.ls(2) - (beta.ls(1)/beta.ls(2))*x;

hold on;
plot(X1(:, 1), X1(:, 2), 'bx', 'linewidth', 2); 
plot(X2(:, 1), X2(:, 2), 'ro', 'linewidth', 2); 
xlim([-bound bound]); ylim([-bound bound]);
plot(x, boundary, 'k', 'linewidth', 2);
legend({'Class 0', 'Class 1', 'OLS Boundary'}, 'location', 'SE')
set(gca,'fontsize', 16)