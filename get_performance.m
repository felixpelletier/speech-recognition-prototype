
NumberMFCCKept = 12;
NumberMFCCCalculated = 22;
MinimumAmplitude = -20;
MaxNumberOfFiles = 100;

one = get_trained_matrix('google_dataset/one', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MinimumAmplitude', MinimumAmplitude, 'MaxNumberOfFiles', MaxNumberOfFiles);
two = get_trained_matrix('google_dataset/two', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MinimumAmplitude', MinimumAmplitude, 'MaxNumberOfFiles', MaxNumberOfFiles);
three = get_trained_matrix('google_dataset/three', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MinimumAmplitude', MinimumAmplitude, 'MaxNumberOfFiles', MaxNumberOfFiles);

trained_matrices = {one, two, three};

'Done Training'

[success_one, file_count_one] = get_performance_for_word('google_dataset/one', trained_matrices, 1, 100, 1001, 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated);
[success_two, file_count_two] = get_performance_for_word('google_dataset/two', trained_matrices, 2, 100, 1001, 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated);
[success_three, file_count_three] = get_performance_for_word('google_dataset/three', trained_matrices, 3, 100, 1001, 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated);

success = success_one + success_two + success_three;
file_count = file_count_one + file_count_two + file_count_three;

percentage = (success/file_count) * 100
