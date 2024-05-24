%% 실습 3:  FEC_enc / FEC_dec 함수 작성
clear; clc;

N=2000;
SNR=10;
R=3;

msg=randint(1,N);
x=FEC_enc(msg, R);
y=QPSK_mapper(x);

z=AWGN(y,SNR);

x_=QPSK_demapper(z);
msg_=FEC_dec(x_, R);

err_count=sum(abs(msg-msg_));
BER=err_count/N;
