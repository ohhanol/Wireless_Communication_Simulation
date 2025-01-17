close all
SNR = -10:10;
SG=8;
idx=2;
N=100000;

BER1=zeros(1,length(SNR)); % mapping과 확산을 거치지 않은 original data BER1
BER2=zeros(1,length(SNR)); % mapping + 확산을 거친 data BER2 (AWGN)
BER3=zeros(1,length(SNR)); % mapping + 확산을 거친 data BER3 (fading)


for i=1:length(SNR)

    %%%%% Tx %%%%%%
    s=randint(1, N);% 데이터 생성
    x=QPSK_mapper(s); % QPSK
    y=hadamard_sp(x,SG,idx); % hadamard 확산

    % 잡음 채널
    z_awgn=AWGN(x,SNR(i));
    z_hada_awgn=AWGN(y,SNR(i));
    z_hada_fading=fading(y,SNR(i));


    %%%%% Rx %%%%%%
    % hadamard 역확산
    x_hada_awgn=hadamard_desp(z_hada_awgn,SG,idx);
    x_hada_fading=hadamard_desp(z_hada_fading,SG,idx);

    % QPSK demapping
    s_awgn=QPSK_demapper(z_awgn);
    s_hada_awgn=QPSK_demapper(x_hada_awgn);
    s_hada_fading=QPSK_demapper(x_hada_fading);


    % 에러 비트 & BER 계산
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
title('QPSK에서 확산 이득에 따른 BER 성능 비교')
legend('hada AWGN','hada fading', 'AWGN')