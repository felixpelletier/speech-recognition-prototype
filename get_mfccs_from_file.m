function [ mfccs ] = get_mfccs_from_file( file_path )

mfcc_count = 12;
mfccs = zeros(mfcc_count, 0);
[audio, Fs] = audioread(file_path);
for j = 400:160:length(audio)
    slice = audio(j-400+1:j);
    mfcc = get_mfcc(slice);
    if (mfcc(1) > -25)
        mfccs = [mfccs mfcc];
    end
end

end