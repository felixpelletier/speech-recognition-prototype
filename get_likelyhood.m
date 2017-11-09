function [ likelyhood ] = get_likelyhood( test_data, trained_set )

test_data = test_data';

%[P,nlogl] = posterior(trained_set, test_data);

%log_lh = wdensity(test_data, trained_set.mu, trained_set.Sigma, trained_set.PComponents, trained_set.SharedCov, CovType);
log_prior = log(trained_set.PComponents);
[n,d]=size(test_data);
k=size(trained_set.mu,1);
log_lh = zeros(n,k);
mahalaD = zeros(n,k);
for j = 1:k
    % compute the log determinant of covariance
    [L,f] = chol(trained_set.Sigma(:,:,j) );
    diagL = diag(L);
    if (f ~= 0) || any(abs(diagL) < eps(max(abs(diagL)))*size(L,1))
         error(message('stats:gmdistribution:wdensity:IllCondCov'));
    end
    logDetSigma = 2*sum(log(diagL));

    Xcentered = bsxfun(@minus, test_data, trained_set.mu(j,:));

    xRinv = Xcentered /L ;
    mahalaD(:,j) = sum(xRinv.^2, 2);

    log_lh(:,j) = -0.5 * mahalaD(:,j) +...
        (-0.5 *logDetSigma + log_prior(j)) - d*log(2*pi)/2;
    %get the loglikelihood for each point with each component
    %log_lh is a N by K matrix, log_lh(i,j) is log \alpha_j(x_i|\theta_j)
end

%[logl, post] = estep(log_lh);
%%%%%%estep
maxll = max (log_lh,[],2);
%minus maxll to avoid underflow
post = exp(bsxfun(@minus, log_lh, maxll));
%density(i) is \sum_j \alpha_j P(x_i| \theta_j)/ exp(maxll(i))
density = sum(post,2);
%normalize posteriors
post = bsxfun(@rdivide, post, density);
logpdf = log(density) + maxll;
logl = sum(logpdf) ;

%nlogl = -logl;

likelyhood = logl;

end



