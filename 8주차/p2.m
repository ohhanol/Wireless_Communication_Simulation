clear; clc;
SNR = -12:3;
SG=16;
idx=3;
N=100000;
h=[0.77, -0.55,0.33];

BER_hada=zeros(1,length(SNR)); %hadamard BER
BER_PN=zeros(1,length(SNR)); %PN code BER
BER_rake_hada=zeros(1,length(SNR)); %rake_hadamard BER
BER_rake_PN=zeros(1,length(SNR)); %rake_PN code BER

for i=1:length(SNR)
    
    % 1. Generate binary data
    s1=randint(1,N);     
    
    % 2. QPSK mapping
    x1=QPSK_mapper(s1);   % QPSK mapping

    % 3. hadamard & PN code spread
    y_hada=hadamard_sp(x1,SG,idx);
    y_PN=PN_sp(x1,SG,idx);

    % 4. multipath fading channel
    z_hada=multipath_fading(y_hada,h, SNR(i));
    z_PN=multipath_fading(y_PN,h, SNR(i));

    % 5. hadamard & PN code despread
    x_hada=hadamard_desp(z_hada,SG,idx);
    x_rake_hada=rake_hadamard(z_hada,h,SG,idx);
    x_PN_=PN_desp(z_PN,SG,idx);
    x_rake_PN_=rake_PN(z_PN,h,SG,idx);


    % 6. QPSK demapping
    s_hada_=QPSK_demapper(x_hada);
    s_rake_hada_=QPSK_demapper(x_rake_hada);
    s_PN_=QPSK_demapper(x_PN_);
    s_rake_PN_=QPSK_demapper(x_rake_PN_);



    % 7. BER
    bit_error_hada=sum(abs(s1-s_hada_));
    bit_error_rake_hada=sum(abs(s1-s_rake_hada_));
    bit_error_PN=sum(abs(s1-s_PN_));
    bit_error_rake_PN=sum(abs(s1-s_rake_PN_));

    BER_hada(i)=bit_error_hada/N;
    BER_rake_hada(i)=bit_error_rake_hada/N;
    BER_PN(i)=bit_error_PN/N;
    BER_rake_PN(i)=bit_error_rake_PN/N;
end


% Plot BER gragh
semilogy(SNR,BER_hada)
hold on 
semilogy(SNR,BER_rake_hada,'-.')
hold on
semilogy(SNR,BER_PN,'-o')
hold on 
semilogy(SNR,BER_rake_PN,'-*')
grid on
xlabel('SNR(dB)')
ylabel('BER')
title('mutipath fading에서 hada, PN 비교')
legend('hada','rake hada','PN','rake PN')
xlim([-12 0])