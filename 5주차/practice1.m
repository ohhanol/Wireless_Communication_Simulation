%% �ǽ� 1: QAM_mapper() �Լ� �ۼ� �� 16QAM ���� Ȯ��
clear; clc;

N=200000;
R=3;
SNR=20;

%%%%%%%%%%%%%%%%%%%% �۽ű� %%%%%%%%%%%%%%%%%%%%%%%%%
% Binary Data ����
data = randint(1,N);

% FEC Encoding 
x=FEC_enc(data,R);

% 16QAM ����
y= QAM16_mapper(x);

% % AWGN channel 
% r=awgn(y, SNR);

plot(y,'ro');


