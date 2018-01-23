

one = get_trained_matrix('google_dataset/one', 'NumberMFCCKept', 12, 'NumberMFCCCalculated', 26);
two = get_trained_matrix('google_dataset/two', 'NumberMFCCKept', 12, 'NumberMFCCCalculated', 26);
three = get_trained_matrix('google_dataset/three', 'NumberMFCCKept', 12, 'NumberMFCCCalculated', 26);

trained_matrices = {one, two, three};

'Done Training'

[success_one, file_count_one] = get_performance_for_word('google_dataset/one', trained_matrices, 1, 20, 1001);
[success_two, file_count_two] = get_performance_for_word('google_dataset/two', trained_matrices, 2, 20, 1001);
[success_three, file_count_three] = get_performance_for_word('google_dataset/three', trained_matrices, 3, 20, 1001);

success = success_one + success_two + success_three;
file_count = file_count_one + file_count_two + file_count_three;

percentage = (success/file_count) * 100
