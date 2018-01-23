function generate_c_data( trained_matrices, output_filename )

header_name = strcat(output_filename, '.h');
source_name = strcat(output_filename, '.c');

fileId = fopen(output_filename, 'w');

for i = 1:length(trained_matrices)
    
end


fclose(fileId);

end

