clear; clc;
SNR = -12:3;
SG=16;
idx=3;
N=100000;
h=[0.77, -0.55,0.33];

% BER_rake=zeros(1,length(SNR));
% BER_PN=zeros(1,length(SNR));

BER_hada=zeros(1,length(SNR)); %hadamard BER
BER_PN=zeros(1,length(SNR)); %PN code BER

for i=1:length(SNR)
    
    % 1. Generate binary data
    s=randint(1,N);     
    
    % 2. QPSK mapping
    x=QPSK_mapper(s);   % QPSK mapping

    % 3. hadamard & PN code spread
    y_hada=hadamard_sp(x,SG,idx);
    y_PN=PN_sp(x,SG,idx);

    % 4. multipath fading channel
    z_hada=multipath_fading(y_hada,h, SNR(i));
    z_PN=multipath_fading(y_PN,h, SNR(i));

    % 5. hadamard & PN code despread
    % x_hada_=hadamard_desp(z_hada,SG,idx);
    x_hada_=rake_hadamard(z_hada,h,SG,idx);
    x_PN_=PN_desp(z_PN,SG,idx);


    % 6. QPSK demapping
    s_rake_=QPSK_demapper(x_hada_);
    s_PN_=QPSK_demapper(x_PN_);


    % 7. BER
    bit_error_hada=sum(abs(s-s_rake_));
    bit_error_PN=sum(abs(s-s_PN_));

    BER_hada(i)=bit_error_hada/N;
    BER_PN(i)=bit_error_PN/N;

end


% Plot BER gragh
semilogy(SNR,BER_hada,'-.')
hold on 
semilogy(SNR,BER_PN)
grid on
xlabel('SNR')
ylabel('BER')
title('mutipath fading에서 hada, PN 비교')
legend('hada ','PN')
xlim([-12 0])