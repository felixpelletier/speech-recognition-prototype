function [ trained_matrix, mfccs ] = get_trained_matrix( word )

number_of_files = 50;

files = get_files_for_word(word);

number_of_files = min([length(files), number_of_files]);

mfccs = zeros(0, 12);
for i = 1:number_of_files
    mfccs = [mfccs; get_mfccs_from_file(files{i})'];
end

options = statset('MaxIter', 10000);
trained_matrix = gmdistribution.fit(mfccs(:,1), 4, 'Options', options);

end

