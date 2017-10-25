word = 'three';
number_of_files = 100;

files = dir(word);
files = extractfield(files(3:number_of_files+2), 'name');

fourier_length = 256;

for i = 1:number_of_files
    if(i == 11)
        filepath = strcat(word, '/', files{i});
        [audio, Fs] = audioread(filepath);
        fourier_2d = zeros(fourier_length, 0);
        for j = 161:160:length(audio)
            f_10ms = abs(fft(audio(j-160:j), fourier_length));
            f_10ms = f_10ms(1:fourier_length/2);
            f_10ms = diff(f_10ms);
            fourier_2d = [fourier_2d f_10ms];
        end
     end
end

figure
imshow(fourier_2d');

%[~, originalpos] = sort( average_fourier(1:fourier_length/2), 'descend' );
%p = Fs*originalpos(1:100)/fourier_length;
%p = sort(p)
 