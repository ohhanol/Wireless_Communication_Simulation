%% 실습 1: QAM_mapper() 함수 작성 후 16QAM 성상도 확인
clear; clc;

N=200000;
R=3;
SNR=20;

%%%%%%%%%%%%%%%%%%%% 송신기 %%%%%%%%%%%%%%%%%%%%%%%%%
% Binary Data 생성
data = randint(1,N);

% FEC Encoding 
x=FEC_enc(data,R);

% 16QAM 변조
y= QAM16_mapper(x);

% % AWGN channel 
% r=awgn(y, SNR);

plot(y,'ro');


