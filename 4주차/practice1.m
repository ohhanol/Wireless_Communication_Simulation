%% 실습 1:  fading 함수 작성
clear; clc;

N=1000;
SNR=20;
x=randint(1,N);
y=QPSK_mapper(x);
r=fading(y,SNR);
plot(r,'r.');
axis([-2 2 -2 2]);