%% Week 09 OFDM Practice
clear; clc;

% N = 64;
% N = 128;
N = 256;
N_fft = 512;

% 데이터 생성
s = randint(1,N);   % 256

% QPSK mapping
x = QPSK_mapper(s); % 128

% 서브캐리어 맵핑할 FFT 자리 512개 만들기?
X = zeros(1,N_fft);

% DSP 특성 상 
% 신호의 가운데를 비워두고 가장자리부터 채워야
% 신호 스펙트럼이 DC를 중심으로 대칭으로 나옴?
X(1:N/4) = x(1:N/4);                % 복소수 심볼 앞에 반절을 FFT 자리 앞쪽부터 채우기
X(end-N/4+1:end) =x(end-N/4+1:end); % 복소수 심볼 뒤에 반절을 FFT 자리 뒤쪽부터 채우기

% 서브캐리어 맵핑 규칙에 따라 맵핑한 N_fft를 IFFT?
x_tx = ifft(X,N_fft);

% 스펙트럼 출력
plot_spectrum(x_tx,10);



