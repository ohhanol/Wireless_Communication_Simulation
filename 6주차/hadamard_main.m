close all
SNR = -10:10;
SG=8;
idx=2;
N=100000;

BER1=zeros(1,length(SNR)); % mapping�� Ȯ���� ��ġ�� ���� original data BER1
BER2=zeros(1,length(SNR)); % mapping + Ȯ���� ��ģ data BER2 (AWGN)
BER3=zeros(1,length(SNR)); % mapping + Ȯ���� ��ģ data BER3 (fading)


for i=1:length(SNR)

    %%%%% Tx %%%%%%
    s=randint(1, N);% ������ ����
    x=QPSK_mapper(s); % QPSK
    y=hadamard_sp(x,SG,idx); % hadamard Ȯ��

    % ���� ä��
    z_awgn=AWGN(x,SNR(i));
    z_hada_awgn=AWGN(y,SNR(i));
    z_hada_fading=fading(y,SNR(i));


    %%%%% Rx %%%%%%
    % hadamard ��Ȯ��
    x_hada_awgn=hadamard_desp(z_hada_awgn,SG,idx);
    x_hada_fading=hadamard_desp(z_hada_fading,SG,idx);

    % QPSK demapping
    s_awgn=QPSK_demapper(z_awgn);
    s_hada_awgn=QPSK_demapper(x_hada_awgn);
    s_hada_fading=QPSK_demapper(x_hada_fading);


    % ���� ��Ʈ & BER ���
    bit_error_awgn=sum(abs(s-s_awgn));
    bit_error_hada_awgn=sum(abs(s-s_hada_awgn));
    bit_error_hada_fading=sum(abs(s-s_hada_fading));
    
    BER1(i)=bit_error_awgn/N;
    BER2(i)=bit_error_hada_awgn/N;
    BER3(i)=bit_error_hada_fading/N;
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
legend('hada AWGN','hada fading', 'AWGN')