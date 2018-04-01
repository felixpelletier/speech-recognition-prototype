function generate_c_data( words, trained_matrices, output_path )

assert(length(words) == length(trained_matrices));

header_path = strcat(output_path, '.h');
source_path = strcat(output_path, '.c');
[~, filename, ~] = fileparts(output_path);

guard_name = strcat('_DESIGNIV__', upper(filename), '__H_'); 
struct_name = 'word_training_gaussians';
substruct_name = 'word_training_gaussian';

NumVariables = trained_matrices{1}.NumVariables;
NumComponents = trained_matrices{1}.NumComponents;

headerId = fopen(header_path, 'w');

fprintf(headerId, '#ifndef %s \n#define %s\n\n', guard_name, guard_name);

fprintf(headerId, '#define TRAINING_DATA_MFCC_COUNT %i\n', NumVariables);
fprintf(headerId, '#define TRAINING_DATA_GAUSSIAN_COUNT %i\n', NumComponents);

fprintf(headerId, '\n');

fprintf(headerId, '#define TRAINING_DATA_WORD_COUNT %i\n', length(words));

fprintf(headerId, '\n');

for i = 1:length(words)
    fprintf(headerId, '#define TRAINING_DATA_%s %i\n', upper(words{i}), i-1);
end

fprintf(headerId, '\n');

fprintf(headerId, 'typedef struct %s {\n', substruct_name);
fprintf(headerId, '    float proportion;\n');
fprintf(headerId, '    float mu[TRAINING_DATA_MFCC_COUNT];\n');
fprintf(headerId, '    float sigma[TRAINING_DATA_MFCC_COUNT];\n');
fprintf(headerId, '} %s_t;\n', substruct_name);

fprintf(headerId, '\n');

fprintf(headerId, 'typedef struct %s {\n', struct_name);
fprintf(headerId, '    %s_t gaussians[TRAINING_DATA_GAUSSIAN_COUNT];\n', substruct_name);
fprintf(headerId, '} %s_t;\n', struct_name);

fprintf(headerId, '\n');

fprintf(headerId, 'extern const %s_t TRAINING_DATA[TRAINING_DATA_WORD_COUNT];\n', struct_name);

fprintf(headerId, '#endif //%s\n', guard_name);
fclose(headerId);

sourceId = fopen(source_path, 'w');

fprintf(sourceId, '#include "%s.h"\n\n', filename);

fprintf(sourceId, 'const %s_t TRAINING_DATA[] = {\n', struct_name);

for i = 1:length(words)
    trained_matrix = trained_matrices{i};
    fprintf(sourceId, '    {\n');
    fprintf(sourceId, '        {\n');
    for j = 1:trained_matrix.NumComponents
        fprintf(sourceId, '            {\n');
        fprintf(sourceId, '                %.6gf,\n', trained_matrix.ComponentProportion(j));
        fprintf(sourceId, '                {');
        for k = 1:trained_matrix.NumVariables
            fprintf(sourceId, '%.6gf', trained_matrix.mu(j, k));
            if (k < trained_matrix.NumVariables)
                fprintf(sourceId, ', ');
            end
        end
        fprintf(sourceId, '},\n');
        fprintf(sourceId, '                {');
        for k = 1:trained_matrix.NumVariables
            fprintf(sourceId, '%.6gf', trained_matrix.Sigma(1, k, j));
            if (k < trained_matrix.NumVariables)
                fprintf(sourceId, ', ');
            end
        end
        fprintf(sourceId, '}\n');
        fprintf(sourceId, '            },\n');
    end
    fprintf(sourceId, '        },\n');
    fprintf(sourceId, '    },\n');
end

fprintf(sourceId, '};\n');
fclose(sourceId);

end

