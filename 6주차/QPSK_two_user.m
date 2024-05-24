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
    x1=randint(1,N);   % 사용자1의 송신 데이터 생성
    x2=randint(1,N);   % 사용자2의 송신 데이터 생성

    % QPSK mapping
    
    
    
    % hadamard code 확산


    
    % AWGN 채널 통과
    
    
    
    % hadamard code 역확산 (idx1 사용)
    
    
    
    % QPSK demapping
    
    
    
    % 에러비트 및 BER 계산
    
    
    
    
    
end

for SNR_loop=1:length(SNR) %PN
    x1=randint(1,N);   % 사용자1의 송신 데이터 생성
    x2=randint(1,N);   % 사용자2의 송신 데이터 생성

    % QPSK mapping
    
    
    
    % PN code 확산


    
    % AWGN 채널 통과
    
    
    
    % PN code 역확산 (idx1 사용)
    
    
    
    % QPSK demapping
    
    
    
    % 에러비트 및 BER 계산


    
   
end

semilogy(SNR,BER1) %BER 변수 수정 필요
hold on 
semilogy(SNR,BER2) %BER 변수 수정 필요
grid on
xlim([-10 10])
xlabel('SNR')
ylabel('BER')
title('two user CDMA 송수신기 BER')
legend('hadamard','PN')