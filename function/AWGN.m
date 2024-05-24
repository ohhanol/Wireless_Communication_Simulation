function CH_out = AWGN(CH_in,SNR)
% 가우시안 잡음 삽입
% SNR in dB

noise = sqrt(0.5*10^(-SNR/10))*(randn(1,length(CH_in)) + 1j*randn(1,length(CH_in)));

CH_out = CH_in + noise;
end