OUT_PATH = 'performance_result.txt';
FILE_COUNT = 250;
FILE_COUNT_FOR_TRAINING = 50;
fclose(fopen(OUT_PATH,'w'));

for NumberMFCCCalculated = 5:30
    max_kept = min(NumberMFCCCalculated-1, 12);
    for NumberMFCCKept = 2:max_kept
        one = get_trained_matrix('google_dataset/one', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MaxNumberOfFiles', FILE_COUNT_FOR_TRAINING);
        two = get_trained_matrix('google_dataset/two', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MaxNumberOfFiles', FILE_COUNT_FOR_TRAINING);
        three = get_trained_matrix('google_dataset/three', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MaxNumberOfFiles', FILE_COUNT_FOR_TRAINING);
        
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
