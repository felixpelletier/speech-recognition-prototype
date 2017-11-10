function [ mfccs ] = get_mfccs_from_file( file_path )

mfcc_count = 12;
mfccs = zeros(mfcc_count, 0);
[audio, Fs] = audioread(file_path);
for j = 400:160:length(audio)
    slice = audio(j-400+1:j);
    amplitude = 20*log10(sqrt(sum(slice.^2)/400));
    if (amplitude > -45)
        mfcc = get_mfcc(slice);
        mfccs = [mfccs mfcc];
    end
end

d = diff(mfccs, 1,2);
dd = diff(mfccs, 2,2);
mfccs = [mfccs(:, 3:end); d(:, 2:end); dd];



end