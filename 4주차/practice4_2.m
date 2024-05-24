%% 실습 4:  AWGN / Fading 채널에서 FEC에 따른 BER 비교하기

%% 4-2) Fading 채널
clear; clc;
N=200000;
SNR=0:2:20;

BER_No_FEC = zeros(size(SNR));
BER_FEC3 = zeros(size(SNR));
BER_FEC5 = zeros(size(SNR));

for i=1:length(SNR)

    % 1. Binary data 생성
    data=randint(1,N);

    % 2. x = binary data를 R번 repeat
    x3=FEC_enc(data,3);
    x5=FEC_enc(data,5);

    % 3. QPSK mapping
    y_No=QPSK_mapper(data);
    y3=QPSK_mapper(x3);
    y5=QPSK_mapper(x5);

    % 4. z = fading 채널 통과한 신호
    z_No=fading(y_No,SNR(i));
    z3=fading(y3,SNR(i));
    z5=fading(y5,SNR(i));

    % 5. QPSK demapping
    x_No = QPSK_demapper(z_No);
    x3_ = QPSK_demapper(z3);
    x5_ = QPSK_demapper(z5);

    % 6. FEC decoding : 다수결 원칙에 따라 data 복조
    data3_ = FEC_dec(x3_,3);
    data5_ = FEC_dec(x5_,5);

    err_count_No = sum(abs(data-x_No));
    err_count3 = sum(abs(data-data3_));
    err_count5 = sum(abs(data-data5_));

    BER_No_FEC(i) = err_count_No/N;
    BER_FEC3(i) = err_count3/N;
    BER_FEC5(i) = err_count5/N;
end

% Plot BER
semilogy(SNR, BER_No_FEC, 'r-', 'LineWidth', 1);
hold on
semilogy(SNR, BER_FEC3, 'b-', 'LineWidth', 1);
hold on
semilogy(SNR, BER_FEC5, 'g-', 'LineWidth', 1);   

legend('without FEC', 'R=1/3', 'R=1/5');

grid on

title('Fading BER', 'fontsize', 14)
xlabel('SNR(dB)', 'FontSize', 14)
ylabel('Bit Error Ratio', 'FontSize', 14)
axis([0 20 1e-4 1])