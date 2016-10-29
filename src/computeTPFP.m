function [ TP, FP ] = computeTPFP(truth, prediction)
%UNTITLED3 Summary of this function goes here

% TP: truth is nonzero & our esitimation is also nonzero
TP = sum((truth ~= 0) & (prediction ~= 0));
% FP: truth is nonzero & our esitimation is zero
FP = sum((truth == 0) & (prediction ~= 0));

end

