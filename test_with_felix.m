%one = get_trained_matrix('google_dataset/one');
%two = get_trained_matrix('google_dataset/two');
%three = get_trained_matrix('google_dataset/three');

'Done Training'

test_files = {
    'custom_dataset/felix_one.wav', ...
    'custom_dataset/felix_two.wav', ...
    'custom_dataset/felix_three.wav' ...
 };
results = zeros(length(test_files), 1);
for i = 1:length(test_files)
    test_file = test_files{i};
    mfccs = get_mfccs_from_file(test_file);
    one_likelyhood = get_likelyhood(mfccs, one)
    two_likelyhood = get_likelyhood(mfccs, two)
    three_likelyhood = get_likelyhood(mfccs, three)

    likelyhoods = [one_likelyhood two_likelyhood three_likelyhood]

    results(i) = find(likelyhoods == max(likelyhoods));
end

results
