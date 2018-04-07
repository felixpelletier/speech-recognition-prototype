NumberMFCCKept = 12;
NumberMFCCCalculated = 22;
MinimumAmplitude = -35;
MaxNumberOfFiles = 100;

accueil = get_trained_matrix('new_dataset/accueil', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MinimumAmplitude', MinimumAmplitude, 'MaxNumberOfFiles', MaxNumberOfFiles);
cliquer = get_trained_matrix('new_dataset/cliquer', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MinimumAmplitude', MinimumAmplitude, 'MaxNumberOfFiles', MaxNumberOfFiles);
lacher = get_trained_matrix('new_dataset/lacher', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MinimumAmplitude', MinimumAmplitude, 'MaxNumberOfFiles', MaxNumberOfFiles);
retour = get_trained_matrix('new_dataset/retour', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MinimumAmplitude', MinimumAmplitude, 'MaxNumberOfFiles', MaxNumberOfFiles);
tenir = get_trained_matrix('new_dataset/tenir', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MinimumAmplitude', MinimumAmplitude, 'MaxNumberOfFiles', MaxNumberOfFiles);
        
words = {'accueil', 'cliquer', 'lacher', 'retour', 'tenir'};
trained_matrices = {accueil, cliquer, lacher, retour, tenir};

generate_c_data(words, trained_matrices, 'c_version/training_data');