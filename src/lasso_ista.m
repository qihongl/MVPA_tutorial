%% lasso with iterative soft thresholding & landweber iteration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input     X           m by n design matrix
%           y           m by 1 responses 
%           lambda(>0)  regularization parameter, 
%           display     show progress
% output    beta        the lasso solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [beta] = lasso_ista(X, y, lambda, display)
% constants
MAX_ITERS = 1e4;        % maximum number of iterations 
TOLERANCE = 1e-6;       % convergence tolerance
tau = .99 / norm(X)^2;  % choose stepsize
[~,n] = size(X);

% precompute repeated matrix operations
XTX = X' * X;               
XTy = X' * y;

%% iterative soft-thresholding
beta = zeros(n,1);          % preallocate
for i = 1: MAX_ITERS
    % parameter update with landweber iteration
    z = beta - tau * (XTX * beta - XTy);
    betaPrev = beta;
    beta = sign(z) .* max( abs(z) - tau * lambda/2, 0 );
    
    % display progress
    if display
        fprintf('Iter: %4d \t yDev: %f \t betaChange: %f\n', i, norm(y - X*beta,2), norm(beta - betaPrev));
    end
    % stop criteria
    if norm(beta - betaPrev,1) < TOLERANCE
        break
    end
end

end