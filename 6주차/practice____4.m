%% 실습 4 : PN code를 이용해 2명의 사용자 환경에서 CDMA 송수신기 완성하기
N=200000;
SG=8;
SNR=-10:10;
BER_PN_1=zeros(size(SNR));
BER_PN_2=zeros(size(SNR));

for i=1:length(SNR)
%%%%%%%%%%%% 송신기 %%%%%%%%%%%%%%

% 입력 data
s1=randint(1,N);
s2=randint(1,N);

x1=QPSK_mapper(s1);
x2=QPSK_mapper(s2);

%%% 대역 확산 %%%
y1=PN_sp(x1,SG,2);
y2=PN_sp(x2,SG,3);

% 두 사용자의 신호 더하기
y=y1+y2;

% 채널
z=AWGN(y,SNR(i));

%%%%%%%%%%%% 수신기 %%%%%%%%%%%%%%
x1_=PN_desp(z,SG,2);
x2_=PN_desp(z,SG,3);

s1_=QPSK_demapper(x1_);
s2_=QPSK_demapper(x2_);

% BER 계산
bit_error_PN_1=sum(abs(s1-s1_));
bit_error_PN_2=sum(abs(s2-s2_));

BER_PN_1(i)=bit_error_PN_1/N;
BER_PN_2(i)=bit_error_PN_2/N;
end


% Plot BER
semilogy(SNR, BER_PN_1, 'r*-', 'LineWidth', 2); hold on;
semilogy(SNR, BER_PN_2, 'b*-', 'LineWidth', 2);
xlabel('SNR(dB)');
ylabel('BER');
title('Spread Spectrum(PN Code) BER Curve', 'FontSize',13)
grid on;
legend('user1', 'user2');
axis([-10 10 10^(-5) 1]);