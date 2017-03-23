%% test svm - binary classification 
clear all; close all; clc

load fisheriris
X = meas(51:end,3:4);
y = species(51:end);
svmStruct = svmtrain(X,y,'ShowPlot',true, 'kernel_function','rbf');

% figure(2)
% hold on 
% plot(X(1:50,1),X(1:50,2), 'r+')
% plot(X(51:end,1),X(51:end,2), 'g*')
% 
% hold off 