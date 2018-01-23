function [ trained_matrix ] = get_trained_matrix( word, varargin )

parser = inputParser;
addParameter(parser, 'NumberOfGaussians',4);
addParameter(parser, 'NumberMFCCKept', 12);
addParameter(parser, 'NumberMFCCCalculated', 26);
addParameter(parser, 'MaxNumberOfFiles', 100);
addParameter(parser, 'MinimumAmplitude', -40);
parse(parser, varargin{:});
args = parser.Results;

files = get_files_for_word(word);

number_of_files = min([length(files), args.MaxNumberOfFiles]);

mfccs = zeros(0, args.NumberMFCCKept);
for i = 1:number_of_files
    file_mfccs = get_mfccs_from_file( ...
                    files{i}, ...
                    'NumberMFCCKept', args.NumberMFCCKept, ...
                    'NumberMFCCCalculated', args.NumberMFCCCalculated, ...
                    'MinimumAmplitude', -40 ...
                 );
    mfccs = [mfccs; file_mfccs'];
end

options = statset('MaxIter', 10000);
trained_matrix = gmdistribution.fit(mfccs, args.NumberOfGaussians, 'CovType', 'diagonal', 'Options', options);

end

