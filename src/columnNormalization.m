%% Voxel wise standardization to N(0,1)
% note that the mean and std are estimated using the training set only
% so that the influence from test set is blocked. 
function [X_train, X_test] = columnNormalization(X_train, X_test)
% compute mean and std 
vox_mean = mean(X_train,1);
vox_sd = std(X_train,0,1);
% Z transformation 
X_train = bsxfun(@minus, X_train, vox_mean);
X_train = bsxfun(@rdivide, X_train, vox_sd);
X_test = bsxfun(@minus, X_test, vox_mean);
X_test = bsxfun(@rdivide, X_test, vox_sd);
end