clear; clc;
SNR = -10:10;
SG=8;
idx=2;
N=100000;

BER1=zeros(1,length(SNR)); % mapping�� Ȯ���� ��ġ�� ���� original data BER1
BER2=zeros(1,length(SNR)); % mapping + Ȯ���� ��ģ data BER2 (AWGN)
BER3=zeros(1,length(SNR)); % mapping + Ȯ���� ��ģ data BER3 (fading)


for i=1:length(SNR)

    s=randint(1, N);% ������ ����(randint ���)
    x=QPSK_mapper(s); % QPSK_mapping
    y=PN_sp(x,SG,idx); % PN Ȯ��

    % ���� ä�� (AWGN & fading)
    z_awgn=AWGN(x,SNR(i));
    z_PN_awgn=AWGN(y,SNR(i));
    z_PN_fading=fading(y,SNR(i));


    % PN ��Ȯ��
    x_PN_awgn=PN_desp(z_PN_awgn,SG,idx);
    x_PN_fading=PN_desp(z_PN_fading,SG,idx);


    % QPSK demapping
    s_awgn=QPSK_demapper(z_awgn);
    s_PN_awgn=QPSK_demapper(x_PN_awgn);
    s_PN_fading=QPSK_demapper(x_PN_fading);


    % ���� ��Ʈ & BER ���
    bit_error_awgn=sum(abs(s-s_awgn));
    bit_error_PN_awgn=sum(abs(s-s_PN_awgn));
    bit_error_PN_fading=sum(abs(s-s_PN_fading));
    
    BER1(i)=bit_error_awgn/N;
    BER2(i)=bit_error_PN_awgn/N;
    BER3(i)=bit_error_PN_fading/N;

end

semilogy(SNR,BER2)
hold on
semilogy(SNR,BER3)
hold on
semilogy(SNR,BER1)
grid on
xlabel('SNR')
ylabel('BER')
title('QPSK���� Ȯ�� �̵濡 ���� BER ���� ��')
legend('PN AWGN','PN fading', 'AWGN')