function [ ] = save_mfccs_to_file( file_path, mfccs )

fileID = fopen(file_path, 'w');
fclose(fileID);

for i=1:size(mfccs, 1)
    dlmwrite(file_path, mfccs(i,:), '-append');
end

end

