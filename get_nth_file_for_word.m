function [ filepath ] = get_nth_file_for_word( n, word )

files = get_files_for_word(word);
filepath = files{n};

end

