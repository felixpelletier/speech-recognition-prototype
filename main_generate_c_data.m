 vFILE_COUNT = 250;
FILE_COUNT_FOR_TRAINING = 50;

%one = get_trained_matrix('google_dataset/one', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MaxNumberOfFiles', FILE_COUNT_FOR_TRAINING);
%two = get_trained_matrix('google_dataset/two', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MaxNumberOfFiles', FILE_COUNT_FOR_TRAINING);
%three = get_trained_matrix('google_dataset/three', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MaxNumberOfFiles', FILE_COUNT_FOR_TRAINING);
        
word = {'one', 'two', 'three'};
trained_matrices = {one, two, three};

generate_c_data(word, trained_matrices, 'c_version/training_data');