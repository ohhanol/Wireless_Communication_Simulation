function output=OFDM_tx(x,fft_pt,L_cp)
output=sqrt(fft_pt)*ifft(x,fft_pt); %Normalization
output=[output(end-L_cp+1:end) output];
end