function [ trained_matrix ] = get_trained_matrix( word )

number_of_files = 1000;

files = get_files_for_word(word);

number_of_files = min([length(files), number_of_files]);

trained_matrix = zeros(12, 0);
for i = 1:number_of_files
    trained_matrix = [trained_matrix get_mfccs(files{i})];
end

end

