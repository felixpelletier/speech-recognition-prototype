function [ mfccs ] = get_mfccs_from_file( file_path )

mfcc_count = 12;
mfccs = zeros(mfcc_count, 0);
[audio, Fs] = audioread(file_path);
slices = zeros(400, 0);
for j = 400:160:length(audio)
    slice = audio(j-400+1:j);
    slices = [slices slice];
end
for j = 1:size(slices, 2)
    slice = slices(:, j);
    amplitude = 20*log10(sqrt(sum(slice.^2)/400));
    if (amplitude > -30)
        mfcc = get_mfcc(slice);
        mfccs = [mfccs mfcc];
    end
end

end