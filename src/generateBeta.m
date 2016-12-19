%% generate a random beta vector ~ N(0,1)
% input:    total number of features
%           number of informative features
%           the magnitude of the signal
% output:   a beta vector that statisfy you choices
function beta = generateBeta(nnz_feature, M, magnitude, distribution)

% generate the subset indices
temp = randperm(M);
index = temp(1 : nnz_feature);
% set most of the beta to zero
beta = zeros(M,1);

% set a subset of them to be randn
if strcmp(distribution, 'normal')
    beta(index) = randn(size(index)) + magnitude;
elseif strcmp(distribution, 'discrete')
    beta(index) = randi(magnitude, size(index));
else
    error('Unrecognizable distribution')
end
end