%one = get_trained_matrix('google_dataset/one');
%two = get_trained_matrix('google_dataset/two');
%three = get_trained_matrix('google_dataset/three');

'Done Training'

test_files = get_files_for_word('google_dataset/one');
success = 0;
file_count = 0;
total = length(test_files)-100
for i = 1001:1201
    test_file = test_files{i};
    mfccs = get_mfccs_from_file(test_file);
    one_likelyhood = get_likelyhood(mfccs, one);
    two_likelyhood = get_likelyhood(mfccs, two);
    three_likelyhood = get_likelyhood(mfccs, three);
    likelyhoods = [one_likelyhood two_likelyhood three_likelyhood];
    digit = find(likelyhoods == max(likelyhoods));
    if (digit == 1)
        success = success + 1;
    end
    file_count = file_count + 1
end

(success/file_count) * 100
