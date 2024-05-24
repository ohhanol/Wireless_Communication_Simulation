clear; clc;

SNR = -12:-2;
SG=16;
idx1 =3;
idx2 =4;
N=100000;

BER_hada=zeros(1,length(SNR)); % hadamard
BER_PN=zeros(1,length(SNR)); % PN

for i=1:length(SNR) %Hadamard
    data1_h=randint(1,N);   % �����1�� �۽� ������ ����
    data2_h=randint(1,N);   % �����2�� �۽� ������ ����

    % QPSK mapping
    x1_h = QPSK_mapper(data1_h);
    x2_h = QPSK_mapper(data2_h);
    
    % hadamard code Ȯ��
    y1_h = hadamard_sp(x1_h,SG,idx1);
    y2_h = hadamard_sp(x2_h,SG,idx2);
    y_h=y1_h+y2_h;        
    
    % AWGN ä�� ���
    z_h=AWGN(y_h,SNR(i));

    % hadamard code ��Ȯ�� (idx1 ���)
    x1_h_=hadamard_desp(z_h,SG,idx1);   
    
    % QPSK demapping
    s1_h_=QPSK_demapper(x1_h_);
    
    % ������Ʈ �� BER ���
    biterror_h=sum(abs(data1_h-s1_h_));
    BER_hada(i)=biterror_h/N;   
    
end

for i=1:length(SNR) %PN
    data1_P=randint(1,N);   % �����1�� �۽� ������ ����
    data2_P=randint(1,N);   % �����2�� �۽� ������ ����

    % QPSK mapping
    x1_P = QPSK_mapper(data1_P);
    x2_P = QPSK_mapper(data2_P);    
    
    % PN code Ȯ��
    y1_P=PN_sp(x1_P,SG,idx1);
    y2_P=PN_sp(x2_P,SG,idx2);
    y_P = y1_P + y2_P;
    
    % AWGN ä�� ���
    z_P=AWGN(y_P,SNR(i));
    
    % PN code ��Ȯ�� (idx1 ���)
    x1_P_=PN_desp(z_P,SG,idx1);   
    
    % QPSK demapping
    s2_P_ = QPSK_demapper(x1_P_);
    
    % ������Ʈ �� BER ���
    biterror_P=sum(abs(data1_P-s2_P_));
    BER_PN(i)=biterror_P/N;       
   
end

semilogy(SNR,BER_hada)
hold on 
semilogy(SNR,BER_PN)
grid on
% xlim([-12 -2])
% ylim([-10^(-4) 1])
axis([-12 -2 10^(-4) 1]);
xlabel('SNR')
ylabel('BER')
title('two user CDMA without delay')
legend('hadamard','PN')