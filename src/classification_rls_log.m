%% classification with RLS linear prediction
function [accuracy] = classification_rls_log(mn_ratio, showPicture)
% stimuli by voxel
m = 500;                % num stimuli
n = round(m * mn_ratio);        % num voxels
testset_size = 100; 
noise = randn(m,1);

%% generate X, beta and y 
X = randn(m,n);
beta.truth = randn(n,1);
y = sign(X * beta.truth);

% split training set versus test set 
[X_train, y_train, X_test, y_test] = holdout_testset(X,y,testset_size);

%% compute RLS prediction 
beta.rls = inv(X_train' * X_train) * X_train' * y_train; 
y_hat.rls = sign(X_test * beta.rls);

cvfit = cvglmnet(X_train,y_train,'binomial');
y_hat.log = sign(cvglmnetPredict(cvfit, X_test)); 

% compute accuracy
accuracy.rls = sum(y_hat.rls == y_test) / length(y_test); 
accuracy.log = sum(y_hat.log == y_test) / length(y_test); 

%% plot the data 
if showPicture
    compare_rls_log_plot(y_hat, y_test)
end
end


%% HELPER FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function compare_rls_log_plot(y_hat, y_test)
g.FS = 20; 
g.LW = 4;

% compute accuracy
accuracy.rls = sum(y_hat.rls == y_test) / length(y_test); 
accuracy.log = sum(y_hat.log == y_test) / length(y_test); 

% re-order the rows 
idx_one = y_test == 1;
y_test = vertcat(y_test(~idx_one),y_test(idx_one));
y_hat.rls = vertcat(y_hat.rls(~idx_one),y_hat.rls(idx_one));
y_hat.log = vertcat(y_hat.log(~idx_one),y_hat.log(idx_one));

% plot 
subplot(2,1,1)
hold on 
plot(y_test,'linewidth', g.LW)
plot(y_hat.rls, 'o','linewidth', g.LW/2)
hold off 
legend({'Truth', 'RLS prediction'}, 'location', 'SE')
title_text = sprintf('RLS classification: accuracy.rls = %.2f', accuracy.rls);
title(title_text);
ylabel('Response')
set(gca,'fontsize', g.FS - 4)

subplot(2,1,2)
hold on 
plot(y_test,'linewidth', g.LW)
plot(y_hat.log, 'o','linewidth', g.LW/2)
hold off 
legend({'Truth', 'Logistic prediction'}, 'location', 'SE')
title_text = sprintf('Logistic classification: accuracy.rls = %.2f', accuracy.log);
title(title_text);
ylabel('Response')
xlabel('Test cases')
set(gca,'fontsize', g.FS - 4)
end