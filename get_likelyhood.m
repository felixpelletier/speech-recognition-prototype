function [ likelyhood ] = get_likelyhood( test_data, trained_set )

test_data = test_data';

[~,nlogl] = posterior(trained_set, test_data);

likelyhood = -nlogl;

end



