%one = get_trained_matrix('google_dataset/one');
%two = get_trained_matrix('google_dataset/two');
%three = get_trained_matrix('google_dataset/three');

'Done Training'

% Define system parameters
framesize = 80;       % Framesize (samples)
Fs = 16000;            % Sampling Frequency (Hz)
RUNNING = 1;          % A flag to continue data capture

% Setup data acquisition from sound card
ai = audiorecorder(Fs, 16, 1);

record(ai);

samples_for_10ms = 0.01*Fs;
samples_for_25ms = 0.025*Fs;

buffer_25ms = zeros(samples_for_25ms, 1);
buffer_10ms = zeros(samples_for_10ms, 1);
buffer_10ms_index = 1;

newdata = zeros(0, 1);
newdata_index = 1;
last_datas = zeros(5, 1);

last_mfccs = zeros(12, 5);
last_detection = 0;
new_detection = 0;
% Keep acquiring data while "RUNNING" ~= 0
while RUNNING
    % Acquire new input samples
    if (get(ai, 'TotalSamples') > 0)
        full_audio_data = getaudiodata(ai);
        partial_audio_data = full_audio_data(newdata_index:end);
        newdata_index = newdata_index + length(partial_audio_data);
        newdata = [newdata; partial_audio_data];
    end
    data_until_buffer_full = samples_for_10ms-buffer_10ms_index+1;
    if length(newdata) >= data_until_buffer_full
        buffer_10ms(buffer_10ms_index:end) = newdata(1:data_until_buffer_full);
        newdata = newdata(data_until_buffer_full+1:end);
        
        buffer_25ms = [buffer_25ms(samples_for_10ms+1:end); buffer_10ms];
        mfcc = get_mfcc(buffer_25ms);
        last_mfccs = [last_mfccs(:, 2:end) mfcc];
        if (mfcc(1) > -25)
            one_likelyhood = get_likelyhood(last_mfccs, one);
            two_likelyhood = get_likelyhood(last_mfccs, two);
            three_likelyhood = get_likelyhood(last_mfccs, three);
            likelyhoods = [one_likelyhood two_likelyhood three_likelyhood];
            most_likely = min(likelyhoods)/size(last_mfccs, 2);
            if (most_likely < 20)
                last_datas = [last_datas(2:end); find(likelyhoods == min(likelyhoods))];
                last_detection = cputime;
                new_detection = 1;
            end
        end
        
        buffer_10ms_index = min([samples_for_10ms length(newdata)+1]);
        buffer_10ms(1:buffer_10ms_index-1) = newdata(1:buffer_10ms_index-1);
        newdata = newdata(buffer_10ms_index:end);
    else
        buffer_10ms(buffer_10ms_index:buffer_10ms_index+length(newdata)-1) = newdata;
        buffer_10ms_index = buffer_10ms_index+length(newdata);
        newdata = zeros(0, 1);
    end
    
    if ((new_detection == 1) && (cputime > (last_detection+0.5)))
        new_detection = 0;
        if sum(last_datas==mode(last_datas)) > 3
            detected = mode(last_datas)
        end
    end
end

% Stop acquisition
stop(ai);

% Disconnect/Cleanup
delete(ai);
clear ai;
