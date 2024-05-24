%% 실습3: Plot Fading BER Curve with 16QAM
clear; clc;

N=200000;
R=3;
SNR=0:3:30;

BER_NoFEC = zeros(size(SNR));
BER_FEC = zeros(size(SNR));

for i=1:length(SNR)
    %%%%%%%%%%%%%%%%%%%% 송신기 %%%%%%%%%%%%%%%%%%%%%%%%%
    % Binary Data 생성
    data = randint(1,N);
    % FEC Encoding
    data_FEC=FEC_enc(data,R);

    % 16QAM Encoding
    symbol_NoFEC= QAM16_mapper(data);
    symbol_FEC=QAM16_mapper(data_FEC);

    % Fading Channel
    r_NoFEC=fading(symbol_NoFEC,SNR(i));
    r_FEC=fading(symbol_FEC,SNR(i));


    %%%%%%%%%%%%%%%%%%%% 수신기 %%%%%%%%%%%%%%%%%%%%%%%%%
    % 16QAM Decoding
    x_hat=QAM16_demapper(r_NoFEC);
    x_hat_FEC=QAM16_demapper(r_FEC);

    % FEC Decoding
    data_=FEC_dec(x_hat_FEC,R);

    % BER 계산
    bit_errors_NoFEC = sum(abs(data-x_hat));
    bit_errors_FEC = sum(abs(data-data_));

    BER_NoFEC(i) = bit_errors_NoFEC / N;
    BER_FEC(i) = bit_errors_FEC / N;

end


% Plot BER
semilogy(SNR, BER_NoFEC, 'r-', 'LineWidth', 1); hold on;
semilogy(SNR, BER_FEC, 'b-', 'LineWidth', 1);
xlabel('SNR(dB)');
ylabel('BER');
title('BER Curve(QAM16:fading)', 'FontSize',13)
grid on;
legend('fading, without FEC', 'fading, R=3')
ylim([10^(-5) 1]);
xlim([0 30]);