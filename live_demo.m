NumberMFCCKept = 12;
NumberMFCCCalculated = 22;
MinimumAmplitude = -35;
MaxNumberOfFiles = 100;

words = {'accueil'; 'clic'; 'lacher'; 'retour'; 'tenir'};

accueil = get_trained_matrix('new_dataset/accueil', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MinimumAmplitude', MinimumAmplitude, 'MaxNumberOfFiles', MaxNumberOfFiles);
clic = get_trained_matrix('new_dataset/clic', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MinimumAmplitude', MinimumAmplitude, 'MaxNumberOfFiles', MaxNumberOfFiles);
lacher = get_trained_matrix('new_dataset/lacher', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MinimumAmplitude', MinimumAmplitude, 'MaxNumberOfFiles', MaxNumberOfFiles);
retour = get_trained_matrix('new_dataset/retour', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MinimumAmplitude', MinimumAmplitude, 'MaxNumberOfFiles', MaxNumberOfFiles);
tenir = get_trained_matrix('new_dataset/tenir', 'NumberMFCCKept', NumberMFCCKept, 'NumberMFCCCalculated', NumberMFCCCalculated, 'MinimumAmplitude', MinimumAmplitude, 'MaxNumberOfFiles', MaxNumberOfFiles);

fprintf('Done Training\n\n');

% Define system parameters
framesize = 80;       % Framesize (samples)
Fs = 16000;            % Sampling Frequency (Hz)
RUNNING = 1;          % A flag to continue data capture

% Setup data acquisition from sound card
ai = audiorecorder(Fs, 16, 1);

record(ai);

time_multiplier = 8;
samples_for_10ms = 0.01*Fs*time_multiplier;
samples_for_25ms = 0.025*Fs*time_multiplier;

buffer_25ms = zeros(samples_for_25ms, 1);
buffer_10ms = zeros(samples_for_10ms, 1);
buffer_10ms_index = 1;

newdata = zeros(0, 1);
newdata_index = 1;
last_datas = zeros(5, 1);

last_mfccs = zeros(12, 0);
last_detection = 0;
new_detection = 0;
frames_since_low_edge = 0;
is_recording = 0;
amplitude_threshold = -25;
last_amplitudes = -Inf*ones(1000/25, 1); % One new amplitude compute every 25ms
likelyhood_threshold = -80;
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
        
        amplitude = 20*log10(sqrt(sum(buffer_25ms.^2)/samples_for_25ms));
        
        %amplitude_threshold = mean(last_amplitudes) + 10;
        if (is_recording == 0 && amplitude > amplitude_threshold)
            is_recording = 1;
            frames_since_low_edge = 0;
            last_mfccs = zeros(12, 0);
        end
        
        if (is_recording == 0)
            %zero_crossings_when_low = zero_crossing_count(buffer_25ms)
        end
        
        if (is_recording)
            mfcc = get_mfcc(buffer_25ms, 'NumberMFCCCalculated', NumberMFCCCalculated);
            if (amplitude < amplitude_threshold)
                frames_since_low_edge = frames_since_low_edge + 1;
                if (frames_since_low_edge > 20)
                    is_recording = 0;
                    %last_mfccs = last_mfccs(:, 1:valid_mfccs);
                    if (1||size(last_mfccs, 2) > 10)
                        accueil_likelyhood = get_likelyhood(last_mfccs, accueil);
                        clic_likelyhood = get_likelyhood(last_mfccs, clic);
                        lacher_likelyhood = get_likelyhood(last_mfccs, lacher);
                        retour_likelyhood = get_likelyhood(last_mfccs, retour);
                        tenir_likelyhood = get_likelyhood(last_mfccs, tenir);
                        likelyhoods = [accueil_likelyhood clic_likelyhood lacher_likelyhood retour_likelyhood tenir_likelyhood];
                        %likelyhoods = likelyhoods/size(last_mfccs, 2);
                        fprintf('Normalized max likelyhood: %f\n', max(likelyhoods)/size(last_mfccs, 2));
                        fprintf('Likelyhoods: ');
                        disp(likelyhoods);
                        %likelyhood_sum = mean([one_likelyhood three_likelyhood])
                        if (max(likelyhoods) > likelyhood_threshold )
                            %last_datas = [last_datas(2:end); find(likelyhoods == min(likelyhoods))];
                            %last_detection = cputime;
                            %new_detection = 1;
                            found = find(likelyhoods == max(likelyhoods));
                            disp(words(found));
                        else
                            disp('Not recognized');
                        end
                    end
                end
            else
                %zero_crossings_when_high = zero_crossing_count(buffer_25ms)
                %plot(buffer_25ms)
                last_mfccs = [last_mfccs mfcc];
            end    
        end
        
        last_amplitudes = [last_amplitudes(2:end); amplitude];
        
        buffer_10ms_index = min([samples_for_10ms length(newdata)+1]);
        buffer_10ms(1:buffer_10ms_index-1) = newdata(1:buffer_10ms_index-1);
        newdata = newdata(buffer_10ms_index:end);
    else
        buffer_10ms(buffer_10ms_index:buffer_10ms_index+length(newdata)-1) = newdata;
        buffer_10ms_index = buffer_10ms_index+length(newdata);
        newdata = zeros(0, 1);
    end
    
%     if ((new_detection == 1) && (cputime > (last_detection+0.5)))
%         new_detection = 0;
%         if sum(last_datas==mode(last_datas)) > 3
%             detected = mode(last_datas)
%         end
%     end
end

% Stop acquisition
stop(ai);

% Disconnect/Cleanup
delete(ai);
clear ai;
