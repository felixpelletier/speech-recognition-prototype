function [ mfccs ] = get_mfccs_from_file( file_path, varargin )

parser = inputParser;
addParameter(parser,'NumberMFCCKept', 12);
addParameter(parser,'NumberMFCCCalculated', 26);
addParameter(parser,'MinimumAmplitude', -40);
parse(parser, varargin{:});
args = parser.Results;

Fs = 16000;
time_multiplier = 8;
samples_for_10ms = 0.01*Fs*time_multiplier;
samples_for_25ms = 0.025*Fs*time_multiplier;

mfcc_count = args.NumberMFCCKept;
mfccs = zeros(mfcc_count, 0);
[audio, Fs] = audioread(file_path);

% Peak normalization
audio = audio/max(audio);

slices = zeros(samples_for_25ms, 0);
for j = samples_for_25ms:samples_for_10ms:length(audio)
    slice = audio(j-samples_for_25ms+1:j);
    slices = [slices slice];
end
for j = 1:size(slices, 2)
    slice = slices(:, j);
    amplitude = 20*log10(sqrt(sum(slice.^2)/samples_for_25ms));
    if (amplitude >= args.MinimumAmplitude)
        mfcc = get_mfcc(slice, 'NumberMFCCKept', args.NumberMFCCKept, 'NumberMFCCCalculated', args.NumberMFCCCalculated);
        mfccs = [mfccs mfcc];
    end
end

end