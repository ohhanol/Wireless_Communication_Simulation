clear; clc;
SNR = -10:10;
SG=8;
idx=2;
N=100000;
BER_ha=zeros(1,length(SNR));
BER_PN=zeros(1,length(SNR));

for i=1:length(SNR)
    s=randint(1,N);      % �۽� ������ ����
    x=QPSK_mapper(s);   % QPSK mapping

    % hadamard & PN code Ȯ��
    y_hada=hadamard_sp(x,SG,idx);
    y_PN=PN_sp(x,SG,idx);


    % AWGN ä�� ���
    z_hada=AWGN(y_hada,SNR(i));
    z_PN=AWGN(y_PN,SNR(i));


    % hadamard & PN code ��Ȯ��
    x_hada_=hadamard_desp(z_hada,SG,idx);
    x_PN_=PN_desp(z_PN,SG,idx);


    % QPSK demapping
    s_hada_=QPSK_demapper(x_hada_);
    s_PN_=QPSK_demapper(x_PN_);


    % ���� ��Ʈ & BER ���
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
title('single user CDMA �ۼ��ű� BER')
legend('hadamard','PN')