clear; clc;

SNR=-10:20;
BER_QPSK_AWGN=zeros(size(SNR));
BER_QPSK_fading=zeros(size(SNR));
BER_OFDM_AWGN=zeros(size(SNR));
BER_OFDM_fading=zeros(size(SNR));

fft_pt = 256;
L_cp = 24;
h_AWGN=1; % AWGN
h_fading=[0.88 -0.44 0.11]; % Multipath_fading
loop=1000;
N=2*fft_pt; % 512

for i=1:length(SNR)
    for n = 1:loop
        %%%%%%% Tx %%%%%%% 
        % Data Generation
        msg = randint(1,N); % 1x512
              
        % QPSK mapping
        x = QPSK_mapper(msg);   % 1x256
        % 1x512
        x_long(1:N/4)=x(N/4+1:N/2);   % 1x512 <- 1x256
        x_long(N/4+1:N/2)=x(1:N/4);   
        
        % OFDM Transmitter
        y = OFDM_tx(x_long,fft_pt,L_cp);
        
        
        % Channel <AWGN / Multifading>
        % 1. Single Carrier QPSK 
        z1_AWGN = AWGN(x,SNR(i));   % 1x256
        z1_fading = multipath_fading(x,h_fading,SNR(i));
        % 2. OFDM QPSK
        z2_AWGN = AWGN(y,SNR(i));
        z2_fading = multipath_fading(y,h_fading,SNR(i));


        %%%%%%% Rx %%%%%%% 
        % OFDM Receiver
        r2_AWGN = OFDM_rx(z2_AWGN,h_AWGN,fft_pt,L_cp);          % 1x256
        r2_fading = OFDM_rx(z2_fading,h_fading,fft_pt,L_cp);    % 1x256

        x_short_AWGN=zeros(1,N/2);
        x_short_AWGN(N/4+1:N/2)=r2_AWGN(1:N/4); %  뽑기 <- 1x256개
        x_short_AWGN(1:N/4)=r2_AWGN(N/4+1:N/2);

        x_short_fading=zeros(1,N/2);
        x_short_fading(N/4+1:N/2)=r2_fading(1:N/4); % 1x256 <- 1x256
        x_short_fading(1:N/4)=r2_fading(N/4+1:N/2);
       
        % QPSK demapping
        % 1. Single Carrier QPSK 
        x1_AWGN = QPSK_demapper(z1_AWGN);
        x1_fading = QPSK_demapper(z1_fading);
        % 2. OFDM QPSK
        x2_AWGN = QPSK_demapper(x_short_AWGN);
        x2_fading = QPSK_demapper(x_short_fading);
        
        %%%%%% BER %%%%%%
        % 1. Single Carrier QPSK 
        errcount1_AWGN = sum(abs(msg - x1_AWGN));
        errcount1_fading = sum(abs(msg - x1_fading));
        % 2. OFDM QPSK
        errcount2_AWGN = sum(abs(msg - x2_AWGN));
        errcount2_fading = sum(abs(msg - x2_fading));
        
        % AWGN
        BER_QPSK_AWGN(i) = BER_QPSK_AWGN(i) + errcount1_AWGN;
        BER_OFDM_AWGN(i) = BER_OFDM_AWGN(i) + errcount2_AWGN;
        % Multipath fading
        BER_QPSK_fading(i) = BER_QPSK_fading(i) + errcount1_fading;
        BER_OFDM_fading(i) = BER_OFDM_fading(i) + errcount2_fading;
        
    end

    % AWGN
    BER_QPSK_AWGN(i) = BER_QPSK_AWGN(i)/N/loop;
    BER_OFDM_AWGN(i) = BER_OFDM_AWGN(i)/N/loop;
    % Multipath fading
    BER_QPSK_fading(i) =BER_QPSK_fading(i)/N/loop;
    BER_OFDM_fading(i) = BER_OFDM_fading(i)/N/loop;
    
    
end

semilogy(SNR, BER_QPSK_AWGN, 'b-')
grid on
xlabel('SNR');
ylabel('BER');

hold on
semilogy(SNR, BER_OFDM_AWGN, 'r-')
semilogy(SNR, BER_QPSK_fading, 'g-')
semilogy(SNR, BER_OFDM_fading, 'k-')

title('1user OFDM with AWGN & Multipath fading');
legend('Single carrier QPSK(AWGN)', 'OFDM QPSK(AWGN)', 'Single carrier QPSK(Multipath)', 'OFDM QPSK(Multipath)');
