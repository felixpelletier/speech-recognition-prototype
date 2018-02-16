%one = get_trained_matrix('google_dataset/one');

'Done Training'

test_file = 'google_dataset/one/00176480_nohash_0.wav';
mfccs = get_mfccs_from_file(test_file);
mfccs = mfccs(:, 1:2);
one_likelyhood = get_likelyhood(mfccs, one)
