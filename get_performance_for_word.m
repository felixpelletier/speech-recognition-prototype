function [ success, file_count ] = get_performance_for_word( word, trained_matrices, truth_index, count, start_index, varargin )

parser = inputParser;
addParameter(parser,'NumberMFCCKept', 12);
addParameter(parser,'NumberMFCCCalculated', 26);
addParameter(parser,'MinimumAmplitude', -40);
parse(parser, varargin{:});
args = parser.Results;

test_files = get_files_for_word(word);
success = 0;
file_count = 0;
for i = start_index:start_index+count
    test_file = test_files{i};
    mfccs = get_mfccs_from_file(test_file, ...
                'NumberMFCCKept', args.NumberMFCCKept, ...
                'NumberMFCCCalculated', args.NumberMFCCCalculated, ...
                'MinimumAmplitude', args.MinimumAmplitude ...
    );
    likelyhoods = [];
    for j = 1:length(trained_matrices)
        likelyhood = get_likelyhood(mfccs, trained_matrices{j});
        likelyhoods = [likelyhoods likelyhood];
    end
    result_index = find(likelyhoods == max(likelyhoods));
    if (result_index == truth_index)
        success = success + 1;
    end
    file_count = file_count + 1;
end

end

