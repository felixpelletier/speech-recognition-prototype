%[one, mfccs] = get_trained_matrix('google_dataset/one');
%[two, mfccs_2] = get_trained_matrix('google_dataset/two');
%three = get_trained_matrix('google_dataset/three');

figure
subplot(1,2,1)
h1 = histogram(mfccs(:,1), 50, 'Normalization', 'pdf');
hold on
X = linspace(min(mfccs(:,1)), max(mfccs(:,1)), 10000);
pdf_one = pdf(one, X');
plot(X, pdf_one)
title('"One"')
xlabel('Valeur')
ylabel('Probabilité')

subplot(1,2,2)
hold on
h2 = histogram(mfccs_2(:,1), 50, 'Normalization', 'pdf');
X = linspace(min(mfccs_2(:,1)), max(mfccs_2(:,1)), 10000);
pdf_two = pdf(two, X');
plot(X, pdf_two)
title('"Two"')
xlabel('Valeur')
ylabel('Probabilité')

'Done Training'

stop()

test_files = get_files_for_word('google_dataset/one');
success = 0;
file_count = 0;
total = length(test_files)-100
for i = 1001:1201
    test_file = test_files{i};
    mfccs = get_mfccs_from_file(test_file);
    one_likelyhood = get_likelyhood(mfccs, one);
    two_likelyhood = get_likelyhood(mfccs, two);
    three_likelyhood = get_likelyhood(mfccs, three);
    likelyhoods = [one_likelyhood two_likelyhood three_likelyhood];
    digit = find(likelyhoods == max(likelyhoods));
    if (digit == 1)
        success = success + 1;
    end
    file_count = file_count + 1
end

(success/file_count) * 100
