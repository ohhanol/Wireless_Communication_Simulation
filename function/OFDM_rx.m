function output=OFDM_rx(x,h,fft_pt,L_cp)

x_cp= x(L_cp+1  :end  ); % remove cp 

y=1/sqrt(fft_pt)*fft(x_cp,fft_pt);

H=fft(h,fft_pt);%channel

output= y./H ; %EQ 

end