%% Single User Case에서 PN vs. Hadamard
N=200000;
SG=8;
SNR=-10:10;
idx=2;

BER_orth=zeros(size(SNR));
BER_PN=zeros(size(SNR));

for i=1:length(SNR)
%%%%%%%%%%%% 송신기 %%%%%%%%%%%%%%
s=randint(1,N);
x=QPSK_mapper(s);

%%% 대역 확산 %%%
y1=hadamard_sp(x,SG,idx);
y2=PN_sp(x,SG,idx);

% 채널
z1=AWGN(y1,SNR(i));
z2=AWGN(y2,SNR(i));

%%%%%%%%%%%% 수신기 %%%%%%%%%%%%%%
x1_=hadamard_desp(z1,SG,idx);
x2_=PN_desp(z2,SG,idx);

s1_=QPSK_demapper(x1_);
s2_=QPSK_demapper(x2_);


% BER 계산
bit_error_orth=sum(abs(s-s1_));
bit_error_PN=sum(abs(s-s2_));

BER_orth(i)=bit_error_orth/N;
BER_PN(i)=bit_error_PN/N;
end


% Plot BER
semilogy(SNR, BER_orth, 'r*-', 'LineWidth', 2); hold on;
semilogy(SNR, BER_PN, 'b*-', 'LineWidth', 2);
xlabel('SNR(dB)');
ylabel('BER');
title('BER Curve for Single User Case', 'FontSize',13)
grid on;
legend('Hadamard', 'PN');
axis([-10 10 10^(-5) 1]);

%% 실습 3 : orthogonal code를 이용해 2명의 사용자 환경에서 CDMA 송수신기 완성하고 BER 비교하기
N=200000;
SG=8;
SNR=-10:10;
BER_orth_1=zeros(size(SNR));
BER_orth_2=zeros(size(SNR));

for i=1:length(SNR)
%%%%%%%%%%%% 송신기 %%%%%%%%%%%%%%

% 입력 data
s1=randint(1,N);
s2=randint(1,N);

x1=QPSK_mapper(s1);
x2=QPSK_mapper(s2);

%%% 대역 확산 %%%
y1=hadamard_sp(x1,SG,2);
y2=hadamard_sp(x2,SG,3);

% 두 사용자의 신호 더하기
y=y1+y2;

% 채널
z=AWGN(y,SNR(i));

%%%%%%%%%%%% 수신기 %%%%%%%%%%%%%%
x1_=hadamard_desp(z,SG,2);
x2_=hadamard_desp(z,SG,3);

s1_=QPSK_demapper(x1_);
s2_=QPSK_demapper(x2_);


% BER 계산
bit_error_orth_1=sum(abs(s1-s1_));
bit_error_orth_2=sum(abs(s2-s2_));

BER_orth_1(i)=bit_error_orth_1/N;
BER_orth_2(i)=bit_error_orth_2/N;
end


% Plot BER
semilogy(SNR, BER_orth_1, 'r*-', 'LineWidth', 2); hold on;
semilogy(SNR, BER_orth_2, 'b*-', 'LineWidth', 2);
xlabel('SNR(dB)');
ylabel('BER');
title('Spread Spectrum(Orthogonal) BER Curve', 'FontSize',13)
grid on;
legend('user1', 'user2');
axis([-10 10 10^(-5) 1]);