function [ trained_matrix, delta_matrix, deltadelta_matrix] = get_trained_matrix( word )

number_of_files = 50;

files = get_files_for_word(word);

number_of_files = min([length(files), number_of_files]);

mfccs = zeros(0, 36);
for i = 1:number_of_files
    mfccs = [mfccs; get_mfccs_from_file(files{i})'];
end

options = statset('MaxIter', 10000);
trained_matrix = gmdistribution.fit(mfccs(:, 1:12), 4, 'Options', options);
delta_matrix = gmdistribution.fit(mfccs(:, 13:24), 4, 'Options', options);
deltadelta_matrix = gmdistribution.fit(mfccs(:, 25:36), 4, 'Options', options);

end

