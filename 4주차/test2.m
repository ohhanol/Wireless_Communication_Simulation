clear; clc;
SNR=10; % dB   

N=2000;     % message length in bits 
R=3; % 반복 횟수

%% BER 계산

x=randint(1,N);

% FEC Encoding
FEC_enc_out=zeros(1,R*N);
for n=1:R
    FEC_enc_out(N*(n-1)+1:N*n)=x;
end 

y=QPSK_mapper(x);

r=AWGN(y,SNR);

z=QPSK_demapper(r);

% FEC Decoding
% 누적해서 더하기
x_hat=zeros(1,N);
for n=1:R
    x_hat=x_hat+z(N*(n-1)+1:N*n);   % 다수결 하기 위해 일단 다 더해서 누적하기 0~R사이 값들로 채워질 거임
end

% 다수결의 원칙
for n=1:N
    if x_hat(n)>R/2
        x_hat(n)=1;
    else
        x_hat(n)=0;
    end
end

err_count=sum(abs(x-z));
BER=err_count/N;