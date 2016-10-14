%% generate a random beta vector ~ N(0,1)
% input:    total number of features
%           number of informative features
%           the magnitude of the signal
% output:   a beta vector that statisfy you choices
function beta = generateBeta(numInfoFeatures, numTotalFeatures, magnitude)
% generate the subset indices
temp = randperm(numTotalFeatures);
index = temp(1 : numInfoFeatures);
% set most of the beta to zero
beta = zeros(numTotalFeatures,1);
% set a subset of them to be randn
beta(index) = randn(size(index))*magnitude;
end