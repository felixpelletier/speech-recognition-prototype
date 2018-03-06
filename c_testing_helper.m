one = get_trained_matrix('google_dataset/one');

generate_c_data( {'clic'}, {one}, 'c_version/training_data' );

'Done Training'

%test_file = 'google_dataset/one/00176480_nohash_0.wav';
%mfccs = get_mfccs_from_file(test_file);
%mfccs = mfccs(:, 1:2);
test_data = zeros(400, 1);
test_data(1:150) = 1;
mfccs = get_mfcc(test_data);
one_likelyhood = get_likelyhood(mfccs, one)
