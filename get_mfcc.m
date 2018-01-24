function [ mfcc ] = get_mfcc( audio, varargin )

persistent fourier_length bank_count mfcc_count banks;

parser = inputParser;
addParameter(parser,'NumberMFCCKept', 12);
addParameter(parser,'NumberMFCCCalculated', 26);
addParameter(parser,'NormalizeMFCC', 1);
addParameter(parser,'TargetLogAmplitudeRMS', -20);
parse(parser, varargin{:});
args = parser.Results;

if isempty(banks) || bank_count ~= args.NumberMFCCCalculated || mfcc_count ~= args.NumberMFCCKept
    fourier_length = 256;
    bank_count = args.NumberMFCCCalculated;
    mfcc_count = args.NumberMFCCKept;
    fs = 16000;
    %upper_mels = freq2mels(fs/2);
    upper_mels = freq2mels(4000);
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
    
end

%target_amplitude = power(10, args.TargetLogAmplitudeRMS/20);
%amplitude = sqrt(mean(audio.^2));
%audio = audio*(target_amplitude/amplitude);
%amplitude = sqrt(mean(audio.^2));
%log_amplitude = 20*log10(amplitude)

audio = filter([1 -0.97], 1, audio);
f_25ms = abs(fft(audio .* hamming(length(audio)), fourier_length*2)).^2;
f_25ms = f_25ms(1:fourier_length) ./ (fourier_length);
log_energy = zeros(bank_count, 1);
for k = 1:bank_count
    log_energy(k) = log10(sum(f_25ms.*banks(:,k)));
end
mfcc = dct(log_energy);

%average = mfcc(1)
%mfcc = mfcc(1:mfcc_count);
mfcc = mfcc(2:mfcc_count+1);
if args.NormalizeMFCC
    %mfcc = 20 * mfcc / average;
end

