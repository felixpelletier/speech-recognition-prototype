NumberMFCCKept = 12;
NumberMFCCCalculated = 22;
MinimumAmplitude = -35;
MaxNumberOfFiles = 100;

accueil = get_trained_matrix('new_dataset/accueil', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MinimumAmplitude', MinimumAmplitude, 'MaxNumberOfFiles', MaxNumberOfFiles);
clic = get_trained_matrix('new_dataset/clic', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MinimumAmplitude', MinimumAmplitude, 'MaxNumberOfFiles', MaxNumberOfFiles);
lacher = get_trained_matrix('new_dataset/lacher', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MinimumAmplitude', MinimumAmplitude, 'MaxNumberOfFiles', MaxNumberOfFiles);
retour = get_trained_matrix('new_dataset/retour', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MinimumAmplitude', MinimumAmplitude, 'MaxNumberOfFiles', MaxNumberOfFiles);
tenir = get_trained_matrix('new_dataset/tenir', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MinimumAmplitude', MinimumAmplitude, 'MaxNumberOfFiles', MaxNumberOfFiles);
        
words = {'accueil', 'clic', 'lacher', 'retour', 'tenir'};
trained_matrices = {accueil, clic, lacher, retour, tenir};

generate_c_data(words, trained_matrices, 'c_version/training_data');