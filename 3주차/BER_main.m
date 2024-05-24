clear; clc;
% 생성할 데이터 비트 수
N=1000000;

% SNR 범위 정의
SNR_dB=0:11; % dB

BER_curve = zeros(size(SNR_dB));

%% BER 계산
for i=1:length(SNR_dB)
    
    % 1. 송신 메시지 비트 생성
    x=randint(1,N);

    % 2. QPSK 변조 (복소수 심볼 생성)
    y=QPSK_mapper(x);

    % 3. AWGN 채널 통과 후 수신신호 r [r(n) = y(n) + z(n)]
    r=AWGN(y,SNR_dB(i));

    % 4. QPSK 복조
    x_hat=QPSK_demapper(r);


    % 5. BER 계산
    error_count=sum(abs(x(:)-x_hat(:)));
    BER_curve(i)=error_count/N;

end

%% BER 출력
semilogy(SNR_dB, BER_curve, 'b');
xlabel('SNR(dB)');
ylabel('BER');
title('BER Curve for AWGM Channel');
grid on;
ylim([10^(-4) 1]);
xlim([0 11]);