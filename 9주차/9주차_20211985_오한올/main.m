%% Week09 OFDM Practice
clear; clc;

% N = 64;
% N = 128;
N = 256;
N_fft = 512;

s = randint(1,N);
x = QPSK_mapper(s);

X = zeros(1,N_fft);
% X(1:N/2)=x; % 차례대로 할당

X(1:N/4) = x(1:N/4);    % 앞에 반절
X(end-N/4+1:end) =x(end-N/4+1:end);    % 뒤에 반절

x_tx = ifft(X,N_fft);
plot_spectrum(x_tx,10);



