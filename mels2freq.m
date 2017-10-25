function [ freq ] = mels2freq( mels )

freq = 700*(exp(mels/1125)-1);

end

