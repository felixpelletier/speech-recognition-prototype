function [ trained_matrix ] = get_trained_matrix( word )

number_of_files = 200;

files = get_files_for_word(word);

number_of_files = min([length(files), number_of_files]);

mfccs = zeros(0, 12);
for i = 1:number_of_files
    mfccs = [mfccs; get_mfccs_from_file(files{i})'];
end

options = statset('MaxIter', 10000);
trained_matrix = gmdistribution.fit(mfccs, 8, 'Options', options);


end

