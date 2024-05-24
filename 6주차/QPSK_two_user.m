close all
clear

SNR = -10:10;
SG=8;
idx1=2;
idx2=3;
N=100000;

BER1=zeros(1,length(SNR)); % hadamard
BER2=zeros(1,length(SNR)); % PN

for SNR_loop=1:length(SNR) %Hadamard
    x1=randint(1,N);   % �����1�� �۽� ������ ����
    x2=randint(1,N);   % �����2�� �۽� ������ ����

    % QPSK mapping
    
    
    
    % hadamard code Ȯ��


    
    % AWGN ä�� ���
    
    
    
    % hadamard code ��Ȯ�� (idx1 ���)
    
    
    
    % QPSK demapping
    
    
    
    % ������Ʈ �� BER ���
    
    
    
    
    
end

for SNR_loop=1:length(SNR) %PN
    x1=randint(1,N);   % �����1�� �۽� ������ ����
    x2=randint(1,N);   % �����2�� �۽� ������ ����

    % QPSK mapping
    
    
    
    % PN code Ȯ��


    
    % AWGN ä�� ���
    
    
    
    % PN code ��Ȯ�� (idx1 ���)
    
    
    
    % QPSK demapping
    
    
    
    % ������Ʈ �� BER ���


    
   
end

semilogy(SNR,BER1) %BER ���� ���� �ʿ�
hold on 
semilogy(SNR,BER2) %BER ���� ���� �ʿ�
grid on
xlim([-10 10])
xlabel('SNR')
ylabel('BER')
title('two user CDMA �ۼ��ű� BER')
legend('hadamard','PN')