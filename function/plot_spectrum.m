function plot_spectrum(plot_var,Fs)

load window_h; 
window_h = window_h';
N_fft = 1024;
N_block = floor(length(plot_var)/(N_fft/2))-1;
for n=1:N_block
    block = plot_var(N_fft/2*(n-1)+1:N_fft/2*(n-1)+N_fft);
    if n==1
        spect = abs(fft(block.*window_h,N_fft));
    else
        spect = spect + abs(fft(block.*window_h,N_fft));
    end
end
spect = spect./N_block;
spect = fftshift(spect);
freq = ([0:N_fft-1]-N_fft/2)*Fs/N_fft;
figure;
plot(freq,20*log10(spect));
xlabel('Frquency (Hz)'); ylabel('Spectrum (dB)');
axis([-Fs/2 Fs/2 0 30]); grid on;