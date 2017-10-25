function [ mels ] = freq2mels( freq )

mels = 1125*log(1+(freq/700));

end

