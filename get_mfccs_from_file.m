function [ mfccs ] = get_mfccs_from_file( file_path, varargin )

parser = inputParser;
addParameter(parser,'NumberMFCCKept', 12);
addParameter(parser,'NumberMFCCCalculated', 26);
addParameter(parser,'MinimumAmplitude', -40);
parse(parser, varargin{:});
args = parser.Results;

mfcc_count = args.NumberMFCCKept;
mfccs = zeros(mfcc_count, 0);
[audio, Fs] = audioread(file_path);

% Peak normalization
audio = audio/max(audio);

slices = zeros(400, 0);
for j = 400:160:length(audio)
    slice = audio(j-400+1:j);
    slices = [slices slice];
end
for j = 1:size(slices, 2)
    slice = slices(:, j);
    amplitude = 20*log10(sqrt(sum(slice.^2)/400));
    if (amplitude >= args.MinimumAmplitude)
        mfcc = get_mfcc(slice, 'NumberMFCCKept', args.NumberMFCCKept, 'NumberMFCCCalculated', args.NumberMFCCCalculated);
        mfccs = [mfccs mfcc];
    end
end

end