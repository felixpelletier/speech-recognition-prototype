function [ files ] = get_files_for_word( word )

files = dir(word);
files = extractfield(files(3:end), 'name');
files = arrayfun(@(x) strcat(word, '/', x), files); 
files = sort(files);

end

