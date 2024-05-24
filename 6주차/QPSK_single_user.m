clear; clc;
SNR = -10:10;
SG=8;
idx=2;
N=100000;
BER_ha=zeros(1,length(SNR));
BER_PN=zeros(1,length(SNR));

for i=1:length(SNR)
    s=randint(1,N);      % 송신 데이터 생성
    x=QPSK_mapper(s);   % QPSK mapping

    % hadamard & PN code 확산
    y_hada=hadamard_sp(x,SG,idx);
    y_PN=PN_sp(x,SG,idx);


    % AWGN 채널 통과
    z_hada=AWGN(y_hada,SNR(i));
    z_PN=AWGN(y_PN,SNR(i));


    % hadamard & PN code 역확산
    x_hada_=hadamard_desp(z_hada,SG,idx);
    x_PN_=PN_desp(z_PN,SG,idx);


    % QPSK demapping
    s_hada_=QPSK_demapper(x_hada_);
    s_PN_=QPSK_demapper(x_PN_);


    % 에러 비트 & BER 계산
    bit_error_hada=sum(abs(s-s_hada_));
    bit_error_PN=sum(abs(s-s_PN_));

    BER_ha(i)=bit_error_hada/N;
    BER_PN(i)=bit_error_PN/N;

end
semilogy(SNR,BER_ha)
hold on
semilogy(SNR,BER_PN)
grid on
xlim([-10 10])
xlabel('SNR')
ylabel('BER')
title('single user CDMA 송수신기 BER')
legend('hadamard','PN')