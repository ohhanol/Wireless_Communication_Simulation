function plot_spectrum(plot_var,Fs)

% [pxx,f] = pwelch(x,window,noverlap,f,fs)

[pxx,f] = pwelch(plot_var,hanning(64),32,8192,Fs);

plot(f-max(f)/2, fftshift(pxx),'b','LineWidth',2);
grid on;