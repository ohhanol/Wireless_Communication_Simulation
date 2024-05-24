%% 실습 2:  AWGN과 Fading 채널의 BER 비교

clear; clc;
% SNR 범위 정의
SNR=0:2:20; % dB
N=100000;

BER_AWGN = zeros(size(SNR));
BER_Fading = zeros(size(SNR));

%% BER 계산
for i=1:length(SNR)

    % 1. 송신 메시지 비트 생성
    x=randint(1,N);

    % 2. QPSK 변조 (복소수 심볼 생성)
    y=QPSK_mapper(x);

    % 3. AWGN 채널 통과 후 수신신호 r [r(n) = y(n) + z(n)]
    r_fading=fading(y,SNR(i));
    r_AWGN=AWGN(y,SNR(i));

    % 4. QPSK 복조
    x_hat_fading=QPSK_demapper(r_fading);
    x_hat_AWGN=QPSK_demapper(r_AWGN);

    % 5. BER 계산
    error_count_fading=sum(abs(x(:)-x_hat_fading(:)));
    error_count_AWGN=sum(abs(x(:)-x_hat_AWGN(:)));

    BER_Fading(i)=error_count_fading/N;
    BER_AWGN(i)=error_count_AWGN/N;

end

%% BER 출력
semilogy(SNR, BER_AWGN, 'r-')
hold on;
semilogy(SNR, BER_Fading, 'b-');
xlabel('SNR(dB)');
ylabel('Bit Error Rate');
legend('AWGN', 'fading');
title('Practice 2')
grid on;
xlim([0 20]);
ylim([10^(-4) 1]);
