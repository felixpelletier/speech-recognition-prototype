%[one, one_deltas, one_deltadeltas] = get_trained_matrix('google_dataset/one');
%[two, two_deltas, two_deltadeltas] = get_trained_matrix('google_dataset/two');
%[three, three_deltas, three_deltadeltas] = get_trained_matrix('google_dataset/three');

'Done Training'

test_files = get_files_for_word('google_dataset/one');
success = 0;
file_count = 0;
total = length(test_files)-100
for i = 1001:1201
    test_file = test_files{i};
    mfccs = get_mfccs_from_file(test_file);
    mfccs_static = mfccs(1:12, :);
    mfccs_deltas = mfccs(13:24, :);
    mfccs_deltadeltas = mfccs(25:36, :);
    one_likelyhood = 0.20*get_likelyhood(mfccs_static, one);
    one_likelyhood = one_likelyhood + get_likelyhood(mfccs_deltas, one_deltas);
    one_likelyhood = one_likelyhood + get_likelyhood(mfccs_deltadeltas, one_deltadeltas);
    two_likelyhood = 0.20*get_likelyhood(mfccs_static, two);
    two_likelyhood = two_likelyhood + get_likelyhood(mfccs_deltas, two_deltas);
    two_likelyhood = two_likelyhood + get_likelyhood(mfccs_deltadeltas, two_deltadeltas);
    three_likelyhood = 0.20*get_likelyhood(mfccs_static, three);
    three_likelyhood = three_likelyhood + get_likelyhood(mfccs_deltas, three_deltas);
    three_likelyhood = three_likelyhood + get_likelyhood(mfccs_deltadeltas, three_deltadeltas);
    likelyhoods = [one_likelyhood two_likelyhood three_likelyhood]
    digit = find(likelyhoods == max(likelyhoods));
    if (digit == 1)
        success = success + 1;
    end
    file_count = file_count + 1
end

(success/file_count) * 100
