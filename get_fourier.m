%one = get_trained_matrix('one');
%two = get_trained_matrix('two');
%three = get_trained_matrix('three');

'Done Training'

test_files = get_files_for_word('two');
success = 0;
file_count = 0;
total = length(test_files)-100
for i = 101:201
    test_file = test_files{i};
    mfccs = get_mfccs(test_file);
    one_likelyhood = get_likelyhood(mfccs, one);
    two_likelyhood = get_likelyhood(mfccs, two);
    three_likelyhood = get_likelyhood(mfccs, three);
    if (three_likelyhood < one_likelyhood && three_likelyhood < one_likelyhood)
        success = success + 1;
    end
    file_count = file_count + 1
end

(success/file_count) * 100

%[~, originalpos] = sort( average_fourier(1:fourier_length/2), 'descend' );
%p = Fs*originalpos(1:100)/fourier_length;
%p = sort(p)
 