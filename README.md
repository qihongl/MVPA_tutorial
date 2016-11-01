# MVPA_tutorial
MVPA tutorial - Rogers lab brain imaging unit [<a href = "https://github.com/QihongL/MVPA_tutorial/wiki">Wiki page</a>]

I am organizing the brain imaging unit at the <a href = "http://concepts.psych.wisc.edu/" > Knowledge and Concepts Lab</a>, directed by Professor <a href = "http://concepts.psych.wisc.edu/index.php/tim-rogers/">Tim Rogers</a>. This is a tutorial (in progress) that introduces people to MVPA methods. 

Neuroimaging data analysis is usually <a href = "https://en.wikipedia.org/wiki/Underdetermined_system">underdetermined</a>. For example, a typical fMRI data might has 100,000 features (voxels) with only a few hunderds of training examples (stimuli presented). To tackle this issue of underdeterminacy while fitting the whole brain model (i.e. without pre-defining ROIs), we tend to use sparse methods, such as the Logistic LASSO, which will be the main focus of this tutorial.  


### The Brain Imaging Unit - Meeting
- You can access the <a href = "https://github.com/QihongL/MVPA_tutorial/wiki/0.-Schedule">meeting schedule</a> from the wiki page. 

- Where and when: Wednesday 4pm at Psych 634

### Tutorial Content 
- <a href = "https://github.com/QihongL/MVPA_tutorial/wiki/1.-Sparsity:-OLS-with-L1-vs.-L2">Compare L1 & L2 penalty: Linear Regression</a>
- <a href = "https://github.com/QihongL/MVPA_tutorial/wiki/2.-Logistic-Regression">Logistic Regression</a>
- <a href = "https://github.com/QihongL/MVPA_tutorial/wiki/3.-Sparsity:-Logistic-Lasso">Compare L1 & L2 penalty: Logistic Regression</a>
- Iterative Lasso
- Group Lasso, SOS Lasso
- Readings



### Dependencies
- Matlab 
- <a href = "http://web.stanford.edu/~hastie/glmnet_matlab/">Glmnet</a>: A Matlab toolbox for fitting the elastic-net for linear regression, logistic and multinomial regression, Poisson regression and the Cox model.

### Reference: 
- Glmnet for Matlab (2013) Qian, J., Hastie, T., Friedman, J., Tibshirani, R. and Simon, N.
http://www.stanford.edu/~hastie/glmnet_matlab/
