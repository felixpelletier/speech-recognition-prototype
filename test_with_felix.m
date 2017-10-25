one = get_trained_matrix('one');
two = get_trained_matrix('two');
three = get_trained_matrix('three');

'Done Training'

test_files = {'felix_one.wav', 'felix_two.wav', 'felix_three.wav'};
results = zeros(length(test_files), 1);
for i = 1:length(test_files)
    test_file = test_files{i};
    mfccs = get_mfccs(test_file);
    one_likelyhood = get_likelyhood(mfccs, one)
    two_likelyhood = get_likelyhood(mfccs, two)
    three_likelyhood = get_likelyhood(mfccs, three)

    likelyhoods = [one_likelyhood two_likelyhood three_likelyhood];

    results(i) = find(likelyhoods == min(likelyhoods));
end

results