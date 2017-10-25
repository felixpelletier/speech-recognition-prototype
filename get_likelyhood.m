function [ likelyhood ] = get_likelyhood( test_data, trained_set )

likelyhood = inf;
for i = 1:size(test_data, 2)
    trained_set_squared_diffs = zeros(1, size(trained_set, 2));
    for j = 1:size(trained_set,2)
        trained_set_squared_diffs(j) = sum((trained_set(:, j) - test_data(:, i)).^2);
    end
    local_likelyhood = min(trained_set_squared_diffs);
    likelyhood = min([likelyhood local_likelyhood]);
end



