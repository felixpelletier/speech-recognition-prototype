function [ mfcc ] = get_mfcc( audio )

fourier_length = 256;
bank_count = 26;
fs = 16000;
upper_mels = freq2mels(fs/2);
lower_mels = freq2mels(300);
mels_bank = linspace(lower_mels, upper_mels, bank_count+2);
freq_bank = arrayfun(@(x) mels2freq(x), mels_bank);
freq_bank = floor((fourier_length*2+1)*freq_bank/fs);
banks = zeros(fourier_length, bank_count);
for i = 1:bank_count
    lower_freq = freq_bank(i);
    higher_freq = freq_bank(i+2);
    mid_freq = (lower_freq+higher_freq)/2;
    for j = lower_freq:higher_freq
        if (j < mid_freq)
            banks(j, i) = (j-lower_freq)/(mid_freq-lower_freq);
        else
            banks(j, i) = 1-((j-mid_freq)/(higher_freq-mid_freq));
        end
    end
    
end

mfcc_count = 12;
f_25ms = abs(fft(audio .* hamming(400), fourier_length*2)).^2;
f_25ms = f_25ms(1:fourier_length) ./ (fourier_length);
log_energy = zeros(bank_count, 1);
for k = 1:bank_count
    log_energy(k) = log10(sum(f_25ms.*banks(:,k)));
end
mfcc = dct(log_energy);
mfcc = mfcc(1:mfcc_count);

