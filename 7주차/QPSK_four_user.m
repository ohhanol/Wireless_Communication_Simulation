clc
clear
close all

SNR = -12:-2;
SG=16;
idx1=3;
idx2=4;
idx3=5;
idx4=6;

N=100000;
BER_h=zeros(1,length(SNR));
BER_P=zeros(1,length(SNR));

for i=1:length(SNR) %Hadamard
    % user1, user2, user3, user4에 대한 data 랜덤 생성
    data1_h = randint(1,N);
    data2_h = randint(1,N);
    data3_h = randint(1,N);
    data4_h = randint(1,N);

    % mapping
    x1_h = QPSK_mapper(data1_h);
    x2_h = QPSK_mapper(data2_h);
    x3_h = QPSK_mapper(data3_h);
    x4_h = QPSK_mapper(data4_h);

    % spreading
    y1_h = hadamard_sp(x1_h,SG,idx1);
    y2_h = hadamard_sp(x2_h,SG,idx2);
    y3_h = hadamard_sp(x3_h,SG,idx3);
    y4_h = hadamard_sp(x4_h,SG,idx4);

    % delay
    y2_h = delay(y2_h,1);
    y3_h = delay(y3_h,2);
    y4_h = delay(y4_h,3);

    y_h = y1_h + y2_h + y3_h + y4_h;

    % AWGN 채널 통과
    z_h = AWGN(y_h,SNR(i));

    % despreading (idx1를 사용)
    r1_h = hadamard_desp(z_h,SG,idx1);

    % demapping
    s1_h = QPSK_demapper(r1_h);

    % error bit 계산 및 BER (user1의 BER 계산)
    biterror_h = sum(abs(data1_h - s1_h));
    BER_h(i) = biterror_h/N;
end


for i=1:length(SNR) %PN
    data1_P = randint(1,N);
    data2_P = randint(1,N);
    data3_P = randint(1,N);
    data4_P = randint(1,N);

    % mapping
    x1_P = QPSK_mapper(data1_P);
    x2_P = QPSK_mapper(data2_P);
    x3_P = QPSK_mapper(data3_P);
    x4_P = QPSK_mapper(data4_P);

    % spreading
    y1_P = PN_sp(x1_P,SG,idx1);
    y2_P = PN_sp(x2_P,SG,idx2);
    y3_P = PN_sp(x3_P,SG,idx3);
    y4_P = PN_sp(x4_P,SG,idx4);

    % delay
    y2_P = delay(y2_P,1);
    y3_P = delay(y3_P,2);
    y4_P = delay(y4_P,3);

    y_P = y1_P + y2_P + y3_P + y4_P;

    % AWGN 채널 통과
    z_P = AWGN(y_P,SNR(i));

    % despreading (idx1를 사용)
    r1_P = PN_desp(z_P,SG,idx1);

    % demapping
    s1_P = QPSK_demapper(r1_P);

    % error bit 계산 및 BER (user1의 BER 계산)
    biterror_P = sum(abs(data1_P - s1_P));
    BER_P(i) = biterror_P/N;
end



semilogy(SNR,BER_h,'-.')
hold on
semilogy(SNR,BER_P)
grid on
axis([-12 -2 1e-4  1 ])
xlabel('SNR')
ylabel('BER')
title('four user CDMA with delay')
legend('hadamard','PN')