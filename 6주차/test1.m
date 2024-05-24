N=10000;
SG=8;
SNR=0;

% Tx
msg=randint(1,N);
x=QPSK_mapper(msg);
x_sp=hadamard_sp(x,SG,3);

% Channel
r=AWGN(x_sp, SNR);

% Rx
y=hadamard_desp(r,SG,3);    % 확산코드 idx 똑같아야 함
x_hat=QPSK_demapper(y);

BER=sum(abs(msg-x_hat))/N;
