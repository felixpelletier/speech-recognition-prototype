OUT_PATH = 'performance_result.txt';
FILE_COUNT = 1000;
fclose(fopen(OUT_PATH,'w'));

for NumberMFCCCalculated = 13:30
    for NumberMFCCKept = 4:12
        one = get_trained_matrix('google_dataset/one', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated);
        two = get_trained_matrix('google_dataset/two', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated);
        three = get_trained_matrix('google_dataset/three', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated);
        
        trained_matrices = {one, two, three};

        [success_one, file_count_one] = get_performance_for_word('google_dataset/one', trained_matrices, 1, FILE_COUNT, 500, 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated);
        [success_two, file_count_two] = get_performance_for_word('google_dataset/two', trained_matrices, 2, FILE_COUNT, 500, 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated);
        [success_three, file_count_three] = get_performance_for_word('google_dataset/three', trained_matrices, 3, FILE_COUNT, 500, 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated);

        success = success_one + success_two + success_three;
        file_count = file_count_one + file_count_two + file_count_three;

        percentage = (success/file_count) * 100;
        
        fileID = fopen(OUT_PATH,'a');
        formatSpec = '%d; %d; %.4f\n';
        fprintf(fileID, formatSpec, NumberMFCCCalculated, NumberMFCCKept, percentage);
        fprintf(formatSpec, NumberMFCCCalculated, NumberMFCCKept, percentage);
        fclose(fileID);
    end
end
