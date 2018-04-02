function [] = play_file( file_path )

[audio, Fs] = audioread(file_path);
player = audioplayer(audio, Fs);
playblocking(player);

end